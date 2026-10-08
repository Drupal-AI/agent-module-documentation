# Configuration

Setup has three parts: store the access token securely with **Key**, enter your
account details on the module's settings form, and place a feed block.

## 1. Store the access token with Key (recommended: environment variable)

The access token is a **secret** — it grants access to your Instagram content, so
it should never be committed to version control or pasted into exported
configuration. This module stores it through the **Key** module, which lets you
keep the value out of the database.

On this project's DDEV-based convention, the cleanest approach is an environment
variable surfaced through a Key entity:

1. Save the token into DDEV's environment (this does **not** get committed):

   ```bash
   ddev dotenv set .ddev/.env --instagram-access-token=<your-long-lived-token>
   ddev restart
   ```

   The flag `--instagram-access-token` becomes the variable
   `INSTAGRAM_ACCESS_TOKEN` inside the web container.

2. Create a Key that reads from that environment variable (the env provider ships
   with the Key module):

   ```bash
   ddev drush key:save instagram_access_token \
     --label='Instagram Access Token' --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"INSTAGRAM_ACCESS_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   You can also create the Key through the UI at **Configuration → System →
   Keys** if you prefer.

## 2. Enter your account details on the settings form

On the module's settings form (access is gated by the **administer instagram feed
block** permission):

- **Instagram Business Account ID** — the numeric ID of the connected business or
  creator account whose posts you want to show.
- **Access token** — select the Key you created above so the module can
  authenticate to the Graph API.
- **Cache lifetime** — how long fetched results are cached before the module calls
  the API again. A longer lifetime reduces API calls (and stays within Meta's rate
  limits) at the cost of slightly less fresh content.

## 3. Place a feed block and set its display options

1. Go to **Structure → Block layout** (`/admin/structure/block`), or use Layout
   Builder, and place an **Instagram Feed** block.
2. In the block's settings, configure per-block display and filtering:
   - **Number of posts** to show.
   - **Date filtering** — a custom date range, or a "last X days" window (for
     example the last 7, 14, or 30 days).
   - **Hashtag filter** — show only posts with a given hashtag from the account.
3. Save the block.

## Verify it worked

View a page where the block is placed. Recent Instagram posts from your account
should render in a responsive grid. If the block is empty, re-check that the
access token Key resolves correctly, that the account ID is right, and that your
Graph API access and token are still valid — Meta tokens expire and API access is
subject to platform limits.
