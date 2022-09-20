class ContactOptions

  def initialize
    @contects = eval(IO.read('./public/contects_data.rb'))
  end

  def perform
    max = 0
    max_object_index = 0

    result = @contects.map.with_index do |content, index|

      if content[:introsOffered][:free] > max and content[:introsOffered][:vip] == 0
        max = content[:introsOffered][:free]
        max_object_index = index
      end

      max_object = [max, content[:introsOffered][:free]].max

      ranking_calculate = contact_ranking_calculation(content[:email], content[:introsOffered])

      name_array = content[:name].split(" ")

      {
        name: content[:name],
        first_name: name_array[0],
        last_name: name_array[1],
        email: content[:email],
        intros_offered: content[:introsOffered],
        rank: ranking_calculate,
        offer: 'free'
      }
    end

    result[max_object_index][:offer] = 'vip'

    result.sort_by { |object| [object[:last_name], object[:first_name]] }
  end

  def contact_ranking_calculation(email, offered)
    default_rank = 3
    default_rank = 2 if find_email_rank(email)
    default_rank = 1 if offered[:free] > 0 and offered[:vip] > 0
    default_rank
  end

  def find_email_rank(email)
    regex_mail1 = /(gmail.com)/
    regex_mail2 = /(hotmail.com)/

    email.match(regex_mail1) or email.match(regex_mail2)
  end

  private

end

# content = ContactOptions.new
# result = content.perform()
#
# puts(result)


