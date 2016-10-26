# Image uploader

## About

This is my minimal image uploader. I eventually want to expand this into a Tumblr-like service, with tags, user pages, searching, following, etc.

## Get started

`$ bundle install --without production && rake db:migrate`

Run tests with:

`$ rake`

Load server with:

`$ rails server` and then go to `http://localhost:3000`

Start the thumbnail background thread in another thread with:

`INTERVAL=5 QUEUE=serve_thumbnail rake environment resque:work`

## Eventual roadmap:

- Index page with thumbnails created by worker tasks
- Users
- Tagging
- Searching
