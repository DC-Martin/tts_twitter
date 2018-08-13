module TweetsHelper

  def get_tagged(tweet)
    #Looking for tags... split will split tweet array into individual words
    message_arr = @tweet.message.split
    message_arr.each_with_index do |word, index|
      #create a new instance of Tag
      if word[0] == "#"
        if Tag.pluck(:phrase).include?(word.downcase)
          #save that tag as a variable
          tag = Tag.find_by(phrase: word.downcase)
        else
          #else, create a new tag
          tag = Tag.create(phrase: word.downcase)
        end
        
      tweet_tag = TweetTag.create(tweet_id: @tweet.id, tag_id: tag.id)

      message_arr[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
      end
    end

    @tweet.update(message: message_arr.join(" "))
    return tweet
  end

end
