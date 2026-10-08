# Configuration

This module's job is to hold the connection settings for Campaign Monitor —
principally your **API key** — and expose a service that uses them. You provide the
API key through the module's settings, and the client uses it to authenticate every
call it makes to Campaign Monitor.

## Handle the API key as a secret

A Campaign Monitor API key is a credential: anyone who has it can manage your
subscriber lists. Do **not** paste it into configuration that gets exported and
committed to version control. Store it in an environment variable and reference it
from there.

With DDEV, save the value into the project's dotenv file (never committed):

```bash
ddev dotenv set .ddev/.env --campaign-monitor-api-key=<your-key>
ddev restart
```

The flag `--campaign-monitor-api-key` becomes the environment variable
`CAMPAIGN_MONITOR_API_KEY` inside the web container. Confirm it is present without
printing it:

```bash
ddev exec 'test -n "$CAMPAIGN_MONITOR_API_KEY"'   # exit status 0 means it is set
```

From there, feed the value into Drupal one of two ways:

- **Via a Key entity** (preferred where the module supports selecting a Key).
  Install the [Key](https://www.drupal.org/project/key) module if it isn't already
  enabled, then create a Key backed by the environment variable:

  ```bash
  ddev composer require drupal/key && ddev drush en key -y
  ddev drush key:save campaign_monitor_api_key \
    --label='Campaign Monitor API Key' --key-type=authentication \
    --key-provider=env \
    --key-provider-settings='{"env_variable":"CAMPAIGN_MONITOR_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
    --key-input=none -y
  ```

- **Directly from settings.php** with `getenv('CAMPAIGN_MONITOR_API_KEY')`, where a
  Key entity does not apply.

The point is the same either way: the key lives in the environment, not in
committed config.

## What consumers do with it

Once the key is set, this module doesn't send anything by itself. A consumer module
(for example the Campaign Monitor webform handler) uses the service to look up your
clients and lists and to create subscribers. Remember that those calls forward
subscriber personal data to Campaign Monitor — make sure you have consent and
disclose it as your policy requires.
