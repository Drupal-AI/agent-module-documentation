# Configuration

Getting Nextcloud DAM working takes three parts: connecting Drupal to Nextcloud
(through Social Auth Nextcloud), preparing the media type(s), and wiring the entity
browser onto a field so editors can pick assets. There is no single settings
dashboard — you touch a few core areas.

## 1. Connect to Nextcloud (Social Auth Nextcloud)

Authentication to Nextcloud is handled per user by the **Social Auth Nextcloud**
module over OAuth2, so the connection credentials — the OAuth2 **client ID** and
**client secret** you register in your Nextcloud instance — are configured there,
not in Nextcloud DAM. Follow the Social Auth Nextcloud documentation to:

1. Register an OAuth2 application in your Nextcloud instance (and make sure the
   **Webapppassword** app is installed on Nextcloud).
2. Enter the Nextcloud host and the OAuth2 client ID / secret into Social Auth
   Nextcloud's settings.
3. Have each editor connect their account, so the entity browser can present their
   Nextcloud content. Tokens are short‑lived OAuth2 tokens that expire regularly;
   users re‑authorise from Nextcloud when needed.

To support **multiple Nextcloud instances**, configure the additional connections
in Social Auth Nextcloud — each user's connected accounts determine which
Nextclouds they can browse.

## 2. Prepare media types (optional)

The module ships a single `nextcloud` media type. If you want to separate asset
kinds, you can replicate it at **Structure → Media types**
(`/admin/structure/media`) into, for example, "nextcloud image", "nextcloud video",
and "nextcloud document".

## 3. Wire the entity browser onto a field

The module does **not** attach itself to your content automatically — this step is
required:

1. On the content type, add an **entity reference** field that references your
   Nextcloud media type — e.g. at
   `/admin/structure/types/manage/article/fields`.
2. On the content type's **Manage form display**
   (`/admin/structure/types/manage/article/form-display`), set that field's widget
   to the **Entity browser** widget with:
   - **Entity browser:** `nextcloud_filepicker`
   - **Field widget display:** `rendered_entity`
   - Enable edit / remove as you prefer; typically `field_widget_edit: true`,
     `field_widget_remove: true`, `field_widget_replace: false`, `open: false`,
     with `view_mode: default` and `selection_mode: selection_append`.
3. If you created extra media types, review the entity browser's widget mapping at
   `/admin/config/content/entity_browser/nextcloud_filepicker/widgets`.

Editors then use the picker on the node form to browse Nextcloud and reference
assets. If a user has several Nextcloud credentials, one picker renders per
connected Nextcloud.

## Store the OAuth credentials as secrets

The Nextcloud OAuth2 **client secret** (configured via Social Auth Nextcloud) is
sensitive. Never commit it to version control or exported configuration — keep it in
an environment variable and reference it through Drupal.

1. **Store the value in a DDEV environment variable** (do not commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --nextcloud-oauth-secret=<value>
   ddev restart
   ```

   The flag `--nextcloud-oauth-secret` becomes the variable
   `NEXTCLOUD_OAUTH_SECRET`.

2. **Confirm it is present in the container without printing it:**

   ```bash
   ddev exec 'test -n "$NEXTCLOUD_OAUTH_SECRET"'   # exit status 0 means set
   ```

3. **Expose it to Drupal via a Key entity** (install the Key module if needed —
   `ddev composer require drupal/key && ddev drush en key -y`):

   ```bash
   ddev drush key:save nextcloud_oauth_secret --label='Nextcloud OAuth client secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"NEXTCLOUD_OAUTH_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   Reference that Key from the Social Auth Nextcloud configuration where it accepts
   one; otherwise read the value in settings.php via
   `getenv('NEXTCLOUD_OAUTH_SECRET')`.

## Egress note

The file picker talks to your Nextcloud server's API over HTTPS (largely from the
user's browser). Ensure your Nextcloud instance is reachable over HTTPS and that
its **Webapppassword** app permits the connection. Only expose Nextcloud content
that is appropriate for the audience who can use the picker.
