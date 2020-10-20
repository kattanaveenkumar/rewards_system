
describe ProcessFile do 

    describe "#analyze_and_process_inputs" do

        it "Verify out output contains all the required nodes" do
            TestVariables.invitation_test.each{|input|
                
                tree= subject.analyze_and_process_inputs(
                    get_file input 
                    )
                people_recived_invitation = get_all_users_names tree
                expect(
                    people_recived_invitation
                ).to match_array(
                        input[:output_arr_nodes]
                        )
            }
        end

        it "Verify score out code is caliculating correct scores or not" do
            TestVariables.invitation_test.each{|input|
                tree= subject.analyze_and_process_inputs(
                    get_file input 
                    )
                all_score = get_all_users_scores tree
                expect([
                        get_all_users_scores(tree)
                    ]).to match_array(input[:scores])
            }
        end
    end


    describe "#do_process" do

        it "Verify nodes are able to relate with each other" do
                
            input=TestVariables.file_input_lines[:test_one]
            result= subject.do_process(input)
            expect([
                    get_all_users_scores(result)
            ]).to match_array(
                    TestVariables.invitations_array_test[:output_one]
            )
        
        end
        it "Verify nodes unless accepted the person is not effecting the score" do
                
            input=TestVariables.file_input_lines[:test_two]
            result= subject.do_process(input)
            expect([
                    get_all_users_scores(result)
            ]).to match_array(
                    TestVariables.invitations_array_test[:output_two]
            )
        
        end
        it "Verify scores are updating based on levels" do
                
            input=TestVariables.file_input_lines[:test_three]
            result= subject.do_process(input)
            expect([
                    get_all_users_scores(result)
            ]).to match_array(
                    TestVariables.invitations_array_test[:output_three]
            )
        
        end

    end
    describe "#get_sorted_array" do

        it "Verify sorting of input data happening based on date and time" do
                
            expect([subject.get_sorted_array(
                TestVariables.file_array_sort_test[:input]
            )]).to contain_exactly(
                TestVariables.file_array_sort_test[:output]
            )
        
        end
    end

    describe "#split_words_of_line" do

        it "Verify the response of a recommends string" do
                expect(
                    subject.split_words_of_line TestVariables.file_array_sort_test[:output].first
                ).to match_array(
                    TestVariables.split_words_of_line_mock[:case_one_recommends]
                )
        
        end
        it "Verify the response of a accepted string" do
            expect(
                subject.split_words_of_line TestVariables.file_array_sort_test[:output].last
            ).to match_array(
                TestVariables.split_words_of_line_mock[:case_three_accepts]
            )
    
        end
        it "Verify the response of a arbitrary wrong string" do
            expect(
                subject.split_words_of_line "2018-06-16 25:41 B recommends C gjdg"
            ).to be_falsey
    
        end
    end


end