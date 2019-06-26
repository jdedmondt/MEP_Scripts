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
for i = 1:size(row, 2)
TABLE(i, 1:size(row{i}, 2)) = array2table(row{i}(:)');
end

% I am _fully_ aware that this is a bad way to do this.
n0 = {repmat(0, 1, row_counts(1)+row_counts(2)), repmat(0, 1, row_counts(9)+row_counts(10)), repmat(0, 1, row_counts(17)+row_counts(18))};
n1 = {repmat(1, 1, row_counts(3)+row_counts(4)), repmat(1, 1, row_counts(11)+row_counts(12)), repmat(1, 1, row_counts(19)+row_counts(20))}; 
n2 = {repmat(2, 1, row_counts(5)+row_counts(6)), repmat(2, 1, row_counts(13)+row_counts(14)), repmat(2, 1, row_counts(21)+row_counts(22))};
n3 = {repmat(3, 1, row_counts(7)+row_counts(8)), repmat(3, 1, row_counts(15)+row_counts(16)), repmat(3, 1, row_counts(23)+row_counts(24))};

label = [n0{1}(:); n1{1}(:); n2{1}(:); n3{1}(:); n0{2}(:); n1{2}(:); n2{2}(:); n3{2}(:); n0{3}(:); n1{3}(:); n2{3}(:); n3{3}(:)]';

TABLE(:, size(TABLE, 2)+1) = array2table(label');