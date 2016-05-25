%% 問題
% matlab標準の混合整数線形計画法 (MILP)ソルバーintlinprogを用いる
% 問題
% min f^T*x
% subject to
%   A*x <= b        %不等式制約
%   Aeq*x = beq     %等式制約
%   lb <= x <= ub   %設計変数 x に上限と下限
%

%% 部分割り当ての導入
% 一度に全日程を出力するには条件設定が複雑
% 従って，1(もしくは複数)日ごとに割り当てをする部分割り当てという考え方を導入する
% 全曲で最適化→選択された曲を除いた曲で最適化→さらに選択された曲を除いた曲で最適化
% →全曲の練習回数が1回以上になったら繰り返し
% すなわち，選択しなくても良い曲が出てくる(不等式制約を用いれば解決)

%% TTスケジューリング問題の定式化
% min f^T*x
% subject to
%     A*x <= 1
%     Aeq*x = 1
%     0 <= x <= 1
%
% 変数について
% lb = 0
% ub = 1
% x   : 曲が時間を選択するとき1,選択しないとき0
% b   : 曲が選択する時間数の上限
% beq : 時間が受け持つ曲数
% f   : コスト（欠席者数）
%
% 従って，TTスケジューリング問題は0-1整数計画問題として扱うことができる

%% テスト作成条件
% 曲　 : music1 ~ music6の6曲
% 時間 : time1 ~ time6の6枠
% time1(1835-1900) time2(1900-1925) time3(1925-1950)
% time4(1950-2015) time5(2015-2040) time6(2040-2105)

%% 欠席行列の作成
% 重みを付加したいなら欠席者/合計曲人数で正規化すれば良い？
numTimes = 6;
numMusic = 7;
music1 = [1; 1; 1; 1; 0; 0];
music2 = [0; 0; 0; 1; 2; 4];
music3 = [0; 0; 0; 1; 3; 0];
music4 = [1; 3; 3; 1; 1; 0];
music5 = [3; 4; 1; 2; 1; 0];
music6 = [1; 1; 1; 1; 2; 0];
music7 = [1; 0; 1; 0; 2; 1];
matrixAbsence = [music1 music2 music3 music4 music5 music6 music7];
P = matrixAbsence; %重み付けはまだ行わない
f = P(:);

%% 制約条件
% b   : 曲が選択する時間数は1以下
% A*x <= 1 : 選択された曲は全てではなくて良い
onesvector = ones(1,numTimes);
A = blkdiag(onesvector,onesvector,onesvector,onesvector,onesvector,onesvector,onesvector);
b = ones(numMusic,1);

% beq : 時間が受け持つ曲数は1
% Aeq*x = 1
Aeq = repmat(eye(numTimes),1,numMusic);
beq = ones(numTimes,1);

%% lb,ubの設定
lb = zeros(size(f));
ub = lb + 1;

%% intvarsの作成(x(添字)の要素が整数 → 今回は全ての要素が整数) 
intcon = 1:length(f);

%% 最適化
[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

%% 出力
%fval,exitflag,output
displayX
