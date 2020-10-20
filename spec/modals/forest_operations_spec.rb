
describe ForestOperations do 
    let(:a_node){ForestOperations.create_node("A")}
    let(:b_node){ForestOperations.create_node("B")}
    let(:c_node){ForestOperations.create_node("C")}
    let(:e_node){ForestOperations.create_node("E")}
    let(:f_node){ForestOperations.create_node("F")}
    describe ".link_parent_child_nodes_return_parent" do
        it "Verifies childs are appending to parent correctly" do
            result = ForestOperations.link_parent_child_nodes_return_parent(a_node,b_node)
            expect(result.children.first.name).to eql(b_node.name)
            expect(result.name).to eql(a_node.name)
        end
    end
    describe ".select_node" do
        before(:example) do
            a_node << b_node 
            b_node << c_node
            e_node << f_node
        end
        it "Verifies the node presence in the tree" do
            result = ForestOperations.select_node(a_node,"B")
            expect(result.name).to eql("B")
        end
        it "Verifies tree is not giving other tree elements" do
            result = ForestOperations.select_node(a_node,"F")
            expect(result).to be_nil
        end
    end
    describe ".update_tree_score" do

        it "Verifies the score update when single child is added" do
            a_node << b_node
            ForestOperations.update_tree_score(a_node,"B")
            parent_score= ENV["BASE_MULTIPLIER"].to_f**ENV["INITIAL_VARIANT"].to_f
            expect(a_node.content[:score]).to eql(parent_score)
        end
        it "Verifies grand parent score when grand child added" do
            a_node << b_node
            ForestOperations.update_tree_score(a_node,"B")
            parent_score= ENV["BASE_MULTIPLIER"].to_f**ENV["INITIAL_VARIANT"].to_f
            b_node << c_node
            ForestOperations.update_tree_score(a_node,"C")
            parent_score+= ENV["BASE_MULTIPLIER"].to_f**(ENV["INITIAL_VARIANT"].to_f+ENV["EXPONENT_MULTIPLIER"].to_f)
            expect(a_node.content[:score]).to eql(parent_score)
        end
    end
    describe ".is_element_present_in_node?" do
        before(:example) do
            a_node << b_node 
            b_node << c_node
            e_node << f_node
        end
        it "Verifies the node presence in the tree" do
            result = ForestOperations.select_node(a_node,"B")
            expect(result).to be_truthy
        end
        it "Verifies the node presence in the multi way forest reflecting i the result" do
            result = ForestOperations.select_node(a_node,"F")
            expect(result).to be_nil
        end
    end
    describe ".is_recorded?" do
        before(:example) do
            a_node << b_node 
            b_node << c_node
            e_node << f_node
            subject.forest_tree_roots_arr=[a_node,e_node]
        end
        it "Verifies the node presence in the tree" do
            result = subject.is_recorded?("B")
            expect(result).to be_truthy
        end
        it "Verifies the availabulity node in the multi way forest reflecting is the result" do
            result = subject.is_recorded?("F")
            expect(result).to be_truthy
        end
    end
    describe ".is_recorded_and_accepted?" do
        before(:example) do
            a_node << b_node; a_node.content[:status]= :accepted;b_node.content[:status]= :accepted
            e_node << f_node; e_node.content[:status]= :accepted
            subject.forest_tree_roots_arr=[a_node,e_node]
        end
        it "Verifies the node presence in the tree" do
            result = subject.is_recorded_and_accepted?("B")
            expect(result).to be_truthy
        end
        it "Verifies the availabulity node in the multi way forest reflecting is the result" do
            result = subject.is_recorded_and_accepted?("F")
            expect(result).to be_falsey
        end
    end
    describe ".get_recorderd_elements" do
        before(:example) do
            a_node << b_node 
            b_node << c_node
            e_node << f_node
            subject.forest_tree_roots_arr=[a_node,e_node]
        end
        it "Verifies the node presence in the tree" do
            result = subject.get_recorderd_elements
            expect(result).to match_array(["A","B","C","E","F"])
        end
    end
end
