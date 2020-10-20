#This class will make sure that user enters valid data cal se business logic by processing the 
#data provides inputs to the processing methods by validates the information sort the information 
#in correct order.

class ProcessFile
    attr_reader :file

    # This method takes file as input and creates tree with scores using do process method
    def analyze_and_process_inputs(file)
        do_process(file.to_a)
    end

    #This method takes a file lines array, validates it and uses invitation manager to score and organize the data
    def do_process file_arr
        @invitation_manager = InvitationManager.new
        get_sorted_array(file_arr).each do |line|
            @invitation_manager.line_content = split_words_of_line(line)
            next unless @invitation_manager.line_content
            action = @invitation_manager.line_content[:action]
            case action
                when :recommends
                    @invitation_manager.process_recommendation
                when :accepts
                    @invitation_manager.process_acceptence
            end
        end
        @invitation_manager.multi_way_forest_root_arr
    end
    

    #This method splits the given line into words and sorts the arrays based on date and time
    def get_sorted_array(file_arr)
        file_arr.collect{|l|
            l.chomp.split
        }.sort{|a,b|
            [a[0], a[1], b[3]] <=> [b[0], b[1], a[3]]
    }
    end

   # This method takes each line as input and discards digited values tike abc123, 09:22
    def split_words_of_line line
        if is_valid(line) 
            input_arr = line.collect{|word|
                unless has_digits?(word)
                    word
                end
            }.compact
            {
                sent_or_accepted_by: input_arr[0],
                action: input_arr[1].to_sym,
                recived_by: input_arr[2]
            }
        else
            false
        end
    end

  private
    #This method validates the correctness of the string 
    def is_valid line_arr
        case line_arr[3]
            when 'accepts'
                return false if line_arr.length !=4 || !is_valid_date?(line_arr[0]) || !is_valid_time?(line_arr[1])
            when 'recommends'
                return false if line_arr.length !=5 || !is_valid_date?(line_arr[0]) || !is_valid_time?(line_arr[1])
            else
                return false
        end
    true
    end

    def is_valid_date? date
        y,m,d = date.split '-'
        Date.valid_date?(y.to_i, m.to_i, d.to_i)
    end

    def is_valid_time? time
        time =~ /^([01]?[0-9]|2[0-3])\:[0-5][0-9]$/
    end
    #This method verifies the availabulity of numbers in the string
    def has_digits?(str)
            str.count("0-9") > 0
    end
end