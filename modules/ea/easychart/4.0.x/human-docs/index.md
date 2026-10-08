# Easychart — manual setup guide

**Easychart** (`easychart`) is a visual editor and field type for building
[Highcharts](https://www.highcharts.com/) charts in Drupal. Editors enter data by
hand in a spreadsheet-like grid or point at a CSV URL, configure the chart in a
JavaScript editor, and the chart renders in content — or is embedded into rich text
via Entity Embed. It's aimed at site builders who want interactive line, bar and pie
charts without writing any Highcharts code.

The module defines an `easychart` field type (storing the data, an optional CSV
source URL, and the Highcharts config) with default and Highcharts-Editor
widgets/formatters, and ships a ready-made **Chart** content type wired up with that
field — so enabling the module immediately gives you a "Chart" node type to author
in. Site-wide defaults, reusable **presets** and **templates** for the editor are
managed under *Configuration → Media → Easychart*. A chart can also pull its data
from a remote CSV URL that Easychart re-fetches on cron and caches back into the
chart.

Two important caveats. First, the chart-authoring JavaScript — Highcharts, the
Highcharts Editor, the Easychart plugin and Handsontable — are **external libraries
that are not shipped with the module**; you install them into `/libraries` either
with the provided Drush command `drush easychart:install` (alias `eci`) or manually.
Second, **Highcharts itself is free only for non-commercial use** — commercial and
government sites need a Highcharts licence. The module depends on core **Node** and
the **Entity Embed** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and download the required JavaScript libraries.
2. [Configuration](configuration/index.md) — the admin settings, presets,
   templates, permissions, the Chart content type and CSV refresh.

## Where it lives in the admin menu

Easychart's admin screens sit under **Configuration → Media → Easychart**
(`/admin/config/media/easychart`), gated by the **Administer easychart settings**
permission. The **Chart** content type appears under *Content → Add content →
Chart*, and Easychart fields can be added to other content types via *Manage
fields*.

## How to use it

1. After installing the module, run `drush easychart:install` (or `ddev drush eci`)
   to download the Highcharts and editor libraries into `/libraries` — the editor
   will not work without them.
2. Create a **Chart** node (or add an *Easychart* field to an existing content
   type).
3. Enter data in the Handsontable grid, or paste a CSV URL to pull data from.
4. Configure the chart's appearance in the Easychart plugin editor or the full
   Highcharts Editor.
5. Save. To place a chart inside body text elsewhere, use **Entity Embed** — the
   module adds a display plugin that embeds just the chart from a referenced node.
