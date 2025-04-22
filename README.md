# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...






In a real-world scenario, if the API returned thousands of records or supported pagination, I would implement batching and paginated fetching. I might also chunk the insert_all calls into smaller slices (e.g., 500 records per batch) to avoid large single queries.

