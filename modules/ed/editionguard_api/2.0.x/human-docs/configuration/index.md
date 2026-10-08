# Configuration

The module needs your EditionGuard account credentials before the client can do
anything. Everything is set on one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → EditionGuard API**, or navigate
   directly to `/admin/config/services/editionguard-api`.

## The settings, field by field

- **OAuth email** (`oauth_email`) — the email address of your EditionGuard
  account. This is the username the client uses when it requests an access token.
- **OAuth password** (`oauth_password`) — the password for that EditionGuard
  account.
- **Token expire** (`token_expire`) — how long the access token the client
  receives from EditionGuard is cached before it is re-requested. A longer
  lifespan means fewer authentication round-trips; a shorter one re-authenticates
  more often.
- **Enable logging** (`logging_enabled`) — when ticked, the module logs each
  request and response to the `editionguard_api` log channel. This is invaluable
  while you are building and debugging an integration; turn it off once the
  integration is stable, both for noise and because responses can contain
  sensitive data.

Click **Save configuration** when done.

## Important: how the credentials are stored

The EditionGuard **email and password are stored in plain text** inside the
`editionguard_api.settings` configuration object. This has two consequences worth
planning for:

- **Treat exported configuration as a secret.** If you export configuration to
  code (`drush cex`) and commit it to version control, the credentials go with
  it. Keep that config out of your repository, or strip the two values before
  committing.
- **Prefer keeping the secret in an environment variable.** The module does not
  read credentials from a Key entity or environment variable on its own, but you
  can override the config value from `settings.php` so the real secret never
  lives in exported config. Store the password with DDEV's dotenv helper —
  `ddev dotenv set .ddev/.env --editionguard-password=<value>` (never commit
  `.ddev/.env`), `ddev restart` — then in `settings.php`:

  ```php
  $config['editionguard_api.settings']['oauth_password'] = getenv('EDITIONGUARD_PASSWORD');
  ```

## A note on egress

Whenever the client runs, it makes outbound HTTPS calls to EditionGuard
(`app.editionguard.com` / `api.editionguard.com`). Those calls use Guzzle's
default TLS certificate verification (it is **not** disabled). If your
environment restricts outbound network access, allow egress to EditionGuard's
hosts or the client will not be able to authenticate.

## Test your credentials

Two administrator-only forms let you confirm everything works before writing any
code:

- The general **Test** form (`/test` under the module) exercises endpoints
  interactively.
- The **Endpoint test** form (`/test/endpoint/{endpoint_id}`) lets you inspect a
  specific endpoint's parameters and run it.

Run something read-only such as the `book_list` endpoint first — if it returns
your account's books, your credentials and network egress are correct.
