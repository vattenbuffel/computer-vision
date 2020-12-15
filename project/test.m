clc; clear all; close all

im1 = generate_col(1);
im2 = generate_col(2);
im3 = generate_col(3);
im4 = generate_col(4);
im5 = generate_col(5);
im6 = generate_col(6);
im7 = generate_col(7);


classes_methods = ["ape - ms", "ape - ms&LM", "can - ms", "can - ms&LM", "cat - ms", "cat - ms&LM", "duck - ms", "duck - ms&LM", "eggbox - ms", "eggbox - ms&LM", "glue - ms", "glue - ms&LM", "holepuncher - ms" , "holepuncher - ms&LM"].';

table(classes_methods, im1, im2, im3, im4, im5, im6, im7)


function col = generate_col(nr)
    [scores_before, scores_after] = compare_before_and_after_refinement(nr, false);
    col = [];
    for i = 1:7
        col = [col; scores_before{i}; scores_after{i}]; 
    end

end