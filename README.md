# README

## Setup

1. Clone the project
2. Install ruby version 3.1.0
3. Run the installer

    `./bin/setup`
4. Start the server
    `rails server`
5. Start Sidekiq
    `bundle exec sidekiq`

## Adding users

Start rails console `rails console` and run `User.create!(token: <TOKEN HERE>)`

## API

- Adding photos:
    Make a POST request to `localhost:3000/photos` with the user's token in Authorization header in the format `Token <TOKEN HERE>`. The body should include `photo_urls` array that includes a list of valid URLs (example valid URL: `https://www.example.com/photo.jpg`)
