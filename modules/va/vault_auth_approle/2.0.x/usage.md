<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vault Auth AppRole adds the **AppRole** login method to the Vault module — the way a Drupal site (a machine, not a person) proves its identity to HashiCorp Vault using a RoleID and a SecretID that Vault exchanges for a token.

---

Vault's value is that secrets live outside the application, which raises the question of how the application authenticates to Vault in the first place. AppRole is HashiCorp's answer for services: a RoleID identifies the application and a SecretID authenticates it, and the two are typically delivered by separate channels so neither alone is enough. This module contributes a single `@VaultAuth` plugin (id `approle`, `Drupal\vault_auth_approle\Plugin\VaultAuth\AppRole`) to the base Vault module; its `getAuthenticationStrategy()` returns the `csharpru/vault-php` library's `AppRoleAuthenticationStrategy`, which the base module's `VaultClientFactory` uses to log in against Vault's AppRole endpoint and obtain a token. It stores only two config values (`role_id` and `secret_key_id`) inside the base module's `vault.settings`, and depends on the **Key** module so that the SecretID is held in a Key entity — referenced by machine name — rather than written into the module's own configuration; the credential can therefore come from an environment variable or file provider and stay out of exported config. There is no page, route, service or permission of its own — it is selected and filled in on the Vault module's settings form. Requirements: PHP 8.1+, `vault ^2 || ^3`, `key ^1`, core `^9.3 || ^10 || ^11`.

---

- Authenticate a Drupal site to Vault as a service, without a static token.
- Use HashiCorp AppRole (RoleID + SecretID) as the Vault login method.
- Keep the Vault SecretID in a Key entity instead of in config.
- Source the SecretID from an environment variable via a Key provider.
- Source the SecretID from a file via a Key provider.
- Inject a short-TTL SecretID at deploy time.
- Rotate the SecretID by updating the Key, with no code change.
- Bake the RoleID into configuration while keeping the SecretID separate.
- Meet a policy that requires machine identity for secret access.
- Avoid committing a long-lived Vault token to the repository.
- Support a containerised deployment that receives its SecretID at runtime.
- Separate role identity (RoleID) from authentication (SecretID).
- Give each environment its own AppRole and SecretID.
- Audit Vault access per application role.
- Integrate a Drupal site with an existing Vault estate.
- Limit the lifetime of Vault credentials.
- Configure the auth method entirely from the Vault module's settings form.
- Select the AppRole plugin via `plugin_auth: approle` in `vault.settings`.
- Replace a hard-coded Vault token with a pull-model AppRole login.
- Set the RoleID and Key reference with drush `config:set`.
