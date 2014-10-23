// Playground - UF: Weighted quick-union by rank with path compression by halving.

import UIKit

class UF {
    var id: [Int] = []
    var rank: [Byte] = []
    var counter: Int = 0
    
    init(n: Int) {
        if (n < 0) {
            abort()
        }
        rank =  [Byte](count: n, repeatedValue: 0)
        for var i: Int = 0; i < n; i++ {
            id.append(i)
        }
        counter = n
    }
    
    func find(var p: Int) -> Int {
        if p < 0 || p >= id.count {
            abort()
        }
        
        while p != id[p] {
            id[p] = id[id[p]]
            p = id[p]
        }
        return p
    }
    
    func count() -> Int {
        return counter
    }
    
    func connected(p: Int, q: Int) -> Bool {
        return find(p) == find(q)
    }
    
    func union(p: Int, q: Int) {
        var i: Int = find(p)
        var j: Int = find(q)
        if i == j {
            return
        }
        
        if rank[i] < rank[j] {
            id[i] = j
        }
        else if rank[i] > rank[j] {
            id[j] = i
            
        }
        else {
            id[j] = i
            rank[i]++
        }
        counter--
    }
    
}

let s1: [Int] = [4, 3, 6, 9, 2, 8, 5, 7, 6, 1, 6]
let s2: [Int] = [3, 8, 5, 4, 1, 9, 0, 2, 1, 0, 7]
let n: Int = 10

var i: Int = 0
var uf: UF = UF(n:n)
while i < n {
    var p: Int = s1[i]
    var q: Int = s2[i]
    if !uf.connected(p, q: q) {
        uf.union(p, q:q)
        println("\(p) \(q)")
    }
    i++
}
println("\(uf.count()) components")
