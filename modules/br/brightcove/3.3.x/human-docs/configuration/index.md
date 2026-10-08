# Configuration

Setting up Brightcove has a few parts: connect an API client, run a sync, and grant
permissions. Cron and subscriptions are optional refinements. Everything here
requires the **administer brightcove configuration** permission.

## Register an API Client

The API Client is your saved connection to a Brightcove account.

1. Go to **Configuration → Media → Brightcove Video Connect API Client settings**
   (`/admin/config/media/brightcove_api_client`) and click **Add Brightcove API
   Client**.
2. Fill in the fields:
   - **Label** and machine name — a friendly name for this connection.
   - **Account ID** — your Brightcove Account ID.
   - **Client ID** — the OAuth Client ID from your Brightcove API credential.
   - **Secret key** — the OAuth client secret.
   - **Default player** — the Brightcove player used by default for this account's
     videos.
   - **Max custom fields** — a cap on how many custom fields are fetched for the
     account (leave the default unless you have a large number).
3. **Save.** On save, the module immediately tries to authenticate with Brightcove:
   it exchanges your Client ID and secret for an OAuth access token and verifies the
   account by counting its videos. If the credentials are wrong you'll see an error;
   if they work, the client shows an OK status.

You can register several API clients to manage multiple Brightcove accounts from one
site.

> Keep your secret out of exported configuration where possible — see the note in
> [Installation](../installation/index.md#handling-your-api-secret-safely).

## Run the first sync

Once a client is connected, pull the Brightcove library into Drupal. You have three
options, all equivalent:

- **On cron** — the module syncs automatically on each cron run (unless you disable
  it, below).
- **From the command line** — run `drush brightcove:sync-all` (alias `drush bcsa`).
- **From the Status Overview** — go to **Reports → Brightcove**
  (`/admin/reports/brightcove`), which shows the sync queues and lets you re‑run or
  clear them.

After the sync, your Brightcove videos, playlists, players, custom fields, and text
tracks exist as local Drupal entities you can display and reference.

## Cron settings

Visit **Configuration → System → Brightcove Cron settings**
(`/admin/config/system/brightcove_cron`) to control the automatic sync. The key
option lets you **disable the Brightcove cron sync** entirely — useful if you'd
rather sync only manually or via `drush bcsa` (for example on a schedule you control
outside Drupal). Manual and queue‑based syncing keep working even when cron sync is
off.

## Subscriptions (push updates from Brightcove)

Subscriptions make changes flow *back* from Brightcove into Drupal. Go to
**Configuration → System → Brightcove Subscriptions**
(`/admin/config/system/brightcove_subscription`). There you can create, enable,
disable, and delete subscriptions (they can't be edited once created — delete and
recreate to change one). Each subscription registers a notification endpoint with
Brightcove so that when a video changes over there, your matching Drupal entity is
updated at the module's notification callback.

## Permissions

Under **People → Permissions**, grant the permissions that fit your editorial roles:

- **administer brightcove configuration** — the master admin permission covering API
  clients, subscriptions, cron settings, and the status report. Grant only to
  trusted administrators.
- **Video permissions** (`brightcove_video`): *add*, *access overview page*, *edit*,
  *delete*, *view published*, and *view unpublished* Brightcove videos. There's also
  an *administer brightcove videos* permission that is access‑restricted — grant it
  sparingly.
- **Playlist permissions** (`brightcove_playlist`): the same set for playlists.
- **Text track permissions** (`brightcove_text_track`): *add*, *delete*, *view
  published*, and *view unpublished* text track entities.

## What the module installs for you

Enabling Brightcove also sets up some ready‑made pieces:

- A **video tags** taxonomy vocabulary (`brightcove_video_tags`) for tagging videos.
  The module protects this vocabulary from editing or deletion.
- An **image style** for video list thumbnails.
- Two **Views** — one listing all videos, and one listing videos by API client.
- **Token** integration for Brightcove entity fields.

You generally don't need to configure these; they're there to build on.
