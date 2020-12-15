function [im1, u, U, poses, bounding_boxes] = load_data(nr)
    
    data_dir = append('./data/data', string(nr), '.mat');
    load(data_dir)
    
    im_dir = append('./data/img', string(nr), '.JPG');
    im1 = imread(im_dir);
end