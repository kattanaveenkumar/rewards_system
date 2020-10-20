#As we are dealing with multi way forest with multiple trees this class helps us 
#to deal with the forest as well as  tree level operations
class ForestOperations
    attr_accessor :forest_tree_roots_arr
    
    #This method links parent and child
    def self.link_parent_child_nodes_return_parent(parent,child)
        parent << child
        parent
    end


   #This method is to find node in the given tree
    def self.select_node(node,e)
        node.find_all.select{|node| node.name == e}.first 
    end
    

    #This method will update the score of the accepted user related tree
    def self.update_tree_score(node,e)
        actual_node=select_node(node,e)
        actual_node.content[:status]= :accepted
        parent_node=actual_node.parent
        i=ENV['INITIAL_VARIANT'].to_f
        base_multiplier = ENV['BASE_MULTIPLIER'].to_f
        exponent_multiplier = ENV['EXPONENT_MULTIPLIER'].to_i

        while(parent_node) do
            parent_node.content[:score]+= (base_multiplier.to_f**i)
            parent_node=parent_node.parent
            i+=exponent_multiplier
        end
    end

    #This method verifies the inclusion of a particular customer in the given tree
    def self.is_element_present_in_node?(node, element)
        node.find_all.collect(&:name).include? element
    end
    
    #This method is to create a default node in the tree
    def self.create_node(e,status= :recommended)
        Tree::TreeNode.new(e, {score:ENV['DEFAULT_SCORE'].to_f,status: status})
    end

    #This method helps to identify whether the give user is present in the forest
    def is_recorded? element_name
        get_recorderd_elements.include?(element_name)
    end 

    #This method is to verify whether the give user is already recommended and accepted 
    #the invitation
    def is_recorded_and_accepted? element_name
        forest_tree_roots_arr
            .collect{|node| 
                node.find_all.collect{|node| 
                    node.name if node.content[:status] == :accepted
                }
            }.compact.flatten.include?(element_name)
            
    end
    
    #This method will returns all the elements in the forest
    def get_recorderd_elements
        forest_tree_roots_arr.collect{|node| node.find_all.collect(&:name)}.flatten
    end

end