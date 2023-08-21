//
//  ResponseData.swift
//  ChallengeSwiftUI
//
//  Created by Bravo Oporto, Edgar Dick Irwin on 20/08/23.
//

import Foundation


struct ResponseData: Codable {
    let codigo: String
    let mensaje: String
    let folio: String
    let advertencia: String
    let resultado: Resultado
}

struct Resultado: Codable {
    let paginacion: Paginacion
    let categoria: String
    let productos: [Producto]
}

struct Paginacion: Codable {
    let pagina: Int
    let totalPaginas: Int
    let totalRegistros: Int
    let totalRegistrosPorPagina: Int
}

struct Producto: Codable, Hashable {
    let id: String
    let nombre: String
    let urlImagenes: [String]
    // Otras propiedades de producto que desees mostrar
}
