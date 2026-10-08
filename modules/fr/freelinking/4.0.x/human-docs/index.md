# Freelinking — manual setup guide

**Freelinking** (`freelinking`) is a text‑format filter that turns wiki‑style
`[[indicator:target]]` markup into real HTML links. Instead of writing full URLs,
editors write compact tokens — `[[nodetitle:Page One]]`, `[[user:jane]]`,
`[[wiki:Drupal]]` — and Freelinking resolves each one into the correct link when the
content is displayed. It's the easiest way to give a site wiki‑like cross‑referencing
without teaching editors your URL structure.

The magic is in the **indicator**: the bit before the colon selects a Freelinking
*plugin* that knows how to resolve that kind of target. Bundled plugins cover local
nodes (by title or id), user profiles, path aliases, site search, Google search,
Wikipedia, Drupal.org projects, managed files, and plain external URLs — and the
framework is extensible, so developers can add their own indicators with a small
plugin. You can also add custom link text with a pipe: `[[nodetitle:Page One|Read
more]]`.

Freelinking runs as part of a **text format**, so you enable and tune it per format,
and its reach follows whoever is allowed to author in that format. The **External**
plugin has a "scrape" option (on by default) that fetches the linked external URL
server‑side to derive a link title; the configuration guide covers where to turn it
off.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the optional Prepopulate submodule).
2. [Configuration](configuration/index.md) — enabling the filter on a text format,
   choosing plugins, the default plugin, and the scrape option.

## Where it lives in the admin menu

Freelinking is configured on the standard **Text formats and editors** page at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`, route `filter.admin_overview`), by enabling and
tuning its filter within each format. See [Configuration](configuration/index.md).

## How to use it

Once the filter is enabled on a format (see [Configuration](configuration/index.md)),
editors write links inline in any field that uses that format. A few examples:

- `[[nodetitle:Page One]]` — link to a node by its title.
- `[[node:123]]` (or `[[nid:123]]`) — link to a node by id.
- `[[user:jane]]` — link to a user profile.
- `[[path:some/alias]]` — link via a URL alias.
- `[[search:widgets]]` — a site‑search link; `[[google:widgets]]` for a Google search.
- `[[wiki:Drupal]]` — link to a Wikipedia article.
- `[[https://example.com]]` — link to an external URL.
- `[[file:report.pdf]]` — link to a managed file.
- `[[nodetitle:Page One|Read more]]` — any of the above with custom link text.
