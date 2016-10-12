# Indexer

Indexer é um desafio em Ruby on Rails que visa o desenvolvimento de uma API REST.

Essa API deverá possuir dois endpoints:

* O primeiro endpoint é responsável por receber uma URL que indexará as tags HTML h1, h2 e h3;
* O segundo endpoint é responsável por retornar todos os dados já indexidos.

## Descrição da solução

Para facilitar na recuperação das informações todas as URLs foram consideradas HTTP e aquelas que faziam uso do protocolo HTTPS eram devidamente redirecionadas na hora da sua abertura.

A padronização das URLs como HTTP, ajudou também a evitar que informções duplicadas ficassem salvas no banco de dados, pois as tags da URL http://www.jovemnerd.com.br são as mesmas da URL https://www.jovemnerd.com.br, pois essas duas URLs por fim apontam para um único lugar.

O processo de extração das tags do HTML foi feito usando um método que recebe o contéudo da página e a tag a ser salva, a grande vantagem dessa abordagem é que se futuramente o usuário quiser expandir as tags procuradas isso poderá ser facilmente implementado alterando o array de tags a ser pesquisa. Isso abre também a possibilidade do endpoint no futuro receber um array de tags as quais o usuário deseja procurar.

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

O JSON a seguir deve ser passado como parâmetro:

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

Os testes foram criados usando o RSpec, a seguir está o comando necessáriso para execucação dos testes:

```
bundle exec rspec
```

## Construído com

* TextMate - editor de texto para macOS
* Postman - ferramenta para realizar requisições HTTP

## Autor

* **Itallo Rossi**
