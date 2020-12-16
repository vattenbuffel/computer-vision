function [tab_ms, tab_ms_ransac, tab_ms_ransac_LM, histogram_ms, histogram_ms_ransac, histogram_ms_ransac_LM] = genereate_scores_tab()
    % Generate the tables
    
    im1_ = generate_col(1);
    im2_ = generate_col(2);
    im3_ = generate_col(3);
    im4_ = generate_col(4);
    im5_ = generate_col(5);
    im6_ = generate_col(6);
    im7_ = generate_col(7);
    im8_ = generate_col(8);
    im9_ = generate_col(9);

    
    % Genereate ms table and histogram
    ms = ["ape", "can", "cat", "duck", "eggbox", "glue", "holepuncher", "im_avg"].';
    im1 = im1_(1:3:end);
    im2 = im2_(1:3:end); 
    im3 = im3_(1:3:end);
    im4 = im4_(1:3:end);
    im5 = im5_(1:3:end);
    im6 = im6_(1:3:end);
    im7 = im7_(1:3:end);
    im8 = im8_(1:3:end);
    im9 = im9_(1:3:end);
    tab_ms = table(ms, im1, im2, im3, im4, im5, im6, im7, im8, im9);
    figure
    histogram_ms = histogram([im1, im2, im3, im4, im5, im6, im7, im8, im9], 100);
    hold on
    title('Histogram of ms scores')
    
    % Genereate ms and ransac table and histogram
    ms_ransac = ["ape", "can", "cat", "duck", "eggbox", "glue", "holepuncher", "im_avg"].';
    im1 = im1_(2:3:end);
    im2 = im2_(2:3:end); 
    im3 = im3_(2:3:end);
    im4 = im4_(2:3:end);
    im5 = im5_(2:3:end);
    im6 = im6_(2:3:end);
    im7 = im7_(2:3:end);
    im8 = im8_(2:3:end);
    im9 = im9_(2:3:end);
    tab_ms_ransac = table(ms_ransac, im1, im2, im3, im4, im5, im6, im7, im8, im9);
    figure
    histogram_ms_ransac = histogram([im1, im2, im3, im4, im5, im6, im7, im8, im9], 100);
    hold on
    title('Histogram of ms and ransac scores')
    
    % Genereate ms and ransac and LM table and histogram
    ms_ransac_LM = ["ape", "can", "cat", "duck", "eggbox", "glue", "holepuncher", "im_avg"].';
    im1 = im1_(3:3:end);
    im2 = im2_(3:3:end); 
    im3 = im3_(3:3:end);
    im4 = im4_(3:3:end);
    im5 = im5_(3:3:end);
    im6 = im6_(3:3:end);
    im7 = im7_(3:3:end);
    im8 = im8_(3:3:end);
    im9 = im9_(3:3:end);
    tab_ms_ransac_LM = table(ms_ransac_LM, im1, im2, im3, im4, im5, im6, im7, im8, im9);
    figure
    histogram_ms_ransac_LM = histogram([im1, im2, im3, im4, im5, im6, im7, im8, im9], 100);
    hold on
    title('Histogram of ms, ransac and LM scores')
    
    
    function col = generate_col(nr)
        [scores_ms, scores_ms_ransac, scores_ms_ransac_LM] = generate_scores(nr, false);
        col = [];
        
        avg_ms = 0;
        avg_ms_ransac = 0;
        avg_ms_ransac_LM = 0;
        
        for i = 1:7
            col = [col; scores_ms{i}; scores_ms_ransac{i}; scores_ms_ransac_LM{i}]; 
            
            avg_ms = avg_ms + scores_ms{i}/7;
            avg_ms_ransac = avg_ms_ransac + scores_ms_ransac{i}/9;
            avg_ms_ransac_LM = avg_ms_ransac_LM + scores_ms_ransac_LM{i}/9;
        end
        
        col = [col; avg_ms; avg_ms_ransac; avg_ms_ransac_LM];

    end
end