function vector = zigzagscan(matrix)
    %zigzagsacn: function for zigzag scan
    [h, w] = size(matrix);

    if h == 8 && w == 8
        vector8 = reshape(matrix, 1, 64);
        index = [1, 9, 2, 3, 10, 17, 25, 18, ...
                11, 4, 5, 12, 19, 26, 33, 41, ...
                34, 27, 20, 13, 6, 7, 14, 21, ...
                28, 35, 42, 49, 57, 50, 43, 36, ...
                29, 22, 15, 8, 16, 23, 30, 37, ...
                44, 51, 58, 59, 52, 45, 38, 31, ...
                24, 32, 39, 46, 53, 60, 61, 54, ...
                47, 40, 48, 55, 62, 63, 56, 64];
        vector = vector8(index);
    else
        vector = zeros(1, h * w);
        row = 1;
        col = 1;
        pos = 1;
        direction = [-1, 1];
        % first for row and second for col

        while row <= h && col <= w
            vector(pos) = matrix(row, col);

            if isequal(direction, [-1, 1]) && row == 1 && col ~= w
                direction = [0, 1];
                col = col + 1;
            elseif isequal(direction, [-1, 1]) && col == w
                direction = [1, 0];
                row = row + 1;
            elseif isequal(direction, [-1, 1]) && col ~= w && row ~= 1
                direction = [-1, 1];
                row = row - 1;
                col = col + 1;
            elseif isequal(direction, [1, -1]) && col == 1 && row ~= h
                direction = [1, 0];
                row = row + 1;
            elseif isequal(direction, [1, -1]) && row == h
                direction = [0, 1];
                col = col + 1;
            elseif isequal(direction, [1, -1]) && row ~= h && col ~= 1
                direction = [1, -1];
                col = col - 1;
                row = row + 1;
            elseif isequal(direction, [1, 0]) && col == 1
                direction = [-1, 1];
                row = row - 1;
                col = col + 1;
            elseif isequal(direction, [1, 0]) && col == w
                direction = [1, -1];
                col = col - 1;
                row = row + 1;
            elseif isequal(direction, [0, 1]) && row == 1
                direction = [1, -1];
                col = col - 1;
                row = row + 1;
            elseif isequal(direction, [0, 1]) && row == h
                direction = [-1, 1];
                row = row - 1;
                col = col + 1;
            end

            pos = pos + 1;
        end

    end

end
