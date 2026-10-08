# Configuration

BirdSeed connects to an external service, so it needs API credentials. The published
documentation is thin on specifics, so the emphasis here is on handling those
credentials safely and granting the right permission.

## 1. Store the BirdSeed credentials as secrets

Keep API credentials in an environment variable rather than in plain configuration
that gets exported or committed. With DDEV:

```bash
ddev dotenv set .ddev/.env --birdseed-api-key=YOUR_KEY_HERE
ddev restart
```

The flag `--birdseed-api-key` becomes the environment variable `BIRDSEED_API_KEY`
inside the web container. Never commit `.ddev/.env`. Confirm it is set without
printing it:

```bash
ddev exec 'test -n "$BIRDSEED_API_KEY" && echo set || echo missing'
```

Reference the value from `settings.php` via `getenv('BIRDSEED_API_KEY')`, or, where
the module accepts a Key entity, store it as a Key backed by that environment
variable under **Configuration → System → Keys** (`/admin/config/system/keys`).

## 2. Connect the module

In the module's configuration, supply the BirdSeed credentials (via the environment /
Key entity as above) so it can reach the service. Connect over HTTPS.

## 3. Grant the administration permission

Under **People → Permissions** (`/admin/people/permissions`), grant
`administer birdseed` only to the roles that should manage this integration.

## Security notes

- BirdSeed credentials are secrets — keep them in the environment, reference them via
  a Key entity or `getenv()`, and never commit them.
- Because published details are limited, review the module's README and project page
  before relying on it, and connect to the service over HTTPS.
