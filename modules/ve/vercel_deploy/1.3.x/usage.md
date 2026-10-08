<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vercel Deploy allows integrating Vercel deployments with Drupal, letting users with the corresponding permission trigger Vercel deploys.

---

Vercel Deploy integrates Vercel deployments with Drupal — letting users with the appropriate permission
trigger a Vercel deployment (e.g. rebuild a decoupled/static front end hosted on Vercel after content
changes) from within Drupal, typically via the toolbar. It depends on core Toolbar and provides its own
permissions.

Use it on decoupled sites where content editors should be able to trigger a Vercel rebuild. The
security-relevant points: the Vercel deploy hook URL / API token is effectively a **capability to trigger
deployments** — store it as a secret (not plaintext config), since anyone with it (or with the Drupal
permission) can trigger builds (and repeated triggers could incur cost or be abused). Grant the deploy
permission only to trusted editors. It is an integration/deployment feature; deploy access is gated by its
permission. Configure the Vercel connection (deploy hook/token) as a secret.

---

- Trigger Vercel deploys from Drupal.
- Rebuild a decoupled front end.
- Deploy after content changes.
- Depend on core Toolbar.
- Provide its own permissions.
- Store the Vercel deploy hook/token as a secret.
- Gate deploy by permission.
- Grant deploy to trusted editors only.
- Understand the token triggers builds.
- Mind cost/abuse of repeated triggers.
- Trigger from the toolbar.
- Integrate Vercel deployments.
- Configure the Vercel connection.
- Handle the deploy hook securely.
- Rebuild static front ends.
- Trigger builds securely.
- Support decoupled deploys.
- Configure deploy access.
- Deploy on demand.
- Integrate deployment.
