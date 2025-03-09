# Basic to do list

Este é um aplicativo Flutter para gerenciar tarefas de forma prática e intuitiva, com suporte para priorização, edição, exclusão, reordenação de tarefas e alternância entre temas claro e escuro.

## Recursos
- **Adição de Tarefas:** Crie novas tarefas informando o título e a prioridade.
- **Prioridade:** Defina prioridades como `Baixa`, `Média` ou `Alta` através de botões de rádio.
- **Reorganização:** Reordene as tarefas com arrastar e soltar.
- **Editar e Excluir:**
    - Deslize a tarefa para a esquerda para editar.
    - Deslize a tarefa para a direita para excluir.
- **Tema Claro/Escuro:** Alterne entre temas com um botão no canto superior direito.

## Instalação

1. Clone o repositório:
```bash
https://github.com/seu-usuario/seu-repositorio.git
```

2. Navegue até o diretório do projeto:
```bash
cd seu-repositorio
```

3. Instale as dependências:
```bash
flutter pub get
```

4. Execute o aplicativo:
```bash
flutter run
```

## Estrutura do Projeto
```
lib/
├── main.dart             # Arquivo principal do aplicativo
├── controllers/          # Contém os controladores (ex.: ThemeController, TodoController)
├── models/               # Modelos de dados (ex.: Todo)
└── pages/                # Páginas e telas (ex.: HomePage)
```

## Dependências Utilizadas
- [GetX](https://pub.dev/packages/get): Para gerenciamento de estado e navegação.
- [Material 3](https://m3.material.io/): Para a interface moderna com o Material Design 3.

## Como Utilizar
1. **Adicionar Tarefa:**
    - Clique no botão flutuante (`+`).
    - Insira o título da tarefa.
    - Selecione a prioridade.
    - Clique em `Adicionar`.

2. **Editar ou Excluir:**
    - Deslize uma tarefa para a esquerda para editar ou para a direita para excluir.

3. **Reordenar Tarefas:**
    - Segure e arraste as tarefas para reordená-las.

4. **Alternar Tema:**
    - Clique no ícone de brilho no canto superior direito para alternar entre o tema claro e escuro.

## Contribuição
Sinta-se à vontade para abrir um PR ou reportar issues.

## Licença
Este projeto está licenciado sob a licença MIT.

