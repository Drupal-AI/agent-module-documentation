# Configuration

The module's configuration form is where you store the Immoweb API credentials the
client uses to authenticate. There is nothing else to set up by hand — everything
past this point happens in code.

## Before you start

Request **project‑specific API credentials** from the Immoweb team at
`api@immoweb.be`. Third‑party integrations may use the customer authentication and
classified pipeline endpoints; other Immoweb endpoints are internal to Immoweb and
not available to you.

## Open the settings form

1. Log in as a user with the module's administer permission (it defines its own).
2. Open the module's **Immoweb API Client** settings form under **Configuration**.

## The settings

- **API credentials (OAuth client credentials)** — the identifier and secret
  Immoweb issued for your project. The module uses these to perform customer
  authentication and to obtain and automatically refresh access tokens, so you
  never have to call the authentication service manually before hitting the
  classified pipeline endpoints.

Enter the values Immoweb gave you and save.

## Store the credentials as secrets

The Immoweb client secret is a credential — keep it out of committed configuration
and version control. With DDEV, store it in an environment variable:

```bash
ddev dotenv set .ddev/.env --immoweb-api-secret=<your-secret>
ddev restart
```

That exposes it inside the web container as `IMMOWEB_API_SECRET` (never commit
`.ddev/.env`). Reference it from `settings.php` with `getenv('IMMOWEB_API_SECRET')`
to override the stored config value, or — where the module supports it — hold the
secret in an env‑backed [Key](https://www.drupal.org/project/key) entity rather
than in plain module config.

## Network egress

Drupal must be able to reach the Immoweb API over outbound HTTPS. If your site runs
behind a restrictive egress policy, allow outbound connections to Immoweb's API
host so authentication and the classified pipeline calls can complete.
