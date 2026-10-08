# Configuration

There are two parts to setting up Media Entity Facebook: creating a **media
type** backed by the Facebook source, and (optionally) choosing between the two
**embed modes** on the settings form.

## Step 1 — Create a Facebook media type

The module doesn't ship a media type; you create one:

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give it a name (for example "Facebook").
3. For **Media source**, choose **Facebook**.
4. Save.

Selecting the Facebook source automatically creates a text source field where
editors paste a Facebook URL (or an `<iframe>` embed), applies the
`facebook_embed` formatter to it, and adds the validation constraint that
rejects anything that isn't a `facebook.com` / `fb.watch` address. You can map
the exposed metadata — author name, width, height, URL, and the embed HTML — to
fields on the media type via **Manage fields** / the source's field mapping if
you want to store those values.

Once the media type exists, editors can add Facebook media at
*Content → Media → Add media*, or directly inside the core **Media Library**
modal when inserting media into content (a single textarea where they paste the
URL).

## Step 2 — Choose the embed mode

Open the settings form at **Configuration → Media → Facebook settings**
(`/admin/config/media/facebook-settings`). It requires the **Administer media**
permission. (The module doesn't add a "Configure" link on the modules page, so
reach it via the menu or path.)

The form saves three values in the `media_entity_facebook.settings` config
object:

- **Use embedded posts** — this is the mode switch.
  - **On (default)** — **Embedded Posts** mode. Facebook's JavaScript SDK
    renders the post in the visitor's browser. No Facebook app or review is
    needed, and you can leave the App ID / App Secret blank. This is the
    recommended starting point for most sites.
  - **Off** — **oEmbed API** mode. Drupal calls Facebook's Graph API
    server-side to fetch ready-made embed HTML (photos and posts use the
    `oembed_post` endpoint, videos use `oembed_video`), caching each response
    for about 10 minutes. This mode **requires a reviewed Facebook app** and a
    valid App ID and Secret — if either is missing the fetch logs an error and
    renders nothing.
- **Facebook App ID** — your Facebook app's ID. Only used in oEmbed API mode.
- **Facebook App Secret** — your Facebook app's secret. Only used in oEmbed API
  mode, where it is combined with the App ID to form the API access token.

After changing the mode, clear the cache (`drush cr`) so cached pages pick up
the new rendering.

### Keeping the App Secret out of exported config

Because these are ordinary config values, if you use the oEmbed API mode you can
keep the real credentials out of your exported configuration by overriding them
per environment. Store the secret in an environment variable and reference it
from `settings.php`:

```php
$config['media_entity_facebook.settings']['facebook_app_id'] = getenv('FACEBOOK_APP_ID');
$config['media_entity_facebook.settings']['facebook_app_secret'] = getenv('FACEBOOK_APP_SECRET');
```

You can also set the values directly with Drush:

```bash
drush config:set media_entity_facebook.settings use_embedded_posts false -y
drush config:set media_entity_facebook.settings facebook_app_id '<id>' -y
drush config:set media_entity_facebook.settings facebook_app_secret '<secret>' -y
drush cr
```

## A note on trust

The embed output deliberately renders Facebook's markup/SDK, and the URL
reaching the template is reduced to a facebook-domain address by the validation
constraint. Keep that constraint in place, only grant Facebook-media
create/edit rights to trusted editors, and never feed the source field
unvalidated user input.
