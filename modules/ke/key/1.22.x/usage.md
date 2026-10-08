Key provides a central, pluggable way to define and store site-wide keys — API keys, passwords, and encryption keys — separating the sensitive value from the configuration that references it.

---

Instead of hard-coding secrets in settings.php or scattering them across module configuration, Key lets you create **Key config entities** that other modules reference by ID. Each key is assembled from three pluggable parts: a **key type** (what the key is used for — authentication, encryption, user password, multivalue), a **key provider** (where the value lives — configuration, a file, an environment variable, or Drupal state), and a **key input** (how a value is entered — text field, textarea, generate, or none). This means a module can ask for "the Stripe API key" without caring whether it is stored in an env var on production or a file in development. Keys are managed at Admin → Configuration → System → Keys, and a companion **Key Configuration Override** entity can inject a key's value into any other config object at runtime (via a config override), so secrets never land in exported configuration. Values can be base64-encoded, line-break-stripped, and validated per type. The `key.repository` service and a set of Drush commands expose keys to code and CLI. Because keys are config entities, the reference (not the secret) is what gets deployed, which is the recommended pattern for managing credentials across environments.

---

- Store a third-party API key (Stripe, SendGrid, Mailchimp) once and reference it from multiple modules.
- Keep secrets out of exported configuration by storing values in environment variables.
- Read a key value from an environment variable using the Environment key provider.
- Read a key from a file outside the web root using the File key provider.
- Store a key value in Drupal state (database) rather than config with the State provider.
- Generate a random encryption key of a configured size with the Generate input.
- Provide the encryption key for the Encrypt / Real AES modules.
- Supply authentication credentials to the AI provider modules (OpenAI, Anthropic) via a Key entity.
- Manage multivalue keys (e.g. username + password pairs) with the multivalue key type.
- Base64-decode a stored key value automatically before use.
- Strip trailing line breaks from file/env-provided key values.
- Override a value in any config object at runtime with a Key Configuration Override.
- Rotate a credential by editing one key without touching dependent module config.
- Use different storage per environment (file in dev, env var in prod) for the same key ID.
- Fetch a key value in custom code via the `key.repository` service.
- List all keys of a given type or provider programmatically.
- Filter keys by tag to present only relevant options in a settings form.
- Add a "Select a key" element to a custom configuration form.
- Create and save keys from the command line with `drush key:save`.
- Retrieve a key's value on the CLI with `drush key:value-get` for debugging or scripting.
- Define a custom key type for a domain-specific credential (e.g. a JWT signing key).
- Define a custom key provider to fetch secrets from an external vault (AWS Secrets Manager, HashiCorp Vault).
- Define a custom key input to shape how values are entered.
- Restrict who can manage secrets using the "Administer keys" permission.
- Audit and centralize all site credentials in one admin listing.
- Prevent secrets from appearing in version control by referencing keys instead of literals.
- Provide TLS/SMTP passwords to mail modules through a key reference.
- Alter available key providers with `hook_key_provider_info_alter()`.
