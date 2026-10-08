# Configuration

fylr File Picker connects two systems, so configuration has three parts: point
Drupal at your fylr server, store the credentials safely, and add the picker to a
field.

## Open the settings form

1. Log in as a user with the **Administer easydb** (`administer easydb`)
   permission.
2. Go to **Configuration → Media → fylr File Picker**, or navigate directly to
   `/admin/config/media/easydb`.

## The settings

- **fylr server URL** (`easydb_server_url`) — the base URL of your fylr/easydb
  instance. This value also defines which cross-origin (CORS) requests Drupal will
  accept, so it must be exact.
- **Drupal base URL** (`drupal_base_url`) — your own site's base URL, used
  together with the server URL to work out the allowed CORS origins.
- **Files subdirectory** (`easydb_files_subdir`) — the target subdirectory where
  imported files are stored.
- **Language mapping** (`language_mapping`) — maps fylr languages to Drupal
  languages so imported metadata lands in the right translation on a multilingual
  site.

## Handling credentials safely

fylr File Picker talks to an external system with credentials, so treat those
credentials as secrets — never hard-code them in `settings.php` or commit them to
version control.

- **Store the secret in an environment variable.** With DDEV, save it into the
  project's dotenv file and restart so the container picks it up:

  ```bash
  ddev dotenv set .ddev/.env --easydb-api-key=<value>
  ddev restart
  ```

  The flag `--easydb-api-key` becomes the environment variable `EASYDB_API_KEY`.
  Keep `.ddev/.env` out of version control.

- **Reference it through a Key entity** where the module accepts one. Install the
  Key module if needed (`ddev composer require drupal/key` and
  `ddev drush en key -y`), confirm the variable is present in the container
  *without printing its value* (`ddev exec 'test -n "$EASYDB_API_KEY"'` — exit
  status 0 means it is set), then create a Key using the built-in environment
  provider so the secret is read from the variable rather than stored in config.

## Network egress — a caveat worth planning for

This module reaches **out** from your Drupal server to your fylr instance (and
fetches files by download URL during import). That means:

- Your server's firewall/egress rules must **allow outbound connections to the
  fylr host**, or imports will silently fail or time out.
- Imports fetch remote URLs server-side. The picker is gated by the
  `access easydb` permission; grant it to the editors who import media.

## Add the fylr Entity Browser to a field

Configuration is only useful once editors can reach the picker:

1. On a media or entity-reference field's form display, set its widget to use the
   **fylr Entity Browser** (`easydb_entity_browser`, installed with the module).
2. Open a content edit form, click to open the fylr picker, select assets in
   fylr, and confirm. The chosen files and their metadata are copied into Drupal
   as `easydb_image` media entities.

> **Tip:** The bundled example submodule installs a ready-made `easydb_article`
> node type already wired to the picker — a quick way to see the whole flow before
> configuring your own fields. Install **Chaos Tools (ctools)** if you prefer to
> edit the entity browser through a graphical UI (see the module's `README`).

## Save

Click **Save configuration** on the settings form. Once the server URL,
credentials, and field widget are in place, editors with **Access easydb** can
start importing assets straight from fylr.
