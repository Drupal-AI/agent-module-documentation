# Configuration

This module has no settings page of its own — you configure it from inside the
Purge module, where you add the Imperva purger to the pipeline and enter your
Imperva credentials.

## Add the purger and open its settings

1. Log in as a user who can administer the Purge module.
2. Go to **Configuration → Development → Performance → Purge**
   (`/admin/config/development/performance/purge`).
3. Add **Imperva cache Purger** as a purger in the pipeline if it is not there yet.
4. Click the small arrow next to **Imperva cache Purger**, then click
   **Configure**. A modal window opens where you enter the connection details.

## The settings

- **API ID** — the identifier for your Imperva account/API access. You find this in
  your Imperva account or the Imperva documentation.
- **API key** — the secret paired with the API ID. Together they authorize the
  module to purge your Imperva edge cache.

Save the modal to store the credentials.

## Choose how to invalidate

Imperva supports invalidation **by path** and **by cache tag**. The recommended
choice is **by cache tag**, because Drupal emits cache tags automatically and they
target exactly the pages affected by a content change — no manual path lists to
maintain.

## Store the credentials as secrets

The Imperva API ID and key can purge (and, depending on their scope, potentially
reconfigure) your CDN, so treat them as production secrets and keep them out of
committed configuration.

With DDEV, store the key in an environment variable:

```bash
ddev dotenv set .ddev/.env --imperva-api-key=<your-api-key>
ddev restart
```

That exposes it inside the web container as `IMPERVA_API_KEY` (never commit
`.ddev/.env`). Where the module supports it, hold the credential in an env‑backed
[Key](https://www.drupal.org/project/key) entity rather than in plain config;
otherwise reference the environment variable from `settings.php` with
`getenv('IMPERVA_API_KEY')`.

## Network egress

Drupal must be able to reach Imperva's API over outbound HTTPS for purges to
succeed. If your site runs behind a restrictive egress policy, allow outbound
connections to Imperva's API host.

## Testing

To confirm invalidation works end‑to‑end, follow the **Purge** module's own
documentation on testing purgers and processing invalidations.
