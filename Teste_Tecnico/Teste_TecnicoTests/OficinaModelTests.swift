//
//  OficinaModelTests.swift
//  Teste_TecnicoTests
//
//  Created by Luiz Felipe on 17/12/25.
//

import XCTest
@testable import Teste_Tecnico

final class OficinaModelTests: XCTestCase {

    func testDescricaoFormatada() {
        // Cenário: API retorna texto com quebras erradas e escapadas
        let descricaoSuja = "Linha 1/nLinha 2\\nLinha 3"
        
        // Mock simples do objeto
        let oficina = Oficina(
            id: 1, nome: "Teste", descricao: descricaoSuja, descricaoCurta: "",
            endereco: "", latitude: "", longitude: "", foto: "",
            avaliacaoUsuario: 5, email: nil, telefone1: nil, telefone2: nil, ativo: true
        )
        
        // Ação
        let resultado = oficina.descricaoFormatted
        
        // Verificação: Deve conter quebras de linha reais
        let esperada = "Linha 1\nLinha 2\nLinha 3"
        XCTAssertEqual(resultado, esperada, "A formatação da descrição falhou em corrigir os caracteres.")
    }
}
