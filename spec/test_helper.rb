
def get_file input
  file = File.open("#{RSPEC_ROOT}#{input[:input_file]}")
end
def get_all_users_scores tree_arr
  all_scores={}
  tree_arr.each{|root|
        root.each{|node|
            all_scores[node.name.to_sym]= node.content[:score] if node.content[:score]!=0
        }
    }
    all_scores
end

def get_all_users_names tree_arr
    tree_arr.collect{|node|
        node.collect(&:name)
    }.flatten
end


def process_accept_recommend_for_test(subject,recommendation_acceptense)
    subject.line_content = set_test_split_variables(recommendation_acceptense)
    status=recommendation_acceptense.to_s.split("_").last.to_sym
    case status
        when :recommends
            subject.process_recommendation
        when :accepts
            subject.process_acceptence
    end
end

def set_test_split_variables(recommendation_acceptense)
    TestVariables.split_words_of_line_mock[recommendation_acceptense]
end