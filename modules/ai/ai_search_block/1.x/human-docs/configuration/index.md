# Configuration

AI Search Block is configured as a **block**: you place it in a region and set what
it searches. It relies on a working AI provider and an AI Search index, so make
sure those exist first (see the [AI Search](https://www.drupal.org/project/ai_search)
setup).

## 1. Confirm the prerequisites

- An **AI provider** is configured in the AI module, and its API key is stored as a
  Key entity (never in plain configuration).
- An **AI Search index** exists and has been populated, so there is content for the
  block to search.

## 2. Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the search box (for example a sidebar, or the
   header), click **Place block**.
3. Find the **AI Search** block and place it.

## 3. Configure the block

In the block's configuration form:

- Point it at the **AI provider** and the **AI Search index** it should use.
- Adjust presentation options (more are available if you enabled the **Extras** or
  **Header** submodules).
- Set the usual block visibility conditions (pages, roles) as needed.
- Save.

## 4. Governance and logging

- **Data flow:** queries and the content being searched are sent to the AI
  provider. Only expose this on content you are comfortable sending externally
  (unless your provider is local).
- **Logging:** if you enabled `ai_search_block_log` / `ai_search_block_log_tag`,
  remember the log records **search queries**, which can be sensitive. Restrict
  access to the log to trusted roles and decide on a retention approach.

## 5. Test it

Visit a page where the block appears and run a natural-language query. Confirm the
results are drawn from the expected content — and, as with any search over a vector
index, verify that restricted or unpublished content does **not** surface to users
who should not see it.
