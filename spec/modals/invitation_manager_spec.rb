describe InvitationManager do 
    describe "#process_recommendation" do

        it "Verify whether child is appending to parent" do
            process_accept_recommend_for_test(subject,:case_one_recommends)
            expect(
                get_all_users_names(
                subject.multi_way_forest_root_arr
                )).to match_array(
                TestVariables.line_array_content[:output_one].first
                )
            
        end
        it "Verify whether grand child is appending to grand parent" do
            
            [:case_one_recommends, 
            :case_one_accepts, 
            :case_two_recommends].each{|content|
                process_accept_recommend_for_test(subject,content)
            }
            expect(
                get_all_users_names(
                    subject.multi_way_forest_root_arr
                )).to match_array(
                    TestVariables.line_array_content[:output_two].first
                )
            
        end
    end
    describe "#process_acceptence" do

        it "Verify score when child is appending to parent" do
            [:case_one_recommends, 
            :case_one_accepts].each{|content|
                process_accept_recommend_for_test(subject,content)
            }
            expect([
                get_all_users_scores(
                    subject.multi_way_forest_root_arr
                )]).to match_array(
                TestVariables.line_array_content[:output_one].last
                )
            
        end
        it "Verify score when grand child is appending to grand parent" do
            [:case_one_recommends, 
            :case_one_accepts, 
            :case_two_recommends,
            :case_two_accepts].each{|content|
                process_accept_recommend_for_test(subject,content)
            }
            expect([
                get_all_users_scores(
                    subject.multi_way_forest_root_arr
                )]).to match_array(
                    TestVariables.line_array_content[:output_two].last
                )
            
        end
    end

    describe "#append_new_invitation" do

        it "Verify new node is currently appending to correct node" do
            [:case_one_recommends, 
            :case_one_accepts].each{|content|
                process_accept_recommend_for_test(subject,content)
            }
            subject.line_content = set_test_split_variables(:case_two_recommends)
            node = subject.append_new_invitation
            expect([
                node.parent.name,
                node.name,
                node.children.first.name]).to eq(
                    TestVariables.line_array_content[:output_two].first) 
            
        end
    end

    describe "#create_new_customer" do

        it "Verify whether new root is getting created" do
            subject.line_content = set_test_split_variables(:case_one_recommends)
            node = subject.create_new_customer
            expect(node.parent).to be(nil)
            expect([
                node.name,
                node.children.first.name]).to eq(
                    TestVariables.line_array_content[:output_one].first)    
        end
    end


end