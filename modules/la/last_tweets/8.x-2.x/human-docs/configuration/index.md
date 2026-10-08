# Configuration

Last Tweets needs two things to show anything: a set of **X (Twitter) API
credentials** so it can call the API, and an **account** whose posts you want to
display. Both are entered on the module's settings form, and the feed itself is a
block you place wherever you want it.

## Open the settings form

1. Log in as a user with permission to administer Last Tweets (the module defines
   its own permission for this).
2. Go to the **Configuration** area and open the **Last Tweets** settings form.

## Fields on the settings form

- **X (Twitter) account** — the handle whose latest posts should be shown. The
  module supports **one account per language** or a single account used for all
  languages, so on a multilingual site you can point each language at a different
  feed.
- **Number of posts** — how many recent posts to display. The default is **3**.
- **API credentials** — the four values from your X developer app:
  - **Consumer key**
  - **Consumer secret**
  - **Access token**
  - **Access token secret**

Save the form once these are set. The block will then render the configured
account's most recent posts.

## Place the feed block

The posts are rendered through a **Last Tweets** block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the feed (a sidebar is
   typical), find **Last Tweets**, and place it.

## Handling the API credentials safely

The consumer secret and access token secret are **secrets** — anyone who has them
can act against your X app. Keep them out of version control and out of any
exported configuration you commit.

- **Never hard‑code or commit** the credentials. If your workflow exports site
  configuration to Git, make sure these values are not written into a tracked
  config file.
- **Prefer environment variables.** With DDEV you can store a value in the web
  container's environment without committing it:

  ```bash
  ddev dotenv set .ddev/.env --twitter-consumer-secret=<value>
  ddev restart
  ```

  Keep `.ddev/.env` out of version control. Repeat for each secret you want to
  keep out of the database/config, and reference the variable from settings where
  supported (`getenv('TWITTER_CONSUMER_SECRET')`), or paste it into the form only
  on environments where that is acceptable.
- **Rotate credentials** in your X developer portal if they are ever exposed, and
  scope the app to read‑only access if you only need to display posts.

## A note on egress and API tiers

This module makes **outbound HTTPS calls from your server to the X API**. Your
hosting environment must allow that egress, and the posts you fetch are public
content served back into your pages. Bear in mind that X changes its API tiers
and terms often — verify your app's tier still allows the read calls before
depending on the feed in production.
