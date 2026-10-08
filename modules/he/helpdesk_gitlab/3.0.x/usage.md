<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GitLab for Helpdesk Integration provides a helpdesk entity type integrating with GitLab.

---

GitLab for Helpdesk Integration **integrates a helpdesk with GitLab** — a helpdesk entity type that connects
support tickets to GitLab (issues/projects) via the Helpdesk Integration framework. It depends on the Helpdesk
Integration module.

Use it to sync helpdesk tickets with GitLab. It is a helpdesk/integration feature. Security/data handling: it
**calls the GitLab API** (egress) with a **GitLab access token** (a powerful secret — store as env/Key, scope it to
least privilege, never commit it) and syncs ticket/issue data. It has no access-control role. Configure the GitLab
credentials.

---

- Integrate a helpdesk with GitLab.
- Connect tickets to GitLab issues.
- Use the Helpdesk Integration framework.
- Depend on the Helpdesk Integration module.
- Serve helpdesk/integration.
- Sync tickets.
- Call the GitLab API (egress) with an access token.
- Store the GitLab token as a secret (env/Key, least privilege, never commit).
- Sync ticket/issue data.
- Have no access-control role.
- Configure the GitLab credentials.
- Handle GitLab helpdesk.
- Sync tickets.
- Configure the client.
- Connect issues.
- Handle the integration.
- Manage tickets.
- Feed GitLab.
- Secure the token.
- Provide GitLab helpdesk integration.
