# Configuration

SiteDash needs one thing from you: your SiteDash token. Everything else is
configured automatically once you authenticate.

## Open the settings form

1. Log in as a user with permission to administer the SiteDash connection.
2. Go to **`/admin/config/services/sitedash`**.

## Enter your SiteDash token

Paste the authentication token from your SiteDash.io account into the token
field and save. Once the token is accepted, the module:

- authenticates and connects to the SiteDash.io monitoring service, and
- **automatically configures the Audit Export remote post settings** — the remote
  post URL, the authentication headers, and this site's identifier — so you do
  not have to set those by hand.

## Override Remote Post (optional)

There is an optional **Override Remote Post** setting. When enabled, it lets
SiteDash manage Audit Export's remote configuration centrally for you, rather than
you maintaining those values locally. Turn it on if you want SiteDash to own that
configuration.

## Keep the token safe

The token authenticates your site to an external service and is effectively a
credential. Store it as a secret — an environment variable or a Key entity —
rather than committing it to configuration in version control, and rely on HTTPS
for the connection. Remember that SiteDash sends audit and health data (which can
include module, version and configuration details) to SiteDash.io, so only
connect a SiteDash account you trust.
