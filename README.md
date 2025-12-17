# Teste Técnico iOS - Hinova Mobile

Este projeto é um aplicativo iOS desenvolvido como parte do processo seletivo para a Hinova Mobile. O app permite consultar uma lista de oficinas credenciadas, visualizar detalhes, utilizar recursos de geolocalização e enviar indicações de amigos.

## Funcionalidades

* **Login:** Autenticação de usuário (Simulação via Session Manager).
* **Lista de Oficinas:** Listagem consumindo API REST, com filtros (Todas/Ativas).
* **Detalhes da Oficina:** Visualização completa com foto, avaliação, endereço e contatos.
* **Geolocalização:** Exibição do endereço atual do usuário (integração CoreLocation + MapKit) e coordenadas precisas.
* **Câmera:** Funcionalidade para captura de fotos (simulação de leitura de QRCode).
* **Indicação:** Formulário com validação de campos, máscaras de input (Telefone/Placa) e envio de dados para API.

## Arquitetura e Tecnologias

O projeto foi construído seguindo as melhores práticas de desenvolvimento moderno para iOS:

* **Arquitetura:** MVVM-C (Model-View-ViewModel + Coordinator).
    * *Decisão:* O uso do Coordinator desacopla a navegação das Views, facilitando a manutenção e testes.
* **Interface:** SwiftUI (com NavigationStack do iOS 16+).
* **Gerenciamento de Estado:** Combine (`@Published`, `ObservableObject`).
* **Networking:** Camada de serviço genérica com `async/await` e tratamento de erros customizado.
* **Testes:** Testes Unitários (XCTest) cobrindo regras de negócio, validações e extensions.

## Como Rodar o Projeto

### Pré-requisitos
* Xcode 14.0 ou superior.
* iOS 16.0+.

### Passos
1.  Clone este repositório.
2.  Abra o arquivo `Teste_Tecnico.xcodeproj`.
3.  Aguarde o carregamento dos pacotes (se houver).
4.  Selecione o simulador **iPhone 14 Plus** (recomendado para visualização ideal).
5.  Pressione `Cmd + R` para rodar.

### Notas sobre o Simulador
* **Câmera:** O simulador não possui câmera física. O app detecta isso e abre a Galeria de Fotos como fallback para evitar crashes.
* **GPS:** Para testar a localização, no menu do Simulador vá em: `Features` > `Location` > `Custom Location` (ou selecione uma pré-definida como Apple).

## Testes Unitários

O projeto inclui testes unitários focados na lógica de negócio e validação de dados. Para executá-los:
1.  No Xcode, pressione `Cmd + U`.
2.  Verifique a aba de "Reports" para ver o status dos testes (Validação de Email, Máscaras, Lógica de Texto).

---
Desenvolvido por **Luiz Felipe Alves Zica**.
