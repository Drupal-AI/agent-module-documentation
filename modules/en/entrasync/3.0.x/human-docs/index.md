# Microsoft Entra User Sync — manual setup guide

**Microsoft Entra User Sync** (`entrasync`) connects Drupal to the **Microsoft
Graph API** for one or more tenants and **imports users from Microsoft Entra ID**
(formerly Azure AD) into Drupal entities. The entities you map to are plugins;
the module ships user and node plugins out of the box.

It fetches the user properties you choose from Entra and queues them for import
using Drupal's Queue API. Once fetched, you can filter the results by any fetched
property (with a range of operators) to reduce which users are actually imported —
for example only users from a certain department or email domain, which is handy
when different groups should map to different Drupal roles. You map each fetched
Entra property to your own Drupal (text) fields. When mapping to users, you decide
which roles incoming users receive, whether they are active, and whether to send a
welcome email; for nodes you decide published status and whether each update
creates a new revision.

Imported ("managed") entities are stored in Drupal so the module can detect
changes — for example to block or unpublish a user who has been deactivated in
Entra. The first import fetches all users; subsequent syncs use **delta queries**
to fetch only new or changed users, which greatly reduces sync time and resource
use (delta can be disabled if you need to change the fetched properties or
mapping). You can run syncs on cron to keep the user list up to date.

> **Handle this module and its credentials with care.** It reaches out to
> Microsoft (network egress) to read **directory data — real user PII** — and it
> **creates, updates, and can assign roles to Drupal accounts**. That means it can
> be used to escalate permissions, so grant its administration permission
> restrictively and give synced users least‑privilege roles. Its Entra app
> credentials are stored through the **Key** module (a good practice); keep those
> keys secured, scope the Azure app's Graph permissions to the minimum
> (`User.Read.All` is all the module needs), and always run over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Key and MS Graph API dependencies.
2. [Configuration](configuration/index.md) — the Azure app, storing credentials
   as a Key, and setting up synchronisations.

## Where it lives in the admin menu

After enabling, grant the module's administration permission to the appropriate
role(s), add your tenant key(s) via the **Key** module, and then create as many
synchronisations as you need. The credentials themselves are managed through the
Key module and the MS Graph API module; see
[Configuration](configuration/index.md).

## Recommended companions

- **Queue UI** — gives you a UI to the module's queues and lets you process them
  on demand, not only via cron.
- **Ultimate Cron** — for more granular control of the sync schedule.
- **OpenID Connect** — so imported users can log in with their Entra ID.
