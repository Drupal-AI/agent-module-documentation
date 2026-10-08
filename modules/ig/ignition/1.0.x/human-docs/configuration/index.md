# Configuration

Ignition needs two things to be right: the module's own settings form, and
Drupal's error-display level. It also introduces one permission that decides who
gets to see the error pages. Because everything here is about *showing* sensitive
debugging information, the most important configuration step is making sure none of
it is active on production.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Ignition**, or navigate directly to
   `/admin/config/development/ignition`.

## The settings form

The form controls whether Ignition is active and how it stores your display
preferences:

- **Enable Ignition** — the master switch. When off, Drupal falls back to its
  normal error handling even if the module is installed.
- **Store settings in `~/.ignition.json`** — when ticked, the display preferences
  you pick on the error page (colour theme, code editor) are written to a file in
  the server user's home directory rather than kept per user/session. This lets you
  share the same look across projects, but the file is **shared by everyone using
  that server account**, so only use it on a personal, non-shared local machine.
  Leave it off on any environment more than one person touches.

The colour theme and the editor used for the code preview are also adjustable from
the error page itself — click the cog icon in its top-right corner. Those choices
are remembered in your user or session storage across requests.

### Optional AI explanations

Ignition can ask a model to explain an error and offer a fix directly in the page.
This is optional. If you enable AI integration you will need to supply an API key
for the provider — store that **as an environment variable, never hard-coded**. In
DDEV, set it with `ddev dotenv set .ddev/.env --openai-api-key=<value>` and
`ddev restart`, and reference it through a Key entity rather than pasting the value
into a form. Keep this feature to local development only.

## Required error/log level

Ignition renders **only** when Drupal's error display is set to verbose. Under
**Configuration → Development → Logging and errors**
(`/admin/config/development/logging`), set **Error messages to display** to **All
messages, with backtrace information**. If it is set to *None* or *Errors and
warnings*, Drupal handles errors itself and Ignition never appears.

## The `view ignition error page` permission

Whoever holds **view ignition error page** sees the full Ignition screen —
**source code, stack traces and request context** — whenever an error occurs. That
is the module's purpose, and it is also why the permission must be handled with
care:

- Grant it only to the developers who need it.
- Do **not** leave it granted on a production site.
- Revoke it once you have finished debugging.

## Keep it out of production

Even with the module disabled, the safest posture is to force production's error
display off in code. Add a guard like this to `settings.php` (or a
per-environment settings file) so verbose errors can never surface live:

```php
if (SITE_IS_PROD) {
  $config['system.logging']['error_level'] = 'hide';
}
```

On Acquia, key the same guard off the environment variable:

```php
if (isset($_ENV['AH_SITE_ENVIRONMENT']) && $_ENV['AH_SITE_ENVIRONMENT'] === 'prod') {
  $config['system.logging']['error_level'] = 'hide';
}
```

As a general rule, production error display should always be **None** regardless of
whether Ignition is installed.

## Save

Click **Save configuration** on the settings form. Clear the cache
(`drush cr`) if the change does not take effect immediately.
