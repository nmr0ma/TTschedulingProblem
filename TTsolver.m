%% ���
% matlab�W���̍����������`�v��@ (MILP)�\���o�[intlinprog��p����
% ���
% min f^T*x
% subject to
%   A*x <= b        %�s��������
%   Aeq*x = beq     %��������
%   lb <= x <= ub   %�݌v�ϐ� x �ɏ���Ɖ���
%

%% �������蓖�Ă̓���
% ��x�ɑS�������o�͂���ɂ͏����ݒ肪���G
% �]���āC1(�������͕���)�����ƂɊ��蓖�Ă����镔�����蓖�ĂƂ����l�����𓱓�����
% �S�ȂōœK�����I�����ꂽ�Ȃ��������ȂōœK��������ɑI�����ꂽ�Ȃ��������ȂōœK��
% ���S�Ȃ̗��K�񐔂�1��ȏ�ɂȂ�����J��Ԃ�
% ���Ȃ킿�C�I�����Ȃ��Ă��ǂ��Ȃ��o�Ă���(�s���������p����Ή���)

%% TT�X�P�W���[�����O���̒莮��
% min f^T*x
% subject to
%     A*x <= 1
%     Aeq*x = 1
%     0 <= x <= 1
%
% �ϐ��ɂ���
% lb = 0
% ub = 1
% x   : �Ȃ����Ԃ�I������Ƃ�1,�I�����Ȃ��Ƃ�0
% b   : �Ȃ��I�����鎞�Ԑ��̏��
% beq : ���Ԃ��󂯎��Ȑ�
% f   : �R�X�g�i���ȎҐ��j
%
% �]���āCTT�X�P�W���[�����O����0-1�����v����Ƃ��Ĉ������Ƃ��ł���

%% �e�X�g�쐬����
% �ȁ@ : music1 ~ music6��6��
% ���� : time1 ~ time6��6�g
% time1(1835-1900) time2(1900-1925) time3(1925-1950)
% time4(1950-2015) time5(2015-2040) time6(2040-2105)

%% ���ȍs��̍쐬
% �d�݂�t���������Ȃ猇�Ȏ�/���v�Ȑl���Ő��K������Ηǂ��H
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
P = matrixAbsence; %�d�ݕt���͂܂��s��Ȃ�
f = P(:);

%% �������
% b   : �Ȃ��I�����鎞�Ԑ���1�ȉ�
% A*x <= 1 : �I�����ꂽ�Ȃ͑S�Ăł͂Ȃ��ėǂ�
onesvector = ones(1,numTimes);
A = blkdiag(onesvector,onesvector,onesvector,onesvector,onesvector,onesvector,onesvector);
b = ones(numMusic,1);

% beq : ���Ԃ��󂯎��Ȑ���1
% Aeq*x = 1
Aeq = repmat(eye(numTimes),1,numMusic);
beq = ones(numTimes,1);

%% lb,ub�̐ݒ�
lb = zeros(size(f));
ub = lb + 1;

%% intvars�̍쐬(x(�Y��)�̗v�f������ �� ����͑S�Ă̗v�f������) 
intcon = 1:length(f);

%% �œK��
[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

%% �o��
%fval,exitflag,output
displayX
