# Configuration

One Page CRM API needs one thing to work: your **OnePageCRM API credentials**.
The base module is a service layer, so the credentials it reads come from Drupal
configuration — and because they grant access to your CRM data, they must be
treated as secrets and kept out of version control.

## Get your OnePageCRM credentials

Sign in to your OnePageCRM account and enable API access, then obtain the API
key (and any user identifier the API requires). You need an active subscription
with API access enabled for the module to authenticate.

## Store the credentials securely — never in code

Do **not** paste the API key into a settings form and export it into
`config/sync`, and never commit it to Git. Instead keep the value in an
environment variable and read it from there.

With DDEV, set the variable once and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --onepagecrm-api-key=<your-key>
ddev restart
```

That makes the value available inside the container as `ONEPAGECRM_API_KEY`
(and keeps `.ddev/.env` out of version control). Confirm it is present *without
printing it*:

```bash
ddev exec 'test -n "$ONEPAGECRM_API_KEY"'   # exit status 0 means it is set
```

From Drupal you then reference the environment variable rather than a hard‑coded
string — for example via `getenv('ONEPAGECRM_API_KEY')` in your settings, or by
storing it in a **Key** entity backed by the environment provider if you prefer a
managed secret. The important rule is that the secret lives in the environment,
not in exported configuration.

## Confirm the connection

Once the credential is in place, enable the optional **One Page CRM API UI**
submodule if you want a quick check: its admin forms let you send a test request
(for example, list contacts) and view the raw response, which tells you
immediately whether authentication succeeded. Otherwise, exercise the services
from your own code and watch for authentication errors in the logs.
