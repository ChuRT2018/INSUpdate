function q = QuatMulti( q1 , q0 )

    syq1 = [0      -q1(2)  -q1(3) -q1(4)
            q1(2)  0       -q1(4)  q1(3)
            q1(3)   q1(4)  0      -q1(2)
            q1(4)  -q1(3)   q1(2)  0   ];
    q = (q1(1) * eye(4) + syq1 ) * q0;
    q = q/norm(q);
end

