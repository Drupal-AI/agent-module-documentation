<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OIDC My Citizen Profile Flanders — agent index

Integrates Drupal login with the **Flemish Government ACM/IDM ("My Citizen Profile")** via OpenID Connect.
Depends on `oidc`, core `telephone`; `oidc_mcpf_user_purge` submodule; ships audience validation +
role mapping. Version **2.0.1**. Core `^10||^11`.

External-authentication (OIDC). **Security:** store the OIDC client secret as a secret; ensure ID-token
**audience** (shipped) + OIDC state/nonce checks are in force; configure role mappings carefully
(over-permissive = over-grant). No content-access role beyond auth/role-mapping.
