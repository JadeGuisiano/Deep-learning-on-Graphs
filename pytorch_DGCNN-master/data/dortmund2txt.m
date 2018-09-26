datasets = strvcat('CRIME');

for ith_data = 1: size(datasets, 1)
    dataset = strcat(datasets(ith_data, :));
    path2data = [dataset '/'];    % path to folder containing data
    
    % graph labels
    graph_labels = dlmread([path2data dataset '_graph_labels.txt']);
    num_graphs = size(graph_labels, 1); % Save number of graphs
    
    graph_ind = dlmread([path2data dataset '_graph_indicator.txt']);
    num_nodes = size(graph_ind, 1); % Save number of nodes
    
    % node labels
    try % Checking the existence of file node label
        labels = dlmread([path2data dataset '_node_labels.txt']);
        if size(labels,1) ~= num_nodes % if number of line of node labels is no equal to the number of nodes
            fprintf('ERROR: Wrong number of nodes in %s!\n', [dataset '_node_labels.txt']);
        end
    catch
        disp('No node labels for this dataset.')
    end
    
    % node attributes
    try % Checking the existence of file node attributes
        attributes = dlmread([path2data dataset '_node_attributes.txt']);
        if size(attributes,1) ~= num_nodes % if number of line of node attribute is no equal to the number of nodes
            fprintf('ERROR: Wrong number of nodes in %s!\n', [dataset '_node_attributes.txt']);
        end
    catch
        disp('No node attributes for this dataset.')
    end
    
    % edges, adjacency matrix
    edges = dlmread([path2data dataset '_A.txt']);
    num_edges = size(edges,1); % Save the number of edges
    
    % edge attributes (e.g. edge weights etc.)
    try % Checking the existence of file edge attributes
        edge_attr = dlmread([path2data dataset '_edge_attributes.txt']);
        if size(edge_attr, 1) ~= num_edges
            fprintf('ERROR: Wrong number of edges in %s!\n', [dataset '_edge_attributes.txt']);
        end
        if size(edge_attr,2) > 1
            fprintf('CAUTION: there are more than one edge attributes in %s!\n', [dataset '_edge_attributes.txt']);
            fprintf('CAUTION: only the first one is used in adjacency matrix.\n');
        end
    catch
        edge_attr = ones(num_edges, 1);
        disp('No edge attributes for this dataset.')
    end

    A = spones(sparse(edges(:,1), edges(:,2), edge_attr(:,1), num_nodes, num_nodes)); % Create a sparse matrice (sparse), replace nonzero with ones (spones), matrix of size num_nodes * num_nodes 
    % sparse(i,j,v) generates a sparse matrix S from the triplets i, j, and v such that S(i(k),j(k)) = v(k). The max(i)-by-max(j) output matrix has space allotted for length(v) nonzero elements. sparse adds together elements in v that have duplicate subscripts in i and j.If the inputs i, j, and v are vectors or matrices, they must have the same number of elements. Alternatively, the argument v and/or one of the arguments i or j can be scalars.

    % save to a single txt 
    graph_labels = graph_labels - min(graph_labels);  % Re-indexing graph labels from 0 to N
    fid = fopen(sprintf('%s/%s.txt', dataset, dataset), 'w');  
    fprintf(fid, '%d\n', num_graphs); % Write on the output file txt at the top the number of graphs

    for i = 1 : num_graphs 
        i_ind = graph_ind == i; % i_ind save the output of the equlity of the two vectors graph_ind and i (work only if the two vectors contains same number) / equal 1 for n graphe_ind last lines .... 
        Ai = A(i_ind, i_ind); % Creation of the matrix Ai of the dimesion of the vector i_ind
        if exist('labels') % Checking if label exist for the element of the vector i_ind
            li = labels(i_ind); % li stores label of the elements of i_ind
        end 
        if exist('attributes')% Same for attributes
            attri = attributes(i_ind, :); 
        end
        start_ind = nnz(graph_ind < i); % Start_ind store the non zero values of the values inf at i of the vector graph_ind
        num_nodes_i = size(Ai, 1); % num_nodes_i stores the number of lines of the Ai matrix
        fprintf(fid, '%d %d\n', num_nodes_i, graph_labels(i)); % Write the number of node and the graph label for each graph in the output file txt
        for j = 1 : num_nodes_i 
            rowj = Ai(j, :); % Create vector rowj size 1*n 
            neighbors = find(rowj); % Find indices and values of nonzero elements in rowj and store it in neighbors
            num_neighbors = length(neighbors); % Stores the number of neighbors in num_neighbors
            if ~exist('labels') % Checking the existence of node label for node neighbors
                fprintf(fid, '%d %d', 0, num_neighbors);  % Give a null label
            else
                fprintf(fid, '%d %d', li(j) - 1, num_neighbors);  % Recoding Node label starts from 0
            end
            for k = 1 : num_neighbors
                fprintf(fid, ' %d', neighbors(k) - 1);
            end
            if exist('attributes') % Checking the existence of node attributes for node neighbors
                for k = 1 : length(attri(j, :))
                    fprintf(fid, ' %.6f', attri(j, k));
                end
            end
            fprintf(fid, '\n');
        end
    end

    fclose(fid);

    total = length(graph_labels); % creation of 10 training and test samples
    fold_size = floor(total / 10);
    p = randperm(total);
    mkdir(dataset, '10fold_idx')
    for fold = 1 : 10
        test_range = (fold - 1) * fold_size + 1 : fold * fold_size;
        train_range = [1 : (fold - 1) * fold_size, fold * fold_size + 1 : total];
        
        fid = fopen(sprintf('%s/10fold_idx/test_idx-%d.txt', dataset, fold), 'w');
        for i = 1 : length(test_range)
            fprintf(fid, '%d\n', p(test_range(i)) - 1);
        end
        fclose(fid);

        fid = fopen(sprintf('%s/10fold_idx/train_idx-%d.txt', dataset, fold), 'w');
        for i = 1 : length(train_range)
            fprintf(fid, '%d\n', p(train_range(i)) - 1);
        end
        fclose(fid);
    end
    
  end