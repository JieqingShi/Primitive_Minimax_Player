function [ new_board, next_move ] = stupid_minimax2( old_board, colour, search_depth, timer )
%MINIMAX Summary of this function goes here
%   Detailed explanation goes here

new_board = old_board;
% First we use absolute static values
board_value = [20000    -6000   2000    800    800  2000    -6000   20000;
               -6000    -8000   -450    -500    -500 -450   -8000   -6000; 
               2000     -450    30      10      10   30     -450    2000;
               800      -500    10      50      50   10     -500    800;
               800      -500    10      50      50   10     -500    800;      
               2000     -450    30      10      10   60     -450    2000;
               -6000    -8000   -450    -500    -500 -450   -8000   -6000;
               20000    -6000   2000    800     800   2000  -6000    20000];
movesNum = size(nonzeros(old_board),1);
search_depth = 2; % 2plys, aka 1 move each

legalFields_player = findLegalMoves(old_board, colour);
assignin('base', 'legalFields_player', legalFields_player);
numLegalFields_player = size(legalFields_player,1);
% Generate search tree with field values for both player and opponent (2
% plys, one move each)
mov_value_player = zeros(numLegalFields_player,1);
nodeVal_player = zeros(numLegalFields_player,1);
if numLegalFields_player > 0
    for ii = 1:numLegalFields_player
%         mov_value_player(ii) = board_value(legalFields_player(ii,1), legalFields_player(ii,2));
        new_board_halfMove = calculateNewBoard(old_board, [legalFields_player(ii,1) legalFields_player(ii,2)], colour);
        mov_value_player(ii) = sum(sum((new_board_halfMove == colour).*board_value))-...
            sum(sum((old_board == colour).*board_value));
        legalFields_opponent = findLegalMoves(new_board_halfMove, -colour);
        numLegalFields_opponent = size(legalFields_opponent,1);
        if numLegalFields_opponent > 0
             mov_value_opponent = zeros(numLegalFields_opponent, 1);
             for jj = 1:numLegalFields_opponent
                 new_board_fullMove = calculateNewBoard(new_board_halfMove, [legalFields_opponent(jj,1) legalFields_opponent(jj,2)], -colour);
%                  mov_value_opponent(jj) = board_value(legalFields_opponent(jj,1), legalFields_opponent(jj,2)).*-1;
                 mov_value_opponent(jj) = (sum(sum((new_board_fullMove == -colour).*board_value))-...
                     sum(sum((new_board_halfMove == -colour).*board_value)))*(-1);
             end
             nodeVal_player(ii) = min(mov_value_opponent);
        elseif numLegalFields_opponent == 0
             nodeVal_player(ii) = mov_value_player(ii);
        end
    end
[~, maxIdx] = max(nodeVal_player); 
% maxIdx = find(nodeVal_player == maxVal);
next_move = [legalFields_player(maxIdx,1), legalFields_player(maxIdx,2)];
assignin('base', 'nodeVal_player', nodeVal_player);
new_board = calculateNewBoard(old_board, next_move, colour);
end


