# Heading Style — manual setup guide

**Heading Style** (`heading_style`) lets site administrators attach CSS classes
to HTML heading tags (`h1` through `h6`) from a configuration form, so headings
across your content pick up consistent styling without anyone editing templates
or hand-typing classes into the editor.

What makes it convenient is that it reads the available CSS classes from a CSS
file and lets you **select** them in the UI rather than typing them by hand — so
you choose from your theme's real classes and avoid typos. Once configured, it
applies the styling to headings found in Body fields, CKEditor content, Views
output, and other text fields, and it refreshes the output immediately using
proper cache invalidation.

It is purely a theming convenience. It carries no content model or access-control
role of its own — it only decorates headings with classes you've chosen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choosing which CSS classes apply to
   which heading levels.

## Where it lives in the admin menu

Heading Style adds a configuration form under **Configuration** where you pick
the classes for each heading level. See [Configuration](configuration/index.md)
for the walkthrough.
