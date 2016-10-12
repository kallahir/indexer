# Indexer

Indexer é um desafio em Ruby on Rails que visa o desenvovilmento de uma API REST.

Essa API deverá possuir dois endpoints:

* O primeiro endpoint é responsável por receber uma URL que indexará as tags HTML h1, h2 e h3;
* O segundo endpoint é responsável por retornar todos os dados já indexidos.

## Pré-requisitos

Para executar o projeto e os testes será necessário ter instalado na sua máquina:

* Ruby, no mínimo a versão 2.2.2
* Rails 5.0

## Executando o projeto

Com os pré-requisitos configurados execute os passos a seguir.

No pasta do respositório clonado:

```
bundle install
rake db:create db:migrate
```

Para executar o servidor:

```
rails server
```

### Fazendo uso da API REST

#### Primeiro endpoint

O primeiro endpoint responsável por indexar as URLs, poderá ser acessado usando o método POST no seguinte caminho:

```
http://localhost:3000/urls

```

O JSON a seguir deve ser passado como parametro:

```
{
	"url_path": "https://www.URL_DESEJADA.com.br"
}
```

#### Segundo endpoint

O segundo endpoint responsável por retornar os dados indexados, poderá ser acessado usando o método GET no seguinte caminho:

```
http://localhost:3000/tags
```

## Executando os testes

```
EM DESENVOLVIMENTO...
```

## Construído com

* TextMate - editor de texto para macOS
* Postman - ferramenta para realizar requisições HTTP

## Autor

* **Itallo Rossi**
