# Configuration

Setting up CDNetworks Purge is a two-part job: store your CDNetworks API
credentials securely with the Key module, then add the CDNetworks purger to your
Purge pipeline.

## 1. Store your CDNetworks credentials with Key

Never paste an API secret directly into Drupal configuration. Store it in an
environment variable and reference it through a **Key** entity.

If you're running DDEV, the recommended pattern is:

```bash
# From the host — save the secret into DDEV's dotenv file (never commit .ddev/.env)
ddev dotenv set .ddev/.env --cdnetworks-api-key=<your-key>
ddev restart

# Confirm the variable is present in the container WITHOUT printing it
ddev exec 'test -n "$CDNETWORKS_API_KEY"'   # exit status 0 = set
```

Then create a Key entity backed by that environment variable at **Configuration →
System → Keys** (`/admin/config/system/keys`), or with Drush:

```bash
drush key:save cdnetworks_api_key --label='CDNetworks API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"CDNETWORKS_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## 2. Add the CDNetworks purger to Purge

1. Log in as a user with the **Administer cdnetworks_purge configuration**
   permission.
2. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).
3. Under **Purgers**, add the **CDNetworks** purger.
4. Configure the purger with your CDNetworks connection details, selecting the
   **Key** you created above for the API credentials and entering any
   account/service identifiers CDNetworks requires.

Purge also needs at least one **queue** and **processor** configured (for example
a cron processor) so that invalidations actually get sent — this is standard Purge
setup, described in the Purge module's own documentation.

## What gets purged

Once wired up, the purger responds to Drupal's cache invalidations. Depending on
how you configure Purge and the purger, it can clear:

- individual **URLs**,
- **regex URL** patterns, and
- cache **tags**.

## Manual purges and permissions

- The **perform cdnetworks_purge manual purge** permission controls who may
  trigger a purge by hand.
- The **administer cdnetworks_purge configuration** permission controls who may
  change the purger's settings.

Grant both only to trusted roles — a manual purge hits the CDN provider, and
misconfiguration can leave stale content served to visitors.
