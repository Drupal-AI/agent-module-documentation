# Configuration

Instagram Sync is configured on its settings form, where you connect an Instagram
account and control how posts are imported.

## Open the settings form

1. Log in as a user with the permission Instagram Sync provides for administering
   its settings (an administrator by default).
2. Go to **Configuration** and open the **Instagram Sync** settings form (the
   `instagram_sync.settings_form` route).

## Before you start: generate an access token

Instagram Sync authenticates with a **long‑lived Instagram access token**. Using
the Instagram API (with Instagram Login), generate a long‑lived token for the
account whose posts you want to mirror. Have that token ready to paste into the
form.

## The settings

The form collects the details needed to talk to the Instagram API and to control
the import:

- **Access token** — paste the long‑lived Instagram token here. This is the
  credential the module uses on every sync, so treat it as a secret (see below).
- **Auto‑sync period** — how often the module re‑fetches posts, so your local
  copy stays current. Sync runs on Drupal's cron, so make sure cron is running
  regularly.
- **Media handling** — options to avoid downloading media data you don't need,
  keeping the import lean when you only want a subset of each post's assets.

Fill in the fields and save. The module will import the account's posts — images,
videos and carousels — as entities you can then display.

## Keeping the token secure

The access token grants API access to the connected account, so keep it out of
harm's way:

- Never commit the token to version control or paste it into exported
  configuration. If you manage secrets with environment variables, store it there
  and reference it rather than hard‑coding it.
- In **DDEV**, you can store a secret in the container's environment with
  `ddev dotenv set .ddev/.env --instagram-token=<value>` (keep `.ddev/.env` out
  of version control) and `ddev restart` so DDEV loads it.
- Keep the connection on HTTPS and **refresh the token per Meta's policy** before
  it expires, or syncing will stop working.

## Run and verify the first sync

After saving, trigger a sync (via the form's controls or by running cron) and
check that Instagram post entities have been created. Build a View or block over
those entities to render the feed on your site.
