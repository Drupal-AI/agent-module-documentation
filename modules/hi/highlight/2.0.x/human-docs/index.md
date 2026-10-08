# Highlight — manual setup guide

**Highlight** (`highlight`) emphasizes search keywords within your pages by
wrapping the matched terms so a visitor can see at a glance *why* a result
matched and where their words appear. It does the highlighting in JavaScript, on
the client side, which means it can also take the place of server‑side
highlighting (for example, turning off Apache Solr's own highlighting can improve
search performance while Highlight handles the visual emphasis in the browser).

Historically the module handles two cases: highlighting the keywords a visitor
arrived with from a **referring search engine**, and highlighting the keywords
from a **local (on‑site) search**. Because the work happens in the browser, there
is nothing heavy to render server‑side.

The module has no dependencies beyond Drupal core and works on Drupal 9, 10, and
11. A small settings form lets you tune its behaviour, but the defaults are
sensible, so most sites can enable it and move on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form for tuning how and
   where keywords are highlighted.

## Where it lives in the admin menu

Highlight's settings form is provided as `highlight.settings`. You reach it from
the site's **Configuration** area (in the **Search** group, matching the module's
package). See [Configuration](configuration/index.md) for what each option does.
