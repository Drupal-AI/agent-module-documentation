<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node by Email — agent index

Creates **nodes from unseen IMAP email** (subject->title, body->body, configured author). Ingests via
`hook_cron` (interval in seconds), the Drush command `node_by_email:generate_node` (alias `nbe-gn`), or a
manual admin batch form. Needs the PHP **IMAP extension** and Drush `^11`. Version **4.0.x**. Core
`^9 || ^10 || ^11`.

Only unseen messages whose `From` header matches the configured sender are ingested
(`imap_search FROM "…" UNSEEN`). Default `publishing_option` is `0` (unpublished).

## Capabilities

- **Configure** the IMAP mailbox, sender, content type, author, publish state, cron interval — [configure/settings.md](configure/settings.md)
- **Run ingestion** from the CLI (`drush nbe-gn`) — [drush/commands.md](drush/commands.md)
- **Call the services** programmatically (fetch unseen mail, mid->node) — [api/services.md](api/services.md)
- **Permissions** gating the two admin routes — [permissions/permissions.md](permissions/permissions.md)
