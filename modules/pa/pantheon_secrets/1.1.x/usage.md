<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pantheon Secrets exposes secrets stored in Pantheon's Secrets Manager to Drupal as a Key module **key provider**, so API keys and credentials never live in code or config.

---

The module is a thin bridge between the [Key](https://www.drupal.org/project/key) module and Pantheon's Customer Secrets service. It ships one plugin — a `KeyProvider` with id `pantheon` — whose only stored configuration is `secret_name` (plus a `base64_encoded` flag) inside a Key config entity's `key_provider_settings`. At read time `getKeyValue()` asks the `pantheon-systems/customer-secrets-php-sdk` client for that secret and returns its value (base64-decoding it first when the flag is set), so the secret value itself is never written to Drupal config, the database, or an export. On top of the plugin it adds a **bulk importer**: the `pantheon_secrets.secrets_syncer` service enumerates every secret visible to the site and creates one Key entity per secret that is not already referenced, using a transliterated lowercase machine name, label = the secret name, `key_type: authentication` and `key_provider: pantheon`. That importer is reachable two ways — a confirm-style form at `/admin/config/system/keys/pantheon` (gated by the `sync pantheon_secrets keys` permission, shown as a "Sync Pantheon Secrets" tab on the Keys collection) and the Drush command `pantheon-secrets:sync`. Secrets themselves are created outside Drupal with `terminus secret:set <site> --scope=web --type=runtime <name> <value>`; the module never writes to Pantheon, and deleting a Key entity explicitly does **not** delete the Pantheon secret. Any contrib module that consumes a Key entity (Sendgrid, AI providers, S3, SMTP, …) then works unchanged against Pantheon-managed secrets.

---

- Store a SendGrid / Mailgun / SMTP API key in Pantheon and reference it from Drupal through a Key entity.
- Feed an AI provider module (OpenAI, Anthropic, …) its API key without committing it to `settings.php`.
- Keep third-party credentials out of exported configuration so config can be committed safely.
- Give each Pantheon environment (dev / test / live) a different value for the same key via secret environment overrides.
- Bulk-import every secret defined for a site into Key entities in one click on `/admin/config/system/keys/pantheon`.
- Run the same import from CI or a release script with `terminus drush <site>.<env> -- pantheon-secrets:sync`.
- Create a single Key by hand, choosing "Pantheon" as the provider and picking the secret from a select list of real secret names.
- Change a secret value in Pantheon and have Drupal pick it up immediately, with no deployment.
- Base64-encode a binary credential (certificate, private key) as a Pantheon secret and let the provider decode it on read.
- Restrict who can run the bulk sync by granting only trusted roles the `sync pantheon_secrets keys` permission.
- Audit which Drupal keys are backed by Pantheon by filtering key entities on `key_provider: pantheon`.
- Migrate an existing site from the Key "Configuration" provider to Pantheon-managed secrets by switching the provider on each key.
- Rotate credentials centrally in Pantheon while Drupal config stays untouched.
- Prove to a security review that no secret value is present in the database or in a config export.
- Wire a payment gateway (Stripe, PayPal) secret key through Key so it can be rotated without a code deploy.
- Provide credentials to a Search API/Solr or Elasticsearch connector that accepts a Key entity.
- Give a webform or CRM integration its shared secret through the Key API rather than a settings override.
- Verify a key is wired up without exposing it: the provider form shows the value masked to its last few characters.
- Delete a stale Key entity in Drupal while deliberately leaving the underlying Pantheon secret in place.
- Combine with the Key module's own key types (authentication, encryption) so consumers see a normal Key entity.
- Script provisioning of a new environment: set secrets with terminus, then `drush pantheon-secrets:sync` to materialise the keys.
- Use `\Drupal::service('key.repository')->getKey($id)->getKeyValue()` in custom code and stay hosting-agnostic.
- Keep a `.env`-free codebase on Pantheon where env vars are not available to the web container.
- Standardise credential handling across many Pantheon sites with the same Key ids on each.
