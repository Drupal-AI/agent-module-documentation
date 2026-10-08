# Configuration

Two steps: store your Google Search Console API credentials securely with the Key module,
then grant the permission to the roles that should see the data.

## 1. Store your Search Console credentials with the Key module

Analyze: Search Console authenticates to the Google Search Console API over HTTPS using
credentials read from a **Key** entity rather than from plain configuration, which keeps
the secret out of exported config. The recommended pattern is an environment-variable
backed key:

1. Obtain API credentials for your Search Console property from the Google Cloud console
   (for example a service-account key, or an OAuth client credential).
2. Place the credential value into an environment variable on the server (under DDEV,
   `ddev dotenv set .ddev/.env --…=<value>` followed by `ddev restart`).
3. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and create a Key
   that reads from that environment variable, so Drupal never stores the secret in the
   database or in exported config.
4. Point Analyze: Search Console at that Key in its settings.

Because the module fetches your Google account's search-performance data, treat the
credential as sensitive and keep it env-backed and out of version control.

## 2. Grant the viewing permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant the module's
Search Console access permission to the roles that should be able to see the data in the
Analyze report. The module has no access-control role beyond this permission.

## Verify it worked

Open the Analyze report for a piece of content as a user who has the permission. You
should see Google Search Console impressions, clicks, and queries for that content. If
nothing appears, re-check that the Key resolves to a valid credential with access to your
Search Console property and that the environment variable is present in the running
container.
