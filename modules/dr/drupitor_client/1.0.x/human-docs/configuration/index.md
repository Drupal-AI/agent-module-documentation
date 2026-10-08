# Configuration

Drupitor Client does nothing until you configure it. The module starts disabled
on purpose — because its endpoint reveals which module versions you run — so this
step both switches the endpoint on and locks it behind an API token.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Drupitor Client**, or navigate directly
   to `/admin/config/development/drupitor-client`.

## Settings, field by field

- **Enable / Disable** — the master switch that controls whether the API endpoint
  at `/drupitor/api/v1/updates` is accessible. Leave it off until you have set an
  API token and are ready for the Drupitor service to poll the site. Turning it
  off again makes the endpoint inert without uninstalling the module.
- **Composer Path** — the absolute path to your Composer executable (for example
  `/usr/local/bin/composer`, or simply `composer` if it is on the system `PATH`).
  The module runs this executable to discover available updates, so it must be
  correct or the endpoint cannot report anything.
- **Command Timeout** — how many seconds a Composer command is allowed to run
  before it is aborted, between **10 and 300 seconds**. Raise it if your project
  is large and update checks take a while; keep it modest so a stuck command
  cannot tie up the server.
- **API token** — the secret that callers must present to reach the endpoint.
  Configure it here and give the same value to your Drupitor service. Treat it as
  a password: anyone who has it can read your update/version information.

Click **Save configuration** when you are done.

## Configuring from `settings.php`

You can also manage these values in code — useful for keeping secrets out of the
database and out of exported configuration. Add lines like the following to your
site's `settings.php` (or, better, a per-environment settings file):

```php
$config['drupitor_client.settings']['enabled'] = TRUE;
$config['drupitor_client.settings']['api_token'] = '[YOUR_API_TOKEN]';
$config['drupitor_client.settings']['encryption_key'] = '[YOUR_ENCRYPT_KEY]';
$config['drupitor_client.settings']['encryption_method'] = 'AES-256-GCM';
$config['drupitor_client.settings']['composer_path'] = 'composer';
$config['drupitor_client.settings']['command_timeout'] = '60';
```

Keep the API token and encryption key out of version control — store them in an
environment variable or a secrets manager and reference them here, rather than
committing the literal values.

## A note on security

The endpoint returns a precise inventory of your installed modules and their
versions, which is exactly the kind of data an attacker uses to find a matching
vulnerability. Only enable the endpoint when you need it, always require the API
token (prefer sending it in a request **header**, not as a query parameter),
restrict access to the trusted Drupitor service, and review the `drupitor_client`
log channel at **Reports → Recent log messages** for unexpected calls.
