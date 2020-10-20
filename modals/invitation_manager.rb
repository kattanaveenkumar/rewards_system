#This class will manage the invitation based on the input given by process file class 
#if new data comes, if customer is already present,not accepted and if he accepts invitation 
#then it will update the score. If the node does not present then and it will create 
#space for the node in the tree or it will create a new tree in the forest if it is a 
#new root node
class InvitationManager
    attr_accessor :forest_operations
    attr_accessor :line_content
    def initialize 
        @forest_operations= ForestOperations.new
        @forest_operations.forest_tree_roots_arr = []

    end
    #This method will make sure that no redundant customers are present in the tree if customer 
    #present in accepted invitation then this dangerous method will update tree accordingly if 
    #customer is not present and he sends a recommendation then and it will create a new tree in 
    #the forest
    def process_recommendation 
        person_already_present = forest_operations.is_recorded?(
            line_content[:recived_by]
            )
        unless person_already_present
            customer_present_and_accepted_invitation = forest_operations.is_recorded_and_accepted?(
                line_content[:sent_or_accepted_by]
                )
            if customer_present_and_accepted_invitation
                append_new_invitation
            else
                parent = create_new_customer
                forest_operations.forest_tree_roots_arr << parent
            end
        end
    end


    #When a new recommendation comes and already known customer recommend a new user then this
    #method will happened that new recommendation to the known customer in the tree
    def append_new_invitation 
        parent_node =nil
        forest_operations.forest_tree_roots_arr.each{|node|
        node_present=ForestOperations.is_element_present_in_node?(
            node, 
            line_content[:sent_or_accepted_by]
            )
            if node_present
                ForestOperations.link_parent_child_nodes_return_parent(
                    parent_node = ForestOperations.select_node( 
                        node,
                        line_content[:sent_or_accepted_by]
                        ),
                    ForestOperations.create_node(
                        line_content[:recived_by]
                        )
                    )
                break
            end
        }
        parent_node
    end


    #For a new node that doesn't even exist in our system then and this method helps to create a 
    #new customer
    def create_new_customer 
        ForestOperations.link_parent_child_nodes_return_parent(
            ForestOperations.create_node(
                line_content[:sent_or_accepted_by],
                :accepted),
            ForestOperations.create_node(
                line_content[:recived_by]
            ) 
        )
    end

    #When a user accept invitation then this method will update the score and status of that 
    #particular customer
    def process_acceptence 
        @forest_operations.forest_tree_roots_arr.each{|node|
            if ForestOperations.is_element_present_in_node?(node, line_content[:sent_or_accepted_by])
                    ForestOperations.update_tree_score(
                        node,
                        line_content[:sent_or_accepted_by]
                        )
            end
        }
    end

    def multi_way_forest_root_arr
        @forest_operations.forest_tree_roots_arr
    end
    
end