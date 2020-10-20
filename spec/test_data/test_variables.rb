class TestVariables

    def self.invitation_test
        [
            {
                input_file: "/test_data/test_one.txt",
                output_arr_nodes: ['A','B','C','D','F','H','K'],
                scores: [
                    A: 1.75,
                    B: 1.5,
                    F: 1.00,
                    C: 1.00
                    
                ]
            },
            {
                input_file: "/test_data/test_two.txt",
                output_arr_nodes: ['A','B','C','D','E'],
                scores: [
                    A: 2.5,
                    B: 1.00
                ]
            }


        ]
    end
    def self.file_input_lines
        {
            test_one: [
                "2018-06-12 09:41 A recommends B", 
                "2018-06-14 09:41 B accepts"
            ],
            test_two: [
                "2018-06-12 09:41 A recommends B", 
                "2018-06-14 09:41 B accepts" ,
                "2018-06-16 09:41 B recommends C"
            ],
            test_three: [
                "2018-06-12 09:41 A recommends B", 
                "2018-06-14 09:41 B accepts",
                "2018-06-16 09:41 B recommends C", 
                "2018-06-17 09:41 C accepts", 
                "2018-06-19 09:41 C recommends D", 
                "2018-06-23 09:41 D accepts"
            ]
        }
    end
    def self.split_words_of_line_mock
        {
            case_one_recommends: {
                sent_or_accepted_by: "A",
                action: :recommends,
                recived_by: "B"
            },
            case_one_accepts: {
                sent_or_accepted_by: "B",
                action: :accepts,
                recived_by: nil
            },
            case_two_recommends: {
                sent_or_accepted_by: "B",
                action: :recommends,
                recived_by: "C"
            },
            case_two_accepts: {
                sent_or_accepted_by: "C",
                action: :accepts,
                recived_by: nil
            },
            case_three_recommends: {
                sent_or_accepted_by: "C",
                action: :recommends,
                recived_by: "D"
            },
            case_three_accepts: {
                sent_or_accepted_by: "D",
                action: :accepts,
                recived_by: nil
            }

        }
    end

    def self.file_array_sort_test
        {
            input: [
                "2018-06-14 09:41 B accepts", 
                "2018-06-16 09:41 B recommends C", 
                "2018-06-17 09:41 C accepts", 
                "2018-06-12 09:41 A recommends B", 
                "2018-06-19 09:41 C recommends D", 
                "2018-06-23 09:41 D accepts", 
                "2018-06-19 09:40 B recommends D"
            ],
            output: [
                ["2018-06-12", "09:41", "A", "recommends", "B"], 
                ["2018-06-14", "09:41", "B", "accepts"], 
                ["2018-06-16", "09:41", "B", "recommends", "C"], 
                ["2018-06-17", "09:41", "C", "accepts"], 
                ["2018-06-19", "09:40", "B", "recommends", "D"], 
                ["2018-06-19", "09:41", "C", "recommends", "D"], 
                ["2018-06-23", "09:41", "D", "accepts"]
            ]

        }
    end
    def self.line_array_content
        
        {
            output_one: [
                ['A','B'],
                [A: 1.00]
            ],
            output_two: [
                ['A','B','C'],
                [A: 1.5, B: 1.00]
            ]
        }
    end
    def self.invitations_array_test
        {
            
            output_one: [A: 1.00],
            output_two: [A: 1.00],
            output_three: [A: 1.75, B: 1.5, C: 1.00 ]

        }
    end

end


          