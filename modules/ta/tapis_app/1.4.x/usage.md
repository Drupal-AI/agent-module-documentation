<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TAPIS Apps integrates TAPIS applications (science-gateway apps) into Drupal.

---

TAPIS Apps **integrates TAPIS applications into Drupal** — surfacing and managing TAPIS (Texas Advanced
Computing Center's science-gateway API) "apps" so a Drupal science gateway can present and configure computational
applications. It depends on the TAPIS Tenant/Auth/System modules, Webform, Views and others, and provides its own
permissions, in the Tapis package.

Use it to build a TAPIS-backed science gateway. It is a research-computing integration. Security/data handling: it
**calls the external TAPIS API** (egress) and authentication is handled by **TAPIS Auth (OAuth/JWT)** — store the
TAPIS credentials/keys as **secrets** (env/Key) over HTTPS. It has its own permissions. Configure the TAPIS tenant
and app definitions.

---

- Integrate TAPIS apps.
- Present computational applications.
- Build a science gateway.
- Depend on TAPIS Tenant/Auth/System + Webform.
- Provide its own permissions.
- Serve research computing.
- Call the external TAPIS API (egress).
- Authenticate via TAPIS Auth (OAuth/JWT).
- Store TAPIS credentials/keys as secrets (env/Key, HTTPS).
- Configure the tenant + app definitions.
- Handle TAPIS apps.
- Manage apps.
- Configure the apps.
- Present apps.
- Handle the integration.
- Run apps.
- Configure TAPIS.
- Handle the gateway.
- Define apps.
- Provide TAPIS app integration.
