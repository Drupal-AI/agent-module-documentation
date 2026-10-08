<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# samlauth_group — agent index

Maps **SAML attributes to Drupal group memberships and roles** on SAML SSO login (provision from the IdP's
attributes). Depends on `samlauth`. Version **3.0.0-beta2**. Core `^10.3||^11`.

**Security (critical):** it **grants memberships/roles from IdP-supplied attributes** — trust rests on
**samlauth validating the assertion signature** (attributes can't be forged), trusting only a **trusted
IdP**, and configuring attribute→role **mappings carefully** (a mapping to a privileged role = privilege
escalation for anyone in that IdP group; prefer least privilege). Review the mappings.
