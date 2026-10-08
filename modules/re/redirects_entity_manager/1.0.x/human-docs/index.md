# Redirect Entity Manager — manual setup guide

**Redirect Entity Manager** (machine name `redirect_entity_manager`, project
`redirects_entity_manager`) lets editors manage URL redirects **directly from the
content they belong to**, instead of hopping over to a separate redirects
administration page. It builds on the
[Redirect](https://www.drupal.org/project/redirect) module and adds a
**Redirects** tab to nodes, taxonomy terms, and media entities.

From that tab an editor sees redirects in both directions at once — redirects
*from* this piece of content and redirects *to* it — so it's easy to understand,
for example, all the old URLs consolidated onto an important landing page. They
can create a redirect from a system path, a URL alias, or both with a single
form; the module detects and prevents duplicate redirects; and they can edit,
delete, or test each redirect straight from the overview table.

The **Redirects** tab can be turned on per entity type (node, taxonomy term,
media), so you only add it where it makes sense. It also supports multilingual
redirects with language‑specific options. Access uses the Redirect module's own
permissions — users need **Administer redirects** to see and use the tab.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Redirect.
2. [Configuration](configuration/index.md) — choose which entity types get the
   Redirects tab.

## Where it lives in the admin menu

The settings page sits at **Configuration → Search and metadata** →
`/admin/config/search/redirect-entity-manager` (route
`redirect_entity_manager.settings`). The day‑to‑day feature, though, is the
**Redirects** tab that appears on individual nodes, taxonomy terms, and media
entities once you enable them.

## How to use it

1. Choose which entity types show the tab (see
   [Configuration](configuration/index.md)).
2. Open any node, taxonomy term, or media entity of an enabled type.
3. Click the **Redirects** tab.
4. Review the redirects pointing from and to this content, or create a new one
   from its system path, its URL alias, or both.
5. Use the operations dropdown to edit, delete, or test a redirect in place.
