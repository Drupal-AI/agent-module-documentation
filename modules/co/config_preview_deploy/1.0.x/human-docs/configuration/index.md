# Configuration

Config Preview Deploy connects two environments — a **preview** site (the source of changes)
and a **production** site (the target) — and moves configuration between them over an
authenticated API. Setup therefore happens on both sides: you establish an OAuth trust, store
the secrets safely, and grant the right permissions to the right people.

## Open the settings form

1. Log in as a user with **Administer config preview deploy** (a restricted permission).
2. Go to **Configuration → Development → Config Preview Deploy → Settings**, or navigate to
   `/admin/config/development/config-preview-deploy/settings`
   (`config_preview_deploy.settings`).

## The permissions

The module defines three permissions — grant them deliberately:

- **Deploy config from preview** — lets a user use the preview dashboard, view diffs, and
  initiate a deployment. Give this to the people who prepare and approve config changes.
- **Accept config deployments** — a **restricted** permission held by the account that
  production uses to receive deployments. The production deploy and export API endpoints
  require this *and* OAuth2 authentication.
- **Administer config preview deploy** — a **restricted** permission for configuring the
  module itself (the settings form). Keep this to trusted administrators only.

## Establish the OAuth trust between preview and production

Trust between the two environments is an **OAuth 2.0 authorization‑code** flow provided by
Simple OAuth:

1. On **production**, set up a Simple OAuth client that preview will authenticate as, and
   note its client ID and client secret.
2. **Store the client secret in a [Key](https://www.drupal.org/project/key) entity** rather
   than in plain configuration. On DDEV you can hold the secret in an environment variable
   with `ddev dotenv set .ddev/.env --oauth-client-secret=<value>` and `ddev restart`, then
   reference it through a Key backed by the env provider. Never commit `.ddev/.env`.
3. On **preview**, point the module's settings at production and complete the authorize /
   callback flow (`.../oauth/authorize`, `.../oauth/callback`) to grant preview the
   authorization it needs to deploy.

The verification **hash/timestamp keys** used to sign deploy payloads should likewise be
stored via Key, not in exported configuration.

## Fill in the settings

On the settings form, configure the connection to the target environment and the
authentication details (the OAuth client, and the Key(s) holding the client secret and
verification keys). Save.

## Optional: exclude environment‑specific config

Some configuration should differ between environments (API endpoints, mail settings, and so
on) and must not be deployed. Enable
[Config Ignore](https://www.drupal.org/project/config_ignore) and list those items so they
are excluded from deployments.

## Using it

Once the trust is in place, the day‑to‑day flow on the **preview** dashboard
(`/admin/config/development/config-preview-deploy`) is:

1. Review the pending configuration changes.
2. Open a **per‑config unified diff** to see exactly what will change, and optionally
   **download** the diff.
3. If production has moved on, **rebase** the preview environment against production first.
4. **Deploy** the approved changes. Production receives the diff over the OAuth2‑authenticated
   endpoint, verifies the hash and timestamp, and applies the change against a configuration
   checkpoint — so it can be rolled back if needed.

## Security summary

The endpoints that read or write configuration on production are protected by the restricted
**Accept config deployments** permission *and* OAuth2, with hash‑and‑timestamp verification
on deploys. The only public endpoint, `GET /api/config-preview-deploy/status`, returns
deployment status metadata only and touches no configuration. Keep the OAuth client secret
and verification keys in Key entities, and keep the two restricted permissions limited to
trusted operators.
