import requests
import csv
import time
import concurrent.futures
import os
from pyquery import PyQuery as pq
from dotenv import load_dotenv

load_dotenv()

BASE_URL = os.environ.get("SCRAPE_BASE_URL")

def fetch_hrefs(url, element_classes_str):
    response = requests.get(url)

    if response.status_code == 200:
        html_content = response.text
        doc = pq(html_content)

        link_elements = doc(element_classes_str)

        items = []

        for link in link_elements:
            link_element = pq(link)  # Convert the element to a PyQuery object
            href = link_element.attr("href")
            if href:
                items.append(href)

        return items
    else:
        print(f"Failed to retrieve content from {url}. Status code: {response.status_code}")
        return []


def fetch_zipcode_info(url):
    response = requests.get(url)
    
    if response.status_code == 200:
        html_content = response.text
        doc = pq(html_content)

        zipcode = doc('h1').text().replace("CEP", "").strip()
        street = doc('p.title b:contains("Endereço:") + span').text()
        neighborhood = doc('p.title:contains("Bairro:")').text().replace("Bairro:", "").strip()
        city = doc('p.title b:contains("Cidade:") + span').text()
        state = doc('p.title b:contains("Estado:") + span').text()
        country = doc('p.title b:contains("País:") + span').text()
        latitude = doc('p.title:contains("Latitude IBGE:")').text().replace("Latitude IBGE:", "").strip()
        longitude = doc('p.title:contains("Longitude IBGE:")').text().replace("Longitude IBGE:", "").strip()

        return [zipcode, street, neighborhood, city, state, country, longitude, latitude]
    else:
        print(f"Failed to retrieve content from {url}. Status code: {response.status_code}")
        return []


def write_in_file(data):
    # Define the CSV filename
    csv_filename = "db/seeds/extracted_data.csv"

    # Save the data into a CSV file with headers
    with open(csv_filename, mode="w", newline="", encoding="utf-8") as csv_file:
        writer = csv.writer(csv_file)

        writer.writerow(["zipcode", "street", "neighbourhood", "city", "state", "country", "longitude", "latitude"])
        
        # Write the data rows
        writer.writerows(data)

    print(f"Data saved to {csv_filename}")
 
def perform_zipcode_scrapping(link):
    global BASE_URL
    
    zipcode_data = []
    zipcode_link_list = fetch_hrefs(f"{BASE_URL}/{link}", "div.col-md-6.coluna.coluna-cep a")
    
    for zipcode_link in zipcode_link_list:
        zipcode_info = fetch_zipcode_info(f"{BASE_URL}/{link}/{zipcode_link}")
        zipcode_data.append(zipcode_info)
    
    return zipcode_data

def perform():
    global BASE_URL
    
    start_time = time.time()
    zipcodes_data = []
    neighbourhood_link_list = fetch_hrefs(BASE_URL, "div.col-md-6.coluna a")
    
    #using concurrency to improve script performance
    with concurrent.futures.ThreadPoolExecutor() as executor:
        future_to_link = {executor.submit(perform_zipcode_scrapping, link): link for link in neighbourhood_link_list}
        
        for future in concurrent.futures.as_completed(future_to_link):
            link = future_to_link[future]
            try:
                zipcode_data = future.result()
                zipcodes_data.extend(zipcode_data)
                print(f"Data fetched for link: {link}")
            except Exception as e:
                print(f"Error fetching data for link {link}: {str(e)}")

    write_in_file(zipcodes_data)
    
    end_time = time.time()
    execution_time = end_time - start_time

    print(f"\nSuccess! Execution time: {execution_time} seconds")

perform()