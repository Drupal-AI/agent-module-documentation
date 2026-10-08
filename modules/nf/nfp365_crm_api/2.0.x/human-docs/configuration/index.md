# Configuration

NfP365 CRM API needs credentials for both NfP365 APIs before it can talk to your
CRM. Everything is on a single settings form.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default).
2. Go to **Configuration → Web Services → NfP365 CRM API**, or navigate directly to
   `/admin/config/services/nfp365-crm-api`.

## Credentials

- **OpenAPI credentials** — enter the credentials NfP365 issued for the OpenAPI.
- **WebAPI credentials** — enter the credentials NfP365 issued for the WebAPI.

Both are required: the module exposes separate OpenAPI and WebAPI clients, and each
needs its own credentials to authenticate.

## Debug Mode

On the same page you can enable **Debug Mode**. When it is on, Drupal logs all
requests and responses made through the API connection — useful while integrating,
but turn it off in production so request/response payloads (which may include CRM
data) are not written to the log.

## Store the credentials as secrets

The NfP365 / Dynamics 365 credentials grant access to your CRM, so they must
**never** be committed to version control or pasted into exported configuration.
Keep them in environment variables and reference them through Drupal.

1. **Store the value in a DDEV environment variable** (do not commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --nfp365-webapi-secret=<value>
   ddev restart
   ```

   The flag `--nfp365-webapi-secret` becomes the variable `NFP365_WEBAPI_SECRET`.
   Repeat for the other credential values as needed.

2. **Confirm it is present in the container without printing it:**

   ```bash
   ddev exec 'test -n "$NFP365_WEBAPI_SECRET"'   # exit status 0 means set
   ```

3. **Expose it to Drupal via a Key entity** (install the Key module if needed —
   `ddev composer require drupal/key && ddev drush en key -y`):

   ```bash
   ddev drush key:save nfp365_webapi_secret --label='NfP365 WebAPI secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"NFP365_WEBAPI_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   Select that Key on the settings form where it accepts a Key reference; otherwise
   read the value in settings.php via `getenv('NFP365_WEBAPI_SECRET')`.

## Egress note

This module makes **outbound HTTPS requests** to the NfP365 (Dynamics 365) APIs.
If your environment restricts outbound traffic, allow HTTPS egress to the NfP365 /
Mhance API hosts, and ensure all communication runs over HTTPS.
