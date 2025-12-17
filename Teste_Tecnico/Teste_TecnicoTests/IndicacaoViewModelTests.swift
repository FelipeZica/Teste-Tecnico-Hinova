//
//  IndicacaoViewModelTests.swift
//  Teste_TecnicoTests
//
//  Created by Luiz Felipe on 17/12/25.
//

import XCTest
@testable import Teste_Tecnico

@MainActor // Importante pois a ViewModel é @MainActor
final class IndicacaoViewModelTests: XCTestCase {
    
    var viewModel: IndicacaoViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = IndicacaoViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Testa se o botão de enviar fica desabilitado corretamente
    func testFormValidity() {
        // 1. Estado Inicial (Vazio) -> Deve ser Inválido
        XCTAssertFalse(viewModel.isFormValid, "O formulário deve começar inválido")
        
        // 2. Preenche parcialmente -> Ainda Inválido
        viewModel.nomeAmigo = "João"
        viewModel.emailAmigo = "joao@email.com"
        XCTAssertFalse(viewModel.isFormValid, "Falta telefone e placa")
        
        // 3. Preenche tudo -> Deve ser Válido
        viewModel.telefoneAmigo = "31999999999"
        viewModel.placaVeiculo = "ABC1234"
        XCTAssertTrue(viewModel.isFormValid, "O formulário deveria estar válido com todos os dados")
    }
    
    // Testa se o botão trava com email inválido
    func testInvalidEmailBlocksForm() {
        viewModel.nomeAmigo = "João"
        viewModel.telefoneAmigo = "31999999999"
        viewModel.placaVeiculo = "ABC1234"
        
        // Email errado
        viewModel.emailAmigo = "joao.com"
        
        XCTAssertFalse(viewModel.isFormValid, "O formulário deve ser inválido se o email estiver incorreto")
    }
}
