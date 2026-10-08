# Configuration

Configuring Matomo Reports is mainly about connecting to your Matomo server and
deciding how users authenticate to it. There is one settings form, two permissions,
and an optional per-user token field.

## Open the settings form

1. Log in as a user with the **Administer Matomo reports** permission.
2. Go to **Configuration → System → Matomo Reports**, or navigate directly to
   `/admin/config/system/matomo-reports`.

## Connection settings

The form writes to the `matomo_reports.matomoreportssettings` config object. Its
fields are:

- **Matomo server URL** — the base directory of your Matomo install, for example
  `https://analytics.example.com/matomo/`. On save the module pings
  `<url>/piwik.php` to check it is reachable and adds a trailing slash for you. If
  you leave this blank and the companion **Matomo** tracking module is installed, the
  reports module falls back to that module's configured server URL.
- **Global token_auth** — a single Matomo `token_auth` shared by everyone. If you set
  it, every user with the **Access Matomo Reports** permission sees reports through
  this one credential. Set it to the literal word `anonymous` for a public Matomo
  site. **Leave it blank** to require each user to supply their own token instead
  (see below).
- **Allowed sites** — a comma-separated list of Matomo site IDs the reports UI is
  restricted to, for example `1,4,12`. Leave it blank to allow every site the token
  can view.
- **Do not verify SSL** — when ticked, the module skips SSL certificate verification
  on requests to Matomo. This is for development against a self-signed certificate
  only; leave it off in production.

Click **Save configuration**.

## Per-user tokens

When the **global token_auth** is left empty, each user gets a **Matomo
authentication string** field on their own user-edit form (as long as they have the
**Access Matomo Reports** permission). They paste their personal Matomo `token_auth`
there, and their reports are scoped to whatever that token can see. The value is
stored per user via Drupal's `user.data` service, not in shared config.

If a global token is set, it always takes precedence over per-user tokens.

## Permissions

At **People → Permissions**, two permissions govern the module:

- **Access Matomo Reports** — view the report screens and the page-statistics block
  (and, when no global token is set, get the per-user token field on the profile).
- **Administer Matomo reports** — reach the settings form above.

Grant them to different roles if you want people to see reports without being able
to change the Matomo connection.

## The page-statistics block

To show per-page view counts, add the **Matomo page statistics** block
(`matomo_page_report`) through **Structure → Block layout**. This block requires the
companion **Matomo** tracking module, because it needs the tracked site ID.

## Setting it from the command line

```bash
drush cget matomo_reports.matomoreportssettings
drush cset matomo_reports.matomoreportssettings matomo_server_url 'https://analytics.example.com/matomo/' -y
drush cset matomo_reports.matomoreportssettings matomo_reports_token_auth 'anonymous' -y
drush cset matomo_reports.matomoreportssettings matomo_reports_allowed_sites '1,4' -y
```
