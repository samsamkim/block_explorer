# NEAR Block Explorer (Take-Home Project)

This is a simple Rails application that fetches and displays NEAR blockchain transactions. It polls a mock API endpoint and shows historical transactions that involve **transfer actions**, persisting them locally for display.

![Screenshot 2025-04-21 at 6 35 16 PM](https://github.com/user-attachments/assets/e49dee5a-93dc-44d6-b93d-9d5fdf00d35e)

## Requirements
- Display a list of **transfers** with:
  - `sender`
  - `receiver`
  - `deposit`
- Show **historical** transactions even if they're no longer in the latest API response
- Only save transactions of type `"Transfer"`


## Versions
- Rails 8.0.1
- Ruby 3.2.2


## Setup Instructions

1. **Clone this repository**
```bash
git clone https://github.com/samsamkim/block_explorer.git
cd block_explorer
```

2. **Install dependencies**
```bash
bundle install
```

3. **Run the migration**
```bash
rails db:migrate
```

4. **Run the app**
```bash
bin/dev
```

5. **Fetch the NEAR transactions manually**
```bash
rails near:fetch_transactions
```


## Tests
To run the full test suite, please run:

```bash
bundle exec rspec
```


## Design Decisions

### Rails monolith over React/GraphQL
To keep things lightweight and focused on the assignment's core requirements, I chose to use Rails alone instead of introducing React or GraphQL. That said, if the application were to be expanded into a more complex or interactive frontend experience (e.g., real-time data updates, filtering, dynamic pagination), I'd consider splitting the frontend into a React app and exposing a GraphQL API. GraphQL would allow for:

- Fetching only the data the UI needs
- Simplifying client-side state management
- Better performance in highly interactive interfaces

### Saving only Transfer transactions
Again, to focus on the assignment's core requirements, I only saved "Transfer" transactions. In the future, if we want to keep all types of records, we can introduce a scope that would help us filter our transactions with something like the following:

```ruby
scope :transfers, -> { where("actions @> ?", [{ type: "Transfer" }].to_json) }
```


## Some Future Considerations and Improvements
### Pagination
Handles larger datasets gracefully, essential for performance when scaling

### Table Improvements
- Sorting
- Filtering

### Batched Inserts
If the API started returning thousands of records or more, I'd batch the insert_all calls, probably with something like this:

```ruby
batch_size = 500

records.each_slice(batch_size) do |batch|
  Transaction.insert_all(batch)
end
```

### Add Background Jobs
Sidekiq or another background job processor could be used to fetch transactions periodically without manual intervention

### Data Scalability
For extremely high-volume scenarios (millions/billions of transactions), we might want to consider:
- Indexing on common filter keys if we decide to add filtering
- Archiving old data to reduce query load
- Partitioning or sharding if it gets to billions of records
- Caching and queuing background jobs if necessary by Redis

### Security and Auth
Currently, the API key is loaded from an environment variable. In a production setting, we should probably use a credential management solution like Rails credentials and secure the /near/transactions endpoint behind authentication if needed

### Expand Test Coverage for Edge Cases
- Add tests for HTTP failures (e.g., 500, 404, 301) and unexpected response formats
- Cover edge cases like missing or invalid fields/data
- Test rake task behavior when the API returns no new data or duplicate transactions
