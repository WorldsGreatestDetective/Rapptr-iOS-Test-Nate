//
//  MenuViewProtocol.swift
//  Rapptr iOS Test
//
//  Created by Nathan Reilly on 5/3/22.
//
/**
 On protocols and testing:
 
 If one is interested in building a more scalable and testable app, one can take a protocol oriented approach where say you can have view and viewModel protocols which can be used to build mock classes to create easy and reliable unit tests. Additionally when scaling the app to include new features one can simply write extensions to the protocol when implementing new features to views and viewModels
 
 I chose not to implment this fully since it seemed like overkill for the scope of this coding challenge, however this can still be seamlessly implemented.
**/

import Foundation

protocol MenuViewProtocol {
    func setController(controller: MenuViewController) 
}
