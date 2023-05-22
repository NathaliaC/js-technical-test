# js-technical-test

> Desafio: O seu desafio é construir uma API que conta o número de acessos ao site do Ton e permitir
que um usuário crie uma conta. Para contar os acessos você deverá usar a API
https://countapi.xyz. 

1. Criar uma rota para incrementar o número de acessos;
2. Criar uma rota para consultar o número de acessos;
3. Criar uma rota para criar um usuário;
4. Criar uma rota para visualizar as informações de um usuário. 

## Sobre o Projeto

Este projeto utiliza o Feathers, um framework de desenvolvimento de APIs em JavaScript. A escolha deste framework se deu por sua capacidade de fornecer uma infraestrutura básica de serviços e sua integração com diversas bibliotecas.

- Linguagem: Javascript.
- Framework: FeathersJS.
- Autenticação (@feathersjs/authentication-local e feathersjs/authentication-client): Optei pela combinação da autenticação local + JWT. A geração do token de autenticação é feita usando e-mail e senha, permitindo ao usuário acessar os dados cadastrados usando o token gerado ao se autenticar.
- serverless-http: Esta biblioteca é utilizada para auxiliar na comunicação entre a api gateway e a aplicação, convertendo os eventos lambda em requisições HTTP interpretáveis pelo FeathersJS.
- uuid: Utilizado para gerar os identificadores dos dados armazenados no DynamoDB.
- Terraform: Para criar a infraestrutura em nuvem, decidi usar o Terraform para ter mais granularidade na criação de cada recurso e devido à minha familiaridade com a ferramenta.

Não abordarei em detalhes todas as bibliotecas utilizadas, pois muitas delas são dependências do próprio framework. Para mais detalhes, consulte a documentação oficial.

O projeto é dividido em dois serviços: UsersService e VisitsService. UsersService gerencia as ações relacionadas ao registro e visualização de usuários, enquanto VisitsService controla as ações relacionadas à contagem de visitas ao site Ton.

### Observaçãoes: 
Para as tarefas de consulta e incremento do número de acessos ao site Ton, foi solicitado o uso da API https://countapi.xyz. Contudo, durante o desenvolvimento, essa API esteve indisponível. Assim, optei por uma abordagem alternativa para rastrear as visitas: quando a API estiver indisponível, a consulta será realizada em uma tabela local.

### Dependências Locais

Instalar o `npm` e o [Terraform](https://developer.hashicorp.com/terraform/downloads?ajs_aid=504d745c-a9d0-43f0-a902-8962b65f728b&product_intent=terraform).

## Para executar o projeto
> **Importante:** Certifique-se de que o aws-cli está corretamente configurado com suas credenciais.

> **Importante:** No arquivo de configuração infrastructure/terraform/locals.tf, a região da AWS está definida como us-east-2. Se necessário, altere-a para a região de sua preferência.

1. Na raiz do projeto, execute o seguinte comando:

    ```
    make build
    ```
2. Após a conclusão do build, serão gerados alguns outputs com a URL para cada endpoint.
3. Para excluir os recursos criados, execute o seguinte comando:
    ```
    make destroy
    ```

## Documentação

#### Postman 

Usei o Postman para documentar a API. Na pasta documentation/js-technical-test.postman_collection.json, disponibilizei um arquivo .json com as solicitações (requests).

Você também pode encontrar mais detalhes sobre como utilizar os recursos da API neste link: [Documentação](https://documenter.getpostman.com/view/1054289/2s93m32NzE ).

## Endpoints disponíveis na aws

Caso queira utitlizar vou deixar os endpoints disponíveis na aws.

- authentication_endpoint = "https://dt5o59kcxl.execute-api.us-east-2.amazonaws.com/prod/authentication"
- users_endpoint = "https://dt5o59kcxl.execute-api.us-east-2.amazonaws.com/prod/users"
- visits_endpoint = "https://dt5o59kcxl.execute-api.us-east-2.amazonaws.com/prod/visits"
