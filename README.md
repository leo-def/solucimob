

# Solução Imobiliária (solucimob)
Solução para mercado imobiliário

## Serviços

Serviços do ambiente solução imobiliária

| Serviço                        | Cod          | Descrição                                                                                             | Dependências  |
| ----------------------------- | ------------ | ----------------------------------------------------------------------------------------------------- |---------------------------------- |
| Serviço de cálculo *     | [solucimob-calc](./calc/README.md) | Serviço que executa os cálculos para a solução imobiliária                | solucimob-config |
| Serviço de configuração  | [solucimob-config](./config/README.md) | Serviço que gerência a configuração para a solução imobiliária                | |

## Acessos

Locais
Local | Descrição | Acesso | Responsável
--------- | ------ | ------ | ------
[Servidor visionamento](https://github.com/leo-def/solucimob) | Local aonde fica versionado o código | Conta particular | Admin, admin@admin.com
[Servidor produção](https://dashboard.heroku.com/apps/solucimob)| Local aonde é executado a aplicação em nível de produção | Conta particular | Admin, admin@admin.com
[Servidor homologação](https://dashboard.heroku.com/apps/solucimob)| Local aonde é executado a aplicação em nível de homologação | Conta particular | Admin, admin@admin.com
[Quadro de demandas](https://github.com/users/leo-def/projects/1)| Quadro aonde são definidas as demandas e seu status | Conta particular | Admin, admin@admin.com

## Scripts

 - **`dev`** - Executa o projeto localmente

## Funcionalidade de arquivos

 - **`.gitignore`** - [Git](https://git-scm.com/): Define os arquivos que serão ignorados pela ferramenta de versionamento do código;

 - **`docker-composer`** - [Docker](https://www.docker.com/): Define a configuração da ferramenta orquestração de container;
 
## Execução local

### Docker

- [Docker](https://www.docker.com/) Instalado
- [Docker compose](https://docs.docker.com/compose/install/) Instalado

- Executar o comando `npm run dev` ou`dokcer-compose up` na pasta raiz do projeto para executar a orquestração e inicialização dos containers;

### NodeJs
Requisitos:

- [Git](https://github.com/) Instalado
- [NodeJs](https://nodejs.org/en/)) Instalado

Etapas:
- Para cada serviço executar as seguintes etapas, sempre verificando as dependências dos serviços:
  - Executar o comando `npm install ` na pasta raiz do projeto para instalar as bibliotecas utilizadas;
  - Para executar o projeto `npm run dev `, para debugar o projeto `npm run debug `.

## Demandas

Etapas:

- **Encontrar cartão github** - Uma demanda deve ser encontrada em um cartão, na lista **`To do`**, no [quadro do projeto no Github](https://github.com/users/leo-def/projects/1)
- Converter o quadro em **issue**
- Assumir **issue**
- Criar branch - Usar o nome baseado no id do cartão `feature/:id-task`**
- Iniciar demanda - Arrastado o cartão para a coluna **`In Progress`** 
- Commitar as alterações - As alterações no código relacionadas a demanda devem ser enviadas via commit na nova branch
- Atualizar o cartão - Qualquer comentário, ou dúvida, deve ser inserido como um comentário na issue, mencionando as pessoas relacionadas digitando '@' e selecionando a pessoa. Caso algo bloqueie o avanço da demanda, arrastar o cartão para a lista **`Blocked`**
- Finalizar a demanda no quadro - Assim que finalizado o desenvolvimento arrastar o quadro para a lista **`Done`**, se por algum motivo a demanda for cancelada, o quadro deve ser arrastado para a branch **`Removed`**
- Realizar PullRequest para a Developer - Assim que finalizado o desenvolvimento, deve ser criado um PullRequest da branch atual para a developer, se por algum motivo a demanda for cancelada, a branch deve ser removida sem PullRequest
- Revisão do PullRequest - O Responsável pela revisão do PullRequest irá revisar e então, concluir ou rejeitar o PullRequest
- Atualizar o cartão com a revisão - O Responsável pela revisão do PullRequest irá colocar um comentário na issue descrevendo o resultado da review, e mencionando o desenvolvedor, caso concluído irá arrastar o cartão para **`Test`**
- Enviar para homologação - O Responsável pela homologação irá verificar os cartões em **`Test`**, caso esteja tudo certo, criar uma branch de release baseada na branch **`development`**, para depois fazer um merge para a branch criada e então criar um pull request para  **`master`**
- Atualizar os cartões para a homologação - O Responsável pela revisão do PullRequest irá colocar um comentário na issue descrevendo o resultado da homologação, e mencionando o desenvolvedor. Caso seja feito o PullRequest para master, arrastar os cartões de **`Test`** para **`Done`**, concluir pull request para **`master`**
- Atualizar versão de desenvolvimento - Criar um PullRequest da branch **`produção`** para a branch **`developer`**, para atualizar a versão do projeto dem desenvolvimento
