//
//  SeedManager.swift
//  TunaSort iOS
//
//  Created by MAGH on 17/07/24.
//

import Foundation

class SeedManager {
    
    private var seeds: [Seed] = []
        
    func createSeed(_ seed: Seed) {
        seeds.append(seed)
    }
    
    func updateSeed(at index: Int, _ seed: Seed) {
        seeds[index] = seed
    }
    
    func deleteSeed(at index: Int) {
        seeds.remove(at: index)
    }
    
    func getSeeds() -> [Seed] {
        return seeds
    }
    
    func getSeed(at index: Int) -> Seed {
        return seeds[index]
    }
    
    func countSeeds() -> Int {
        return seeds.count
    }
    
}
