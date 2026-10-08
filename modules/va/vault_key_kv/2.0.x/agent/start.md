<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vault Secret Engine - Key/Value — agent index

**Provides support for drupal/key to use Vault's KV secret engine as a key source**. Depends on `key`, `vault`.
Version **2.0.0**. Core `^9.3||^10||^11`.

**Security-positive** secret management — Drupal fetches secrets from **HashiCorp Vault** at runtime (not config/DB;
centralized, audited, rotatable). Secure the **Vault connection/auth token** (env, TLS), scope the **Vault policy
least-privilege**, rotate. No access role.
