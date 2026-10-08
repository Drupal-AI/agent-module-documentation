# LibreJS — manual setup guide

**LibreJS** (`librejs`) helps your site work with the **GNU LibreJS browser
extension** — the tool that privacy‑ and software‑freedom‑conscious visitors use
to block non‑free JavaScript. The module labels the JavaScript your site serves as
**free (libre) or non‑free**, in the way LibreJS looks for, so that visitors
running the extension can see that your site's scripts are free software and let
them run.

Concretely, the module maintains a list of the **licence** and **source‑code URL**
of each JavaScript file the site uses. That list is published at
`/librejs/jslicense`, visible to any role you grant the **Access JavaScript
license information** permission. LibreJS discovers JavaScript files as they are
loaded when people visit pages, so the list fills in over time — you may need to
visit that page a few times, browsing around the site in between, to see all the
detected files.

There's one behavior to be aware of: to make sure aggregated JavaScript is
accepted by the LibreJS extension, any library **not** flagged as GPL‑compatible is
**no longer aggregated** while this module is enabled. That's intentional — mixing
non‑free scripts into an aggregate would make the whole aggregate unacceptable to
LibreJS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form to fill in**. On Drupal 10.1 and later — which
includes the core requirement for this release — LibreJS needs no configuration:
each library declares its own licence identifier, licence URL, source URL
(`remote`), and GPL‑compatibility in its `*.libraries.yml`. The only setup step is
granting the permission below.

## How to use it

1. Enable the module.
2. Grant the **Access JavaScript license information** permission (under **People →
   Permissions**) to the roles that should be able to view the JavaScript licence
   list — for a fully transparent site, that may include the anonymous role.
3. Make sure the libraries your modules and themes ship declare their licence and
   source information in `*.libraries.yml` (licence identifier, licence URL,
   `remote` source URL, and GPL‑compatibility). Libraries that don't flag
   GPL‑compatibility will not be aggregated.
4. Browse the site, then visit `/librejs/jslicense` to review the detected files
   and their licences. Revisit it after browsing more pages, since files are
   discovered as they load.
