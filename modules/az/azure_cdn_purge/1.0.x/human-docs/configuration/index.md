# Configuration

There are two parts: give the module your Azure credentials, and add it as a purger
inside the Purge pipeline.

## 1. Enter the Azure credentials

Open the **Azure CDN Purge** admin config form (route
`azure_cdn_purge.admin_config_form`) and enter the Azure details needed to call the
CDN purge API for your profile/endpoint.

### Keep the credential a secret, scoped least‑privilege

The value that authorises a purge is a secret and should be scoped to only the CDN
purge operation. Do **not** commit it in exported configuration. Supply it from the
environment:

1. Store it as an environment variable. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --azure-cdn-purge-secret=<value>
   ddev restart
   ```

   (The flag becomes the variable `AZURE_CDN_PURGE_SECRET`. Never commit `.ddev/.env`.)

2. Reference it from Drupal via a **Key** entity (the `key` module's *env* provider)
   or `getenv('AZURE_CDN_PURGE_SECRET')`.

The connection to Azure uses TLS; the module does not disable certificate
verification.

## 2. Wire it into Purge

Go to **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`). Purge needs a **queue** and a
**processor** configured, and you add **Azure CDN Purger** as one of the purgers. Once
it's in place, cache invalidations that Drupal generates (for example when content is
updated) are handed to this purger, which calls Azure to clear the matching CDN
objects.

If you are new to Purge, its own documentation covers the queue/processor concepts —
this module only supplies the Azure‑specific purger that slots into that setup.
