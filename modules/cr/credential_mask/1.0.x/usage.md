<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Credential Mask replaces configuration values you mark as sensitive with a placeholder in exported config-sync YAML, so credentials and secret keys never land in your committed configuration.

---

Credential Mask integrates with Drupal's configuration-management **storage-transform** events. During a config **export**, any config name/key you have listed as sensitive is replaced with the static placeholder `<masked>` before it is written to the config-sync directory; during an **import**, that placeholder is transparently swapped back for the real value read from active storage, so importing masked YAML never clobbers the live secret. You maintain the sensitivity list — a set of `config-name|config-key` pairs, with `*` wildcards allowed in the config name — through a settings form at `/admin/config/development/configuration/credential_mask` (core **`import configuration`** permission) or through Drush commands. The module changes only what appears in the exported files: secret values continue to live in Drupal's active (database) config exactly as before — it does not encrypt, move, or otherwise protect them at rest, and anything you do not list is still exported normally. It is defense-in-depth for teams that commit their config export to Git, and requires **Drush 10 or greater** for the config-sync integration.

---

- Stop an API key stored in a payment-gateway config from being written into your exported config-sync YAML.
- Keep `commerce_payment.commerce_payment_gateway.*|configuration.secret_key` out of your Git repository.
- Mask a Search API / Solr server's `username` and `password` before `drush config:export`.
- Prevent SMTP credentials in `smtp.settings` from appearing in committed configuration.
- Mask a mailer or CRM API token nested under a `configuration.*` key using dotted key paths.
- Apply masking across many similar config objects at once with a wildcard, e.g. `webform.webform.*|handlers.email.settings`.
- Safely commit exported configuration to a shared repo without leaking third-party service secrets.
- Import a teammate's exported config without overwriting the real secret values on your environment.
- Add a sensitive key from the CLI in CI/deploy scripts: `drush credential_mask:add mymodule.settings apikey`.
- Remove a key from the mask list when a service is decommissioned: `drush credential_mask:del mymodule.settings apikey`.
- Audit which sensitive keys are actually present, exported, and masked with `drush credential_mask:list`.
- Review the configured sensitivity rules with `drush credential_mask:show-configuration`.
- Catch a sensitive key that is exported but **not** masked (highlighted as an error row in `credential_mask:list`) before it reaches version control.
- Gate who can edit the sensitivity list behind the core `import configuration` permission.
- Manage masking through the UI under *Configuration → Development → Configuration synchronization → Credential Mask settings*.
- Reduce a common secret-leak channel (config committed to source control) as part of a defense-in-depth posture.
- Complement `config_split` / `config_filter` workflows where you still need per-key credential masking.
- Protect tokens stored in contrib modules whose config you do not control the shape of, by targeting just the sensitive subkey.
- Keep OAuth client secrets or webhook signing keys out of exported YAML in a multi-developer team.
- Ensure automated config-export pipelines produce diffs free of secret material.
- Standardize a masking policy across environments by exporting the `credential_mask.sensitive_config` list itself.
