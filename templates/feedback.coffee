exports.Template = (feedback) ->

  # grab tweet data from items list
  tweets = (item.tweet for item in feedback.tweets)

  # sort by most recent
  tweets.sort (a, b) ->
    new Date(b.created_at).getTime() - new Date(a.created_at).getTime()

  # find tweets with images and store for easier access
  for tweet in tweets
    image = null
    if tweet.entities?.media
      images = (m for m in tweet.entities.media when m.type is 'photo')
      tweet.image = images[0].media_url if images.length > 0

  div '.title', ->
    h1 ->
      'Customer Tweets'

  div '.tweets', ->
    for tweet in tweets

      root = 'https://www.twitter.com'
      user_url = "#{root}/#{tweet.user.screen_name}"
      tweet_url = "#{root}/#{tweet.user.screen_name}/status/#{tweet.id_str}"

      div '.tweet', ->

        div '.top', ->

          a '.avatar', href: user_url, ->
            img src: tweet.user.profile_image_url

          div '.username', ->
            a href: user_url, ->
              "@#{tweet.user.screen_name}"

          a '.posted', href: tweet_url, ->
            time = new Date(tweet.created_at).toString()
            [day, month, date, year] = time.split ' '
            "#{month} #{date}, #{year}"

        # tweet text
        div '.text', ->
          raw tweet.text

        # actions
        div '.footer', ->

          span '.share', ->
            i '.icon-reply'
            span ->
              "#{tweet.retweet_count}"

          span '.share', ->
            i '.icon-star'
            span ->
              "#{tweet.favorite_count}"

        # user name
        div '.name', ->
          " - #{tweet.user.name}"

      # media (image)
      if tweet.image
        div '.tweet image', style: "background-image: url('#{tweet.image}')", ->
