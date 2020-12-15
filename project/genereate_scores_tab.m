function tab = genereate_scores_tab()
    clc; clear all; close all

    im1 = generate_col(1);
    im2 = generate_col(2);
    im3 = generate_col(3);
    im4 = generate_col(4);
    im5 = generate_col(5);
    im6 = generate_col(6);
    im7 = generate_col(7);


    classes_and_methods = ["ape - ms", "ape - ms&ransac", "ape - ms&ransac&LM", "can - ms", "can - ms&ransac", "can - ms&ransac&LM", "cat - ms", "cat - ms&ransac", "cat - ms&ransac&LM", "duck - ms", "duck - ms&ransac", "duck - ms&ransac&LM", "eggbox - ms", "eggbox - ms&ransac", "eggbox - ms&ransac&LM", "glue - ms", "glue - ms&ransac", "glue - ms&ransac&LM", "holepuncher - ms", "holepuncher - ms&ransac", "holepuncher - ms&ransac&LM", "im_avg - ms", "im_avg - ms&ransac", "im_avg - ms&ransac&LM"].';

    tab = table(classes_and_methods, im1, im2, im3, im4, im5, im6, im7);


    function col = generate_col(nr)
        [scores_ms, scores_ms_ransac, scores_ms_ransac_LM] = generate_scores(nr, false);
        col = [];
        
        avg_ms = 0;
        avg_ms_ransac = 0;
        avg_ms_ransac_LM = 0;
        
        for i = 1:7
            col = [col; scores_ms{i}; scores_ms_ransac{i}; scores_ms_ransac_LM{i}]; 
            
            avg_ms = avg_ms + scores_ms{i}/7;
            avg_ms_ransac = avg_ms_ransac + scores_ms_ransac{i}/7;
            avg_ms_ransac_LM = avg_ms_ransac_LM + scores_ms_ransac_LM{i}/7;
        end
        
        col = [col; avg_ms; avg_ms_ransac; avg_ms_ransac_LM];

    end
end