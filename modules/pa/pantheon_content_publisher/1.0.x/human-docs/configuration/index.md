# Configuration

Setting up Pantheon Content Publisher has three parts: storing your access token
securely, creating a Search API server for the content, and adding a collection
that links Drupal to your Content Publisher collection.

## 1. Store the access token as a secret

The connection to Pantheon uses an **access token**. Treat it as a secret — never
hard-code it or commit it to exported configuration. The recommended pattern is an
environment variable surfaced through a **Key** entity:

1. Save the token into an environment variable. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --pantheon-content-publisher-token=<your-token>
   ddev restart
   ```

   The flag `--pantheon-content-publisher-token` becomes the variable
   `PANTHEON_CONTENT_PUBLISHER_TOKEN`. Keep `.ddev/.env` out of version control.

2. Confirm the variable is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$PANTHEON_CONTENT_PUBLISHER_TOKEN"'   # exit status 0 = set
   ```

3. Install the Key module if it isn't already, and create a Key that reads the
   variable:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save pantheon_content_publisher_token \
     --label='Pantheon Content Publisher Token' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"PANTHEON_CONTENT_PUBLISHER_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

You can then select this Key when entering the access token below, so the secret
stays out of the database and config export.

## 2. Create a Search API server

Pantheon Content Publisher indexes the content it brings in through **Search API**,
so a Search API server must exist first:

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
2. **Add server**, choose a backend, and save it. (Follow the Search API
   documentation for the backend you use.)

## 3. Add a Content Publisher collection

1. Go to **Structure → Pantheon Content Publisher Collection** and **add a new
   collection**.
2. **Access token** — enter (or select, via the Key you created above) your
   Pantheon Content Publisher access token.
3. **Collection Identifier** — enter the identifier shown for your collection in
   the **Content Publisher dashboard**.
4. Save. Drupal is now linked to that Content Publisher collection and can receive
   drafts, previews, and published content from Google Docs, subject to the
   approval workflow you configure.

## Permissions and security

- Grant the module's permission (at **People → Permissions**) only to the roles
  that should manage the Content Publisher connection.
- Keep all traffic over **HTTPS**, and store the token as a secret as described
  above rather than in exported config.
- Content published from the external source flows into Drupal; treat imported
  content according to how much you trust that source.

For the full end-to-end setup, also consult Pantheon's own Content Publisher
documentation.
