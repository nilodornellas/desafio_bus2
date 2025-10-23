# 🚌 Desafio Técnico — Bus2

Este projeto foi desenvolvido como parte de um **desafio técnico da empresa Bus2**, utilizando **Flutter** e **Dart**.  
O objetivo principal é demonstrar boas práticas de arquitetura e gerenciamento de estado aplicadas a um app simples e funcional.

---

## 📱 Descrição do Aplicativo

O aplicativo exibe **pessoas aleatórias** obtidas de uma API externa.  
A cada **5 segundos**, uma nova pessoa é carregada automaticamente na tela inicial.  
O usuário pode:

- 👀 **Visualizar detalhes** completos de uma pessoa.  
- 💾 **Salvar pessoas favoritas** para consulta posterior.  
- 🗑️ **Remover pessoas salvas** da lista.  
- 🔁 **Navegar entre a lista principal** (com as pessoas aleatórias) e a **lista de pessoas salvas**.

---

## 🧩 Arquitetura

O projeto segue o padrão **MVVM (Model–View–ViewModel)** em conjunto com o **Repository Pattern**, garantindo uma estrutura modular, testável e de fácil manutenção.
