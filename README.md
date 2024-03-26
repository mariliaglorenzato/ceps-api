# **API de CEPs**

> Info: Acesse aqui: https://ceps-api-680659a3cc00.herokuapp.com/ 

Esta é uma API desenvolvida com Ruby on Rails para fornecer informações de CEPs da cidade de Caraguatatuba, São Paulo, Brasil. É possível amplicar o projeto e inserir novos ceps no banco. A API oferece dados detalhados sobre endereços correspondentes a códigos postais específicos dentro dessa região. Além disso, a estrutura da API foi pensada para facilitar sua ampliação, permitindo a inclusão de novas funcionalidades e expansão para outras localidades, se necessário.

## **Recursos Disponíveis**

- **Consulta de CEP**: Permite obter informações detalhadas sobre um CEP específico em Caraguatatuba.
- **Lista de CEPs**: Retorna uma lista de todos os CEPs disponíveis na base de dados.

## **Como Usar**

### **Requisitos**

- Docker
- Docker Compose

### **Configuração**

1. Clone este repositório para o seu ambiente local.
2. Navegue até o diretório do projeto.

### **Construção e Inicialização do Docker**

Para construir e iniciar os containers Docker, execute:

```bash
make setup 

```

Este comando irá construir as imagens necessárias e iniciar os containers para a aplicação Rails e para o banco de dados.

### **Criação do Banco de Dados**

Após os containers estarem em execução, abra um novo terminal e execute o seguinte comando para criar o banco de dados e executar as migrações:

```bash
docker-compose exec rails rails db:create db:migrate db:seed

```

### **Utilização da API**

```
make start
```

Com os containers em execução, a API estará disponível em **`http://localhost:3000`**.

### Rotas Disponíveis

- **`GET /zipcodes`** - Retorna uma lista de todos os CEPs disponíveis.
- Filtros (query params): "neighbourhood", "city"
- Obs: Atualmente a rota /zipcodes também é a rota padrão /

## **Contribuição**

Contribuições são bem-vindas! Sinta-se à vontade para propor melhorias, correções de bugs ou adicionar novos recursos. Basta seguir estas etapas:

1. Faça um fork deste repositório.
2. Crie uma branch para a sua feature (**`git checkout -b feature/MinhaFeature`**).
3. Faça commit das suas alterações (**`git commit -m 'Adiciona nova feature'`**).
4. Faça push para a branch (**`git push origin feature/MinhaFeature`**).
5. Abra um Pull Request.

O robô que busca os dados no site https://www.ruacep.com.br/sp/caraguatatuba está na pasta raíz e se chama scrapper.py

## **Licença**

Este projeto está licenciado sob a MIT License.