
# Deliveries

## Description

Deliveries is a web application designed to manage and track deliveries efficiently. It offers features such as:

- Creating, viewing, and editing delivery records.
- Optimized routing for deliveries based on pickup addresses.
- Interaction with an LLM (Language Model) for insights and queries about delivery data.

---

## Installation

### Prerequisites
- Ensure you have Ruby and Rails installed on your system.
- Install the necessary dependencies by running:
  ```bash
  bundle install
  ```

### Starting the Application
1. Run the Rails server:
   ```bash
   rails server
   ```
2. Open your browser and navigate to [http://localhost:3000](http://localhost:3000) to start using the application.

---

## LLM Interaction

To enable interaction with the Language Model:

1. Create an `.env` file in the root of your project.
2. Add your OpenAI API key:
   ```bash
   OPENAI_API_KEY=your_openai_api_key
   ```
   You can generate your API key at [OpenAI's API](https://openai.com/index/openai-api/).  
   **Note:** A paid plan may be required for requests.

---

## Optional Steps

### Populate the Database
You can seed the database with sample data by running:
```bash
rails db:seed
```

### Clear Chat Sessions
The CleanupChatSessionsJob runs in the background using Sidekiq to automatically delete expired chat sessions. This requires redis to be running. Start Redis with:
```bash
redis-server
```

---

## Features

- **Delivery Management**: Easily create, edit, and view delivery records.
- **Optimized Routing**: Group and sort deliveries by pickup addresses to minimize travel distance.
- **LLM Insights**: Query delivery data with the help of a powerful Language Model integration.

---


## License

This project is open-source and available under the [MIT License](LICENSE).
