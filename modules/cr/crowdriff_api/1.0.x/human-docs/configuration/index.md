# Configuration

Configuring Crowdriff API is two steps: store your CrowdRiff API token securely as a
**Key**, then select that key and set the API and caching options on the settings
form.

## Step 1 — Store the API token securely (Key + environment variable)

Your CrowdRiff API token is a secret, so it should never be typed into plain
configuration or committed to your repository. Back it with an environment variable
via the Key module.

On DDEV, save the token into DDEV's dotenv file and restart so the container picks it
up:

```bash
ddev dotenv set .ddev/.env --crowdriff-api-key=<value>
ddev restart
```

The flag `--crowdriff-api-key` becomes the environment variable
`CROWDRIFF_API_KEY`. **Never commit `.ddev/.env`** — keep it out of version control.

Confirm the variable is present in the container *without printing its value*:

```bash
ddev exec 'test -n "$CROWDRIFF_API_KEY"'   # exit status 0 means it is set
```

Then create a **Key** entity that reads from that environment variable (enable the
Key module first if needed with `ddev drush en key -y`):

```bash
ddev drush key:save crowdriff_api_key --label='CrowdRiff API key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"CROWDRIFF_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

> **Egress caveat:** this module makes outbound calls to the CrowdRiff API
> (`https://api.crowdriff.com/v2` by default). Make sure your environment allows that
> outbound (egress) connection — firewalls or locked-down hosting can block it.

## Step 2 — Configure the settings form

1. Log in as a user with the **administer crowdriff** permission (grant it at
   **People → Permissions** — keep it to trusted administrators).
2. Go to **Configuration → Web services → Crowdriff**
   (`/admin/config/services/crowdriff`).
3. Set the options:
   - **API key (Key)** — select the Key entity you created in Step 1. The module
     reads the token from it at request time and sends it as a Bearer token.
   - **API base URL** — the CrowdRiff API endpoint. This defaults to the v2 endpoint
     (`https://api.crowdriff.com/v2`); leave it unless CrowdRiff tells you otherwise.
   - **Enable caching** and **cache length (minutes)** — responses are cached in a
     dedicated cache bin for the length you set, and the service falls back to stale
     cache if the API is temporarily unavailable. Choose a length that balances
     freshness against how often you want to call the API.
4. Save the form.

## Verify

Once the key is selected and saved, a consumer module (such as Media Library
Crowdriff) or custom code using the `crowdriff_api.crowdriff_service` service should
be able to fetch folders, albums, and assets. If no API key is configured, the
service warns and returns empty results.
