<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vault Auth - Token provides a token-based authentication strategy plugin for the Vault module, letting Drupal authenticate to a HashiCorp Vault server with a static Vault token.

---

It contributes a single `@VaultAuth` plugin (id `token`, `src/Plugin/VaultAuth/Token.php`). Crucially, the token itself is not stored in this module's configuration — the plugin config persists only `token_key_id`, the machine name of a Key entity from the Key module. At runtime the plugin loads that Key via the key repository and reads its value to build a `TokenAuthenticationStrategy` for the Vault PHP client. The configuration form exposes a `key_select` element filtered to `authentication`-type keys, so an administrator chooses a managed Key rather than pasting a raw secret; if the referenced Key is missing the plugin throws a `PluginException`.

This design keeps the Vault credential out of exported configuration and out of the database as plaintext — where the secret actually lives (env var, file, remote secret store) is determined by the chosen Key provider. TLS to the Vault API is the responsibility of the parent Vault module/PHP client (this plugin does not touch HTTP options and does not disable certificate verification). Configuration lives inside the Vault module's admin UI, which is gated by Vault's administrative permissions, so the token reference is never exposed to non-admin users.

---
- Authenticate Drupal to HashiCorp Vault using a static token.
- Select the Vault token from a Key entity instead of pasting a raw secret.
- Store the Vault token in an environment variable via the Key env provider.
- Keep the Vault token out of exported site configuration.
- Choose an `authentication`-type Key in the Vault auth settings.
- Swap the underlying token by re-pointing the Key, no config export change.
- Use with the Vault module to read secrets from a Vault KV store.
- Rotate the Vault token by updating the Key's source value.
- Fail safe (PluginException) when the referenced Key no longer exists.
- Combine with a file- or env-backed Key provider for secret hygiene.
- Provide Vault auth for a multi-environment deployment via per-env Keys.
- Restrict who can configure Vault auth via Vault's admin permissions.
- Reference a file-provider Key so the token never touches the database.
- Point separate dev/stage/prod Keys at the same auth plugin config.
- Audit the Vault credential source by inspecting the referenced Key only.
