# Configuration

The base Quickchat module has no settings form — it only provides the API client.
Configuration happens where you actually use Quickchat: in the **Sync** submodule's
settings and on the **chatbot block**. Both need details from your Quickchat
account at `https://app.quickchat.ai/`: a **Scenario ID** and an **API token**.

## Quickchat Sync settings

With `quickchat_sync` enabled, go to **Configuration → Web services → Quickchat API
→ Sync** (`/admin/config/services/quickchat-api/sync`). This is where you provide
the connection details (API token / scenario) the client uses to talk to Quickchat,
and where you manage how knowledge‑base entries are synced to train your chatbot
model. You then create and edit those entries as `quickchat_kb` content and operate
the sync from **Content → KB** (`/admin/content/kb`).

## Chatbot block

With `quickchat_chatbot` enabled, place a **chatbot** block through **Structure →
Block layout** (`/admin/structure/block`). On the block you set the **scenario ID**
for the Quickchat scenario you want that block to open, so different regions or
pages can surface different assistants.

## Store the API token as a secret

Your Quickchat API token is a credential — anyone who has it can use your Quickchat
account. Keep it out of the codebase:

- Store the token in an environment variable rather than committing it. On DDEV, the
  built‑in dotenv helper keeps it out of the repo:

  ```bash
  ddev dotenv set .ddev/.env --quickchat-api-token='your-token'
  ddev restart
  ```

  (`.ddev/.env` must stay out of version control.)
- Where the form accepts it, prefer referencing the token through a **Key** entity
  backed by that environment variable instead of pasting the raw value into
  configuration.

## Mind the data egress

Quickchat is a hosted third‑party AI service. Content you send to the chatbot and
knowledge‑base entries you sync leave your site and are processed on Quickchat's
servers. Before syncing anything, confirm that sending that content to an external
provider is acceptable for your site's privacy and data‑handling requirements. Also
make sure the connection runs over HTTPS.
