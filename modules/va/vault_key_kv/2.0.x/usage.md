<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vault Secret Engine - Key/Value lets the Key module use Vault's KV secret engine as a key source.

---

Vault Secret Engine - Key/Value (vault_key_kv) **lets the Key module read secrets from HashiCorp Vault** —
providing a Key key-provider backed by Vault's KV (key/value) secret engine, so Drupal fetches secrets (API keys,
passwords, tokens) from Vault at runtime rather than storing them in configuration or the database. It depends on
the Key and Vault modules, in the Security package.

Use it to source secrets from Vault. This is a **security-positive** secret-management integration: keeping secrets
in Vault (not in exported config, the DB, or code) is best practice — secrets are centralized, access-controlled,
audited and rotatable. Security essentials for it to actually help: secure the **Vault connection and authentication**
(the Vault token/AppRole Drupal uses is itself a powerful secret — store it via env, scope its **Vault policy to
least privilege** so it can read only the paths it needs), use **TLS to Vault**, and rotate/lease appropriately. It
has no access-control role. Configure the Vault connection and KV path.

---

- Let the Key module read from Vault KV.
- Fetch secrets from Vault at runtime.
- Avoid storing secrets in config/DB.
- Depend on the Key and Vault modules.
- Serve security/secret management.
- Provide a Vault key-provider.
- BE security-positive (centralized, access-controlled, audited, rotatable secrets).
- Secure the Vault connection/auth (the Vault token/AppRole is itself a powerful secret - env, TLS).
- Scope the Vault policy to least privilege + rotate/lease.
- Have no access-control role.
- Configure the Vault connection and KV path.
- Handle Vault secrets.
- Read secrets.
- Configure the provider.
- Fetch keys.
- Handle the integration.
- Source secrets.
- Provide keys.
- Secure the Vault token.
- Provide Vault KV secret sourcing.
