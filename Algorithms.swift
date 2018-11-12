import UIKit

var str = "Hello, playground"

typealias IntMatrix = Array<Array<Int>>

var r = Array<Int>(repeating: 0, count: 6)
r[0] = 1;
for i in 1...5 {
    var sum = 0;
    for j in 0...i {
       sum += r[j]
    }
     r[i] = sum;
}

// time complexity: O(2^n)
func cutRod(p:Array<Double>, n:Int) -> Double {
    if (n == 0) {
        return 0;
    }
    var q = -100000.0
    for i in 1...n {
        q = max(q,p[i-1]+cutRod(p:p,n:n-i))
    }
    
    return q;
}

print(cutRod(p: [3,2,5,10], n: 4))

// time complexity: O(n^2)
func MemoizedCutRod(p:Array<Double>, n:Int,  r: Array<Double>) -> Double {
    var r = r;
    if r[n] >= 0 {
        return r[n];
    }
    var q = -100000.0
    if (n == 0) {
        q = 0;
    } else {
        q = -100000.0;
        for i in 1...n {
            q = max(q,p[i-1]+MemoizedCutRod(p:p,n:n-i,r:r))
        }
    }
    r[n] = q;
    return q;
}

// time complexity: O(n^2)
func BottomUPcutRod(p:Array<Double>, n:Int) -> Double {
    var r = Array<Double>([0,0,0,0,0,0,0,0,0,0,0,0,0])
    r[0] = 0;
    for j in 1...n {
        var q = -100000.0
        for i in 1...j {
            q = max(q,p[i-1]+r[j-i])
        }
        r[j] = q;
    }
    print(r)
    return r[n];
}

// time complexity: O(n*m)
func longestSubSequence(X: [Character], Y:[Character]) -> (IntMatrix,IntMatrix) {
    
    let m = X.count
    let n = Y.count
    var b = Array(repeating: Array(repeating: -1, count: n), count: m)
    var c = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    
    for i in 1..<m+1 {
        for j in 1..<n+1 {
            if X[i-1] == Y[j-1] {
                print(X[i-1])
                c[i][j] = c[i-1][j-1] + 1
                // up left
                b[i-1][j-1] = 1
            } else if c[i-1][j] >= c[i][j-1] {
                c[i][j] = c[i-1][j]
                // up
                b[i-1][j-1] = 2
            } else {
                // left
                b[i-1][j-1] = 0
            }
        }
    }
    
    return (c,b)
}

class Graph {
    
    enum Color {
        case White
        case Black
        case Gray
    }
    
    class Node {
        var index = -100;
        var exploreTime = -100;
        var finishTime = 0;
        var parent:Node?
        var color:Color = Color.White
    }
    
    private var time = 0;
    private var V = 0;
    private var nodes = Array<Node>()
    private var adjacencyList = Array<Array<Node>>();
    
    init(v: Int) {
        V = v;
        for i in 0..<v {
            let node = Node()
            node.index = i
            nodes.append(node)
            adjacencyList.append(Array<Node>())
        }
    }
    
    subscript(index: Int) -> Node {
        return nodes[index]
    }
    
    func addEdge(v: Int, w:Int) {
        let node = nodes[w-1]
        adjacencyList[v-1].append(node)
    }
    
    func BFS(s: Node) {
        var s = s
        s.exploreTime = 0
        var visited = Array<Bool>(repeating: false, count: V+1)
        var queue = Queue(array: Array<Node>());
        
        visited[s.index] = true;
        queue.enqueue(s);
        
        while queue.count != 0 {
            s = queue.dequeue()!;
            print("Node \(s.index + 1) explored at \(s.exploreTime)")
            for n in adjacencyList[s.index] {
                if !visited[n.index] {
                    n.exploreTime = s.exploreTime + 1
                    visited[n.index] = true;
                    queue.enqueue(n)
                }
            }
        }
    }

    func DFS() {
        time = 0
        for node in nodes {
            if node.color == .White {
                DFSVisit(u: node)
            }
        }
    }
    
    private func DFSVisit(u: Node) {
        time = time + 1
        print("Node \(u.index + 1) explored at \(time)")
        u.exploreTime = time
        u.color = .Gray
        for v in adjacencyList[u.index] {
            if (v.color == .White) {
                DFSVisit(u: v)
            }
        }
        u.color = .Black
        time = time + 1
        print("Node \(u.index + 1) finished at \(time)")
        u.finishTime = time
    }
    
    func topologicalSort() -> Array<Node> {
        DFS()
        return nodes.sorted(by: {$0.finishTime > $1.finishTime })
    }
    
}

