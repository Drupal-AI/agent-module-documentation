# Style Switcher — manual setup guide

**Style Switcher** (`styleswitcher`) lets your website visitors choose which
stylesheet they want to view the site with, and remembers their choice. You define
a set of alternative styles — a high-contrast variant, a larger-text variant, a
dark skin, a seasonal look, a print-friendly sheet — and the module presents them
to visitors as a list of links in a block. Click a link, and the site's look
changes on the spot.

The problem it solves is offering readers a choice of appearance without building a
whole theme for each one. A themer can ship a theme with alternate stylesheets, and
a site builder can add further alternate stylesheets from the admin section; Style
Switcher gathers them all and presents them to visitors. It uses cookies so that
when someone returns to the site or moves to another page, they still get the style
they picked. There is a genuine accessibility angle here — an opt-in high-contrast
or large-text stylesheet is a recognised accommodation — though it is a blunter
tool than designing accessible defaults, and each variant is only as good as the
CSS behind it.

The module needs a little configuration before visitors see anything: you define
the available styles on its admin page and place the switcher block. It has **no
module dependencies**. All administration sits behind a single permission,
**Administer Style Switcher**; the visitor-facing act of choosing a stylesheet
needs no permission, since picking a look is not a privileged action. The styles
you define are stored as configuration entities, so they export and deploy with
`drush config:export`/`config:import` like any other configuration.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define your alternate styles per
   theme and place the switcher block.

## Where it lives in the admin menu

Once enabled, the settings live at **Configuration → User interface → Style
Switcher** (`/admin/config/user-interface/styleswitcher`), where you add and edit
the styles offered — per theme. Visitors change styles through the **Style
Switcher** block, which you place in a region like any other block.
