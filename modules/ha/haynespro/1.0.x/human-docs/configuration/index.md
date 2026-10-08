# Configuration

HaynesPro needs two things to work: the **API credentials** HaynesPro issued to
you, stored securely, and a network path from your server **out to the HaynesPro
API**. This page covers both.

## Store the API credentials securely

The module depends on the **Key** module precisely so your HaynesPro credentials
never sit in committed configuration. Handle them like any other secret:

- **Never hard-code or commit the credentials** — keep them out of `settings.php`
  literals and out of exported/version-controlled config.
- **Put the value in an environment variable.** With DDEV, use the built-in
  dotenv command and restart so the container loads it:

  ```bash
  ddev dotenv set .ddev/.env --haynespro-api-key=<value>
  ddev restart
  ```

  The flag `--haynespro-api-key` becomes the variable `HAYNESPRO_API_KEY`. Keep
  `.ddev/.env` out of version control.
- Confirm the variable reached the container **without printing its value**:

  ```bash
  ddev exec 'test -n "$HAYNESPRO_API_KEY"'
  ```

  Exit status `0` means it is set.

## Create the Key entity

1. Log in as an administrator and go to **Configuration → System → Keys → Add
   key** (`/admin/config/system/keys/add`).
2. Give the key a **Name** and choose an **Authentication** key type.
3. For **Key provider**, choose **Environment** so the value is read from the
   environment variable you just set, and point it at `HAYNESPRO_API_KEY`.
4. Save.

If the Key module's environment provider isn't available, enable it as part of
the Key module. You can also create the Key from the command line:

```bash
ddev drush key:save haynespro_api_key --label='HaynesPro API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"HAYNESPRO_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Point the module at the credentials

In the HaynesPro module's own settings, select the Key you just created as the
source of the API credentials, and enter any additional connection details
HaynesPro requires (such as the service endpoint). Because you selected a
Key-backed value, Drupal reads the secret from the environment at runtime and it
is never written into configuration.

## Network egress

HaynesPro lookups are **outbound requests** from your Drupal server to
HaynesPro's WebAPI. Make sure your hosting environment allows that egress over
HTTPS, and that any firewall or proxy permits traffic to HaynesPro's endpoints.
If lookups hang or time out with valid credentials, blocked egress is the first
thing to check.

## Verify

With the credentials stored and selected, perform a vehicle lookup (a VRM query)
and confirm the technical data comes back. If you get authentication errors,
re-check that the Key resolves to the correct value and that the environment
variable is set in the running container.
