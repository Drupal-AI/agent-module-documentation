# Configuration

Configuration is where you point Drupal at your Matomo server and give it the
credentials to read reports. If the **Matomo Analytics** module is already enabled
and configured on the site, you can reuse its settings and skip re‑entering most of
this.

## Open the settings form

Log in as a user with the **Administer site configuration** permission (an
administrator by default) and open the module's **Matomo Reporting API settings**
form under **Configuration → System**. The form collects the connection details
described below.

## The connection fields

- **Matomo server URL** — the base URL of your Matomo installation. Always use an
  **HTTPS** URL; the authentication token travels to this server, so the transport
  must be encrypted.
- **Site ID** — the numeric ID of the Matomo property you want to report on (for
  example `1`). You'll find it in Matomo under the site's settings.
- **Authentication token** (`token_auth`) — the API token Matomo issues for a user
  account. This grants read access to that account's analytics.
- **Reuse Matomo Analytics configuration** — when the Matomo Analytics module is
  present, this option lets the reporting client borrow the server URL, site ID,
  and token already configured there, so you don't maintain the same values in two
  places.

## Store the auth token securely

The authentication token is a **credential**. Anyone holding it can read your
analytics — visitor counts, popular pages, referrers — which may itself be
sensitive data. Treat it accordingly:

- **Do not** commit the token into exported configuration that lands in git.
- Prefer supplying it from an **environment variable** or a **Key** entity rather
  than typing it into plain configuration. With DDEV, store the value with
  `ddev dotenv set .ddev/.env --matomo-token=<value>` (keep `.ddev/.env` out of
  version control) and `ddev restart`, then reference it — for example through the
  [Key](https://www.drupal.org/project/key) module's environment provider.
- Always use the **HTTPS** server URL so the token is never sent in the clear.

Treat the analytics you retrieve as data that may carry its own privacy weight, and
be deliberate about where you display it.

## Save

Save the form. With a valid server URL, site ID, and token in place, the client can
authenticate to Matomo and fetch report data for use in your code, blocks, or the
example submodule.
