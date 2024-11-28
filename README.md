# MongoDB Replica Set Setup

Este projeto configura um ambiente de MongoDB utilizando **Replica Set** no Docker. Ele inclui a configuração do Docker Compose para criar três instâncias do MongoDB em um replica set e inicializar o ambiente com um script.

## Tecnologias Utilizadas

- **MongoDB**: Banco de dados NoSQL altamente escalável.
- **Docker & Docker Compose**: Ferramentas para criação e gerenciamento de contêineres.
- **Makefile**: Automação de tarefas, como inicialização do replica set e execução de scripts no MongoDB.

## Pré-requisitos

- **Docker** e **Docker Compose** instalados em sua máquina.
- **Make** instalado (para executar os comandos definidos no `Makefile`).

## Estrutura do Projeto

```
/base-mongodb-replicaset
├── /scripts
│   └── init_replica.js          # Script para inicializar o replica set no MongoDB
├── /docker-compose.yml          # Arquivo Docker Compose para orquestrar os contêineres
├── /Makefile                    # Arquivo de automação com tarefas para configurar o MongoDB
└── README.md                    # Este arquivo de documentação
```

## Como Configurar

### Passo 1: Subir os Contêineres com Docker Compose

Para subir os contêineres do MongoDB com Docker Compose, execute o seguinte comando:

```bash
make up
```

Isso irá iniciar os contêineres definidos no arquivo `docker-compose.yml`.

### Passo 2: Inicializar o Replica Set

Após iniciar os contêineres, você precisa configurar o MongoDB para funcionar em um **Replica Set**. O comando abaixo irá copiar o script de inicialização para o contêiner MongoDB e executar o comando para iniciar o replica set.

```bash
make init_replica
```

Isso irá garantir que o MongoDB seja configurado corretamente para operar como um replica set.

### Passo 3: Verificar o Status do Replica Set

Para verificar se o replica set foi configurado corretamente e se o MongoDB está funcionando como esperado, execute o seguinte comando:

```bash
make verify
```

Isso retornará o status do replica set, onde você poderá verificar o status de cada membro (primário e secundários).

## Como Funciona

- **Docker Compose**: O arquivo `docker-compose.yml` define três instâncias do MongoDB (`mongo1`, `mongo2`, e `mongo3`), que fazem parte de um replica set.
- **Replica Set**: Um replica set é um conjunto de instâncias MongoDB que mantêm o mesmo conjunto de dados. Uma das instâncias é o primário, e as outras são secundárias, replicando os dados do primário.
- **Makefile**: O `Makefile` automatiza os seguintes processos:
  - `make up`: Subir os contêineres do Docker Compose.
  - `make init_replica`: Copiar e executar o script para configurar o replica set no MongoDB.
  - `make verify`: Verificar o status do replica set.

## Comandos Disponíveis

- `make up`: Inicializa os contêineres do MongoDB.
- `make init_replica`: Copia o script de inicialização e configura o replica set.
- `make verify`: Verifica o status do replica set.
- `make down`: Para e remove os contêineres do Docker Compose.

## Exemplo de Uso

Após a configuração do MongoDB e a inicialização do replica set, você pode se conectar ao MongoDB e realizar operações como normalmente faria.

1. **Conectar ao MongoDB** com o `mongosh`:
   ```bash
   mongosh --host localhost --port 27017
   ```

2. **Criar um novo banco de dados** e adicionar um documento:
   ```javascript
   use test;
   db.instance.insertOne({ nome: "Exemplo", idade: 30 });
   ```

3. **Verificar o status do replica set**:
   ```javascript
   rs.status();
   ```

## Problemas Comuns

### Erro: `NotWritablePrimary`
Esse erro ocorre quando você tenta escrever em um nó que não é o primário do replica set. Certifique-se de que o nó para onde está tentando escrever é o primário.

**Solução**: Verifique qual nó é o primário com `rs.status()`.

### Erro: `WriteError{code=20, message='retryable writes is not supported for unreplicated ns: local. instance'}`
Esse erro acontece quando você tenta realizar uma operação de escrita na base de dados `local`, que não é adequada para dados da aplicação.

**Solução**: Certifique-se de que está escrevendo no banco de dados correto, como `test` ou qualquer outro banco de dados de sua escolha.
