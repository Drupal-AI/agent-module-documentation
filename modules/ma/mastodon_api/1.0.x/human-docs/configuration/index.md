# Configuration

Setting up Mastodon API happens in two places: first on **Mastodon** (where you
register an application and get an access token), then in **Drupal** (where you
enable the connection, add one or more instances, store the token securely, and
send a toot). You will need the **`administer mastodon api`** permission (and
**`administer mastodon_api_instance`** to manage instance entities).

## Step 1 — Create the application on Mastodon

1. On your Mastodon instance, go to the **`/settings/applications`** page and
   create a new application.
2. Fill in the application name and website with your own values. Leave the
   **redirect URI** at the platform default.
3. Grant the application these permissions (scopes):
   - `read:statuses`
   - `profile`
   - `write:media`
   - `write:statuses`
4. Once the app is approved, copy the **access token** from its authentication area
   — you will need it in Drupal in a moment. Treat this token as a secret.

## Step 2 — Connect Drupal

1. In Drupal, go to **Configuration → Web services → Mastodon API**
   (`/admin/config/services/mastodon`).
2. **Enable** the connection to Mastodon on this page.
3. Open the **Instances** sub‑menu and **create a new Mastodon API Instance**. You
   will need the instance's **address** and the **access token** from step 1.
4. Use the **Validate Auth** tab to confirm the authentication works for the
   instance.
5. Run **Fetch configuration from instance** on the instance's auth settings form.
   This pulls in the instance's configuration items and sets any settings the
   module can derive from them.

## Step 3 — Store the access token securely

This is the important part. The access token is **never written to the site's
exported configuration**, because that would leak the credential. Instead:

- By default the module saves the token to the Drupal **State API**, which lives
  with the database (not in exported config).
- For secure deployment you can instead supply the token from **`settings.php`**,
  keeping it out of the database export entirely. For an instance whose machine
  name is `my_mastodon_instance`:

  ```php
  $settings['mastodon_api.my_mastodon_instance.mastodon_access_token'] = 'your-token-here';
  ```

  After adding it, re‑save the Mastodon API form to have the value written through
  from settings.

Whichever route you choose, **do not hard‑code the token in committed code or
configuration.** The recommended pattern is to keep the secret in an environment
variable and reference it from `settings.php` — for example
`getenv('MASTODON_ACCESS_TOKEN')` — so the real value never lands in version
control.

> **Using DDEV?** Store the secret as an environment variable rather than in a
> committed file: `ddev dotenv set .ddev/.env --mastodon-access-token=<value>`
> (this creates `MASTODON_ACCESS_TOKEN`; keep `.ddev/.env` out of version
> control), then `ddev restart`. Reference it from `settings.php` with
> `getenv('MASTODON_ACCESS_TOKEN')`.

## Step 4 — Send a toot

Once an instance is authenticated, open the **Push Status** tab, choose the
instance you want to toot to, write your status, and post. If you enabled the
**Mastodon API Entity** submodule, use its **Entity** tab to attach the push form
to a content type — then you can toot an item's content directly from that entity
with one click.

## Permissions

- **Administer Mastodon API** (`administer mastodon api`) — configure the module's
  settings.
- **Administer Mastodon API Instance** (`administer mastodon_api_instance`) —
  configure the instance configuration entities.

Grant both only to trusted administrators, since they control the connection and
which account content is published to.
