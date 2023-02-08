//
//  main.swift
//  BaekJoon#1927
//
//  Created by 김병엽 on 2023/02/09.
//

import Foundation

struct Heap<T> {
    var nodes: Array<T> = []
    let comparer: (T, T) -> Bool
    
    init(comparer: @escaping (T, T) -> Bool) {
        self.comparer = comparer
    }
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    func peek() -> T? {
        return nodes.first
    }
    
    mutating func insert(_ element: T) {
        var index = nodes.count
        
        nodes.append(element)
        
        while index > 0, comparer(nodes[index], nodes[(index - 1) / 2]) {
            nodes.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }
    
    mutating func delete() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }
        
        if nodes.count == 1 {
            return nodes.removeFirst()
        }
        
        let result = nodes.first
        nodes.swapAt(0, nodes.count - 1)
        _ = nodes.popLast()
        
        var index = 0
        
        while index < nodes.count {
            let left = index * 2 + 1
            let right = left + 1
            
            if right < nodes.count {
                if !comparer(nodes[left], nodes[right]), !comparer(nodes[index], nodes[right]) {
                    nodes.swapAt(index, right)
                    index = right
                } else if !comparer(nodes[index], nodes[left]) {
                    nodes.swapAt(index, left)
                    index = left
                } else {
                    break
                }
            }
            
            else if left < nodes.count {
                if !comparer(nodes[index], nodes[left]) {
                    nodes.swapAt(index, left)
                    index = left
                } else {
                    break
                }
            } else {
                break
            }
        }
        
        return result
    }
    
}

extension Heap where T: Comparable {
    init() {
        self.init(comparer: <)
    }
}

func solution() {
    
    var heap = Heap<Int>()
    
    let n = Int(readLine()!)!
    
    for _ in 0..<n {
        let input = Int(readLine()!)!
        
        if input == 0 {
            if heap.isEmpty { print(0) }
            else { print(heap.delete()!) }
        } else {
            heap.insert(input)
        }
    }
}

solution()
