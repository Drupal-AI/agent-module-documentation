<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BaoKey integrates OpenBAO (the open-source fork of HashiCorp Vault) with Drupal's Key module, letting keys be read on demand from a remote KV v2 secrets engine instead of being stored in Drupal.

Use it to keep API keys, credentials and encryption keys in OpenBAO/Vault while still consuming them through Drupal's standard Key API.

---

Install with `composer require drupal/baokey` and enable it (`drush en baokey`); it depends on the `key` module.

Set the OpenBAO connection in `settings.php` via Drupal `Settings`: `vault_url` (the base URL) and `vault_token` (the X-Vault-Token). Then create a Key entity that uses the "Vault" (`baokey`) provider and set its secret path (for example `secret/my-secret-key`).

At read time BaoKey issues an authenticated `GET {vault_url}/v1/{path}` and returns the matching value; the request uses Guzzle's default TLS verification.

---

- Retrieve Drupal keys from an OpenBAO / Vault KV v2 secrets engine.
- Register a `baokey` (labelled "Vault") key provider for the Key module.
- Keep secrets out of Drupal config and database.
- Read the connection URL and token from `settings.php` (`vault_url`, `vault_token`).
- Authenticate to OpenBAO with the `X-Vault-Token` header.
- Look up a secret by configurable path per Key entity.
- Match the requested key by the Key entity's label within the secret payload.
- Optionally strip trailing line breaks from the retrieved value.
- Optionally Base64-decode encryption-key values.
- Log read attempts and failures to the `baokey` logger channel.
- Use Guzzle's default TLS certificate verification for the HTTP call.
- Support both authentication and encryption key types.
- Provide a key-provider configuration form for the secret path and options.
- Return null gracefully when a secret cannot be read.
- Centralize secret rotation in OpenBAO rather than in Drupal.
- Work on Drupal 9 and Drupal 10.
- Complement other Key providers (env, file, config) with a remote-vault option.