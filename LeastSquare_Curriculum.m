g =  9.7936174;

A = [g -g  0  0  0  0
     0  0  g -g  0  0
     0  0  0  0  g -g
     1  1  1  1  1  1 ];

dataSize = min([length(XUp) length(XDown) length(YUp) length(YDown) length(ZUp) length(ZDown)]);

XUpLS = [XUp(1:dataSize,1) XUp(1:dataSize,2) XUp(1:dataSize,3)]';
XDownLS = [XDown(1:dataSize,1) XDown(1:dataSize,2) XDown(1:dataSize,3)]';
YUpLS = [YUp(1:dataSize,1) YUp(1:dataSize,2) YUp(1:dataSize,3)]';
YDownLS = [YDown(1:dataSize,1) YDown(1:dataSize,2) YDown(1:dataSize,3)]';
ZUpLS = [ZUp(1:dataSize,1) ZUp(1:dataSize,2) ZUp(1:dataSize,3)]';
ZDownLS = [ZDown(1:dataSize,1) ZDown(1:dataSize,2) ZDown(1:dataSize,3)]';

for i = 0:dataSize-1
    L(:,i * 6 + 1) = XUpLS(:,i + 1) * 200;
    L(:,i * 6 + 2) = XDownLS(:,i + 1) * 200;
    L(:,i * 6 + 3) = YUpLS(:,i + 1) * 200;
    L(:,i * 6 + 4) = YDownLS(:,i + 1) * 200;
    L(:,i * 6 + 5) = ZUpLS(:,i + 1) * 200;
    L(:,i * 6 + 6) = ZDownLS(:,i + 1) * 200;
    ALS(:, i * 6 + 1 : i * 6 + 6) = A;
end

%------------------------------------------------------%
%----L(3 * [6 * n]) = M(3 * 4) * A(4 * [6 * n]) -------%
%---------------M = L * A' * inv(A * A')---------------%
%------------------------------------------------------%
M = L * ALS' / (ALS * ALS');
%%----------------END OF FILE--------------------------%%