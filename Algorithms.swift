import UIKit

var str = "Hello, playground"

var r = Array<Int>(repeating: 0, count: 6)
r[0] = 1;
for i in 1...5 {
    var sum = 0;
    for j in 0...i {
       sum += r[j]
    }
     r[i] = sum;
}

print(r);

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

print(MemoizedCutRod(p: [3,2,5,10], n: 4,r:Array<Double>(repeating: -10000, count: 7)))

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

print(BottomUPcutRod(p: [3,2,5,10], n: 4))

