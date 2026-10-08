# Configuration

The one thing LaMetric Time needs to work is your **LaMetric API token** — the
credential that authorises Drupal to push notifications to your device. You obtain
it from your LaMetric developer account for the device you want to target, and then
give it to Drupal. The rest of this page is about doing that *securely*, because the
token is a secret.

## Store the token as a secret (recommended)

Don't paste the token straight into configuration that gets exported to code and
committed. Instead, keep it in an environment variable and reference it from a Key
entity.

### 1. Save the token in DDEV's environment

```bash
ddev dotenv set .ddev/.env --lametric-api-token=YOUR_TOKEN_HERE
ddev restart
```

The flag `--lametric-api-token` becomes the environment variable
`LAMETRIC_API_TOKEN` inside the web container. **Never commit `.ddev/.env`** — keep
it out of version control.

Confirm the variable is present without printing its value:

```bash
ddev exec 'test -n "$LAMETRIC_API_TOKEN"' && echo "set"
```

### 2. Expose it through a Key entity

If the **Key** module isn't already enabled:

```bash
ddev composer require drupal/key
ddev drush en key -y
```

Then create a Key backed by the environment variable:

```bash
ddev drush key:save lametric_api_token \
  --label='LaMetric API Token' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"LAMETRIC_API_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Enter the token in the module settings

Open the module's LaMetric settings form in the admin UI and supply the API token
there. Where the form supports selecting a **Key**, choose the
`lametric_api_token` Key you created above so the secret is read from the
environment rather than stored in configuration. If the form only accepts the token
directly, paste it in, but be mindful that it will then live in your configuration.

Save the form. Sending a test notification and seeing it scroll across the device
confirms the token and connection are correct.

## A note on data leaving your site

This module makes outbound calls to LaMetric's cloud API to reach your device.
Whatever message text you push is sent to that external service, so avoid putting
sensitive information into device notifications.
