# Attribution — manual setup guide

**Attribution** (`attribution`) lets you attach author/source credit and licensing
information to any fieldable entity (nodes, media, and so on) and to your whole
site via a block. It's built for crediting reused or imported content, applying
Creative Commons or other licenses to articles and photos, and showing a site‑wide
license or copyright notice — all backed by a configurable list of licenses you
can import from the standard SPDX license list.

At its core is an **Attribution** field type that stores five pieces of
information: a source name and link, an author name and link, and a chosen license.
It ships **four widgets** (from "License only" up to the default "Source, Author &
License") so editors enter exactly the fields you want, and **six formatters** —
plain text, one‑line text, HTML, and three Creative Commons variants (including one
that shows CC badge icons) — so you can present the credit differently per display.

Licenses are stored as configuration entities. The module installs nine common
ones out of the box (CC0, the CC‑BY family, GPL‑2.0‑or‑later, and All Rights
Reserved), and an admin can import any of the 400+ licenses from the bundled SPDX
license list. Because licenses are config, you can move them between environments
like any other configuration. You can also restrict, per field, which licenses that
field's editors may choose from.

Two blocks round it out: an **Attribution** block and a **Copyright** block, each
rendering a site‑wide notice with a configurable disclaimer that supports core
Token replacement (for example `[current-date:html_year]` and `[site:name]`) plus
`@name` / `@link` placeholders for the selected license.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — managing the license list at
   *Structure → Attribution Licenses*, importing SPDX licenses, and the
   permission that guards them.

## Where it lives in the admin menu

The license list lives at **Structure → Attribution Licenses**
(`/admin/structure/attribution-license`), behind the **Administer attribution
licenses** (`administer attribution_license`) permission. The field type, widgets,
and formatters are configured per bundle on the usual **Manage fields**,
**Manage form display**, and **Manage display** tabs; the two blocks are placed
from **Structure → Block layout**.

## How to use it

### Add attribution to content

1. First, review the license list — see
   [Configuration](configuration/index.md) — and import any licenses you need.
2. On the content type's **Manage fields** tab, add a field of type
   **Attribution**. In the field settings you can (optionally) restrict which
   licenses this field offers editors — leave it empty to allow all.
3. On **Manage form display**, choose one of the four widgets depending on how much
   editors should fill in:
   - **Source, Author & License** (default) — source + author + license.
   - **Source & License** — source + license.
   - **Author & License** — author + license.
   - **License** — license only.
4. On **Manage display**, choose a formatter for how the credit renders:
   - **Plain** or **Plain one‑line** — plain text.
   - **HTML** — linked HTML.
   - **Creative Commons** (default), **Creative Commons (icons)**, or
     **Creative Commons (refined)** — CC‑style output, with the icons variant
     showing CC badge glyphs.
5. Save. Editors now pick a license (and enter source/author as applicable) when
   editing the entity, and the credit renders in the chosen display.

Formatters add license‑aware CSS classes (marking OSI‑approved and deprecated
licenses), so you can style states in your theme, and every formatter maps to an
`attribution-*.html.twig` template you can override.

### Show a site‑wide notice

Place one of the two blocks from **Structure → Block layout** (for example in the
footer):

- **Attribution** — a general license notice (default license
  GPL‑2.0‑or‑later, e.g. "Except where otherwise noted, content on this site is
  licensed under a … license.").
- **Copyright** — a copyright line (default "Copyright © *year* *site name*. All
  rights reserved.").

Each block lets you pick the license and edit the **disclaimer** text, which
supports Token placeholders (like `[current-date:html_year]` and `[site:name]`) and
the license's `@name` / `@link`.

> **Note:** the block disclaimer is admin‑entered HTML rendered as‑is, and the
> block configuration form requires the *Administer blocks* permission. Treat it
> like any trusted full‑HTML admin field.
