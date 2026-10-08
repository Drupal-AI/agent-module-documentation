<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Helpdesk Integration provides a helpdesk framework for other modules.

---

Helpdesk Integration provides a **helpdesk/ticketing framework** — a base that lets other modules integrate
external helpdesk systems (creating/syncing tickets, comments, attachments) into Drupal, using core Comment,
File and Text. It provides its own permissions, in the Helpdesk package (core 11.4+).

Use it as the base for a helpdesk integration. It is an integration framework. Security/data handling: concrete
integrations talk to an **external helpdesk API** — handle their **API credentials** as secrets (env/Key), use
HTTPS, and treat ticket data (which may contain user PII) accordingly; access to helpdesk features is governed
by its permissions. It has no access-control role beyond its permissions. Build/configure a helpdesk integration
on it.

---

- Provide a helpdesk framework.
- Let modules integrate ticketing.
- Sync tickets/comments/attachments.
- Use core Comment/File/Text.
- Provide its own permissions.
- Base for helpdesk integrations.
- Talk to an external helpdesk API.
- Handle API credentials as secrets.
- Use HTTPS + treat ticket PII carefully.
- Gate helpdesk features by permission.
- Have no access-control role beyond permissions.
- Build an integration on it.
- Handle helpdesk integration.
- Integrate helpdesk.
- Configure the framework.
- Sync tickets.
- Handle the integration.
- Manage tickets.
- Secure the credentials.
- Provide a helpdesk framework.
