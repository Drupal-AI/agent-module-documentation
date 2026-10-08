<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TAPIS Tenant manages TAPIS tenant configuration and credentials.

---

TAPIS Tenant **manages TAPIS tenant configuration** — defining the TAPIS tenant(s) a Drupal gateway connects
to (base URLs, tenant credentials), the foundation other TAPIS modules build on. It stores credentials via the
**Key** module and depends on core Node, Field and Content Moderation, and provides its own permissions, in the
Tapis package.

Use it to configure your TAPIS tenant. It is an integration-configuration foundation. Security/data handling: it
holds **tenant connection credentials/secrets**, and — correctly — stores them via the **Key** module (secret
handling, a positive); keep those keys secured (env/Key), and connect over HTTPS. It has its own permissions.
Configure the TAPIS tenant.

---

- Manage TAPIS tenant config.
- Define tenant base URLs/credentials.
- Underpin other TAPIS modules.
- Store credentials via the Key module.
- Depend on core Node/Field/Content Moderation.
- Provide its own permissions.
- Hold tenant connection credentials/secrets.
- Store them via the Key module (positive).
- Keep the keys secured (env/Key) + connect over HTTPS.
- Configure the TAPIS tenant.
- Handle TAPIS tenant config.
- Define tenants.
- Configure the tenant.
- Set credentials.
- Handle the config.
- Manage tenants.
- Configure TAPIS.
- Handle the integration.
- Secure the keys.
- Provide TAPIS tenant config.
