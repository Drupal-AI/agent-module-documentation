# Configuration

To use this module you connect it to your Keepeek account with **API
credentials** issued by Keepeek. Those credentials are secrets, so the most
important part of configuration is storing them safely — never hard‑code them in
`settings.php` and never commit them to your repository.

## 1. Obtain your Keepeek API credentials

Get the API credentials for your Keepeek DAM from your Keepeek account (typically an
API endpoint/base URL plus a client id and secret or API key). If you don't have
them, your Keepeek administrator or Keepeek support can provide them.

## 2. Store the secret in an environment variable (recommended)

Keep the secret out of code by putting it in an environment variable. With DDEV,
use its built‑in dotenv command so the value lives only in the (git‑ignored)
`.ddev/.env` file:

```bash
ddev dotenv set .ddev/.env --keepeek-api-key=<value>
ddev restart
```

The flag `--keepeek-api-key` becomes the environment variable `KEEPEEK_API_KEY`
inside the web container. **Do not commit `.ddev/.env`.**

Confirm the variable is present in the container *without printing its value*:

```bash
ddev exec 'test -n "$KEEPEEK_API_KEY"'   # exit status 0 means it is set
```

## 3. Reference the secret through a Key (recommended)

Where the module accepts a **Key** entity for its credentials, store the secret with
the [Key](https://www.drupal.org/project/key) module's environment provider rather
than pasting it into a form:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev drush key:save keepeek_api_key --label='Keepeek API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"KEEPEEK_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then select that Key in the module's settings. If the module reads a value directly
rather than a Key, reference the environment variable from `settings.php` with
`getenv('KEEPEEK_API_KEY')` instead of typing the secret into configuration.

## 4. Connect the module to Keepeek

In the module's settings, provide your Keepeek connection details — the API
endpoint/base URL and the credential (via the Key entity created above) — and save.
Once the connection succeeds, Keepeek assets become available to editors through the
**Media Library**.

## Network egress

This module makes outbound HTTPS calls to Keepeek's API and asset URLs. Make sure
your hosting environment allows **outbound HTTPS** to Keepeek's endpoints so the
integration can authenticate, list, and deliver assets.
