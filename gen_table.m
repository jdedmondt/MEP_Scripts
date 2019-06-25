% gen_table.m: format the data in a way which the classifier will
% accept and add the response variables for classification

% determine number of colunms allowed per row
lim = intmax;
for i = 1:clip_n
    if (size(eda{i}, 1) < lim)
        lim = size(eda{i}, 1);
    end
    if (size(hr{i}, 1) < lim)
        lim = size(hr{i}, 1);
    end
    if (size(temp{i}, 1) < lim)
        lim = size(temp{i}, 1);
    end
end

j = 1;
for i = 1:clip_n
    start_n = 1;
    end_n = lim;
    prev = j;
    while (1)
        if (end_n > size(eda{i}, 1) || end_n > size(hr{i}, 1) || end_n > size(temp{i}, 1))
            row_counts(i) = j - prev;
            break;
        end
        row{j} = [eda{i}(start_n:end_n)' hr{i}(start_n:end_n)' temp{i}(start_n:end_n)'];
        start_n = end_n;
        end_n = end_n + lim - 1;
        j = j + 1;
    end
    disp("done with one clip");
end

TABLE = table;
for i = 1:size(row, 1)
TABLE(i, 1:size(row{i}, 2)) = array2table(row{i}(:)');
end

n0 = repmat(0, 1, row_counts(1)+row_counts(2));
n1 = repmat(1, 1, row_counts(3)+row_counts(4));
n2 = repmat(2, 1, row_counts(5)+row_counts(6));
n3 = repmat(3, 1, row_counts(7)+row_counts(8));

label = [n0(:); n1(:); n2(:); n3(:)]';

TABLE(:, size(TABLE, 2)+1) = array2table(label');