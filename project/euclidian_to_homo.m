function homo =  euclidian_to_homo(euclidian)
    homo = [euclidian; ones(1, size(euclidian, 2))];
end