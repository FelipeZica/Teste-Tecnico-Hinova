//
//  ExtensionsTests.swift
//  Teste_TecnicoTests
//
//  Created by Luiz Felipe on 17/12/25.
//

import XCTest
@testable import Teste_Tecnico

final class ExtensionsTests: XCTestCase {

    // Teste da Validação de Email
    func testEmailValidation() {
        XCTAssertTrue("teste@hinova.com.br".isValidEmail, "Email válido deve retornar true")
        XCTAssertFalse("teste@.com".isValidEmail, "Email sem domínio deve falhar")
        XCTAssertFalse("teste.com".isValidEmail, "Email sem @ deve falhar")
        XCTAssertFalse("".isValidEmail, "Email vazio deve falhar")
    }

    // Teste da Máscara de Telefone
    func testPhoneFormatting() {
        let input = "31999998888"
        let expected = "(31) 99999-8888"
        
        let result = input.formatPhone()
        
        XCTAssertEqual(result, expected, "A máscara de telefone não foi aplicada corretamente.")
    }
    
    // Teste de Limpeza de Números (usado no envio da API)
    func testNumbersOnly() {
        let input = "(31) 99999-8888"
        let expected = "31999998888"
        
        XCTAssertEqual(input.numbersOnly, expected, "A limpeza de caracteres especiais falhou.")
    }
}
