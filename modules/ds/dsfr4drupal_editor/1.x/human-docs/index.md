# DSFR for Drupal Editor — manual setup guide

**DSFR for Drupal Editor** (`dsfr4drupal_editor`) makes the HTML produced by your
rich‑text editor comply with the DSFR — the *Système de Design de l'État*, the
French State Design System. French government sites must follow the DSFR, and this
module applies its conventions to editor‑generated content so rich text matches
the design system.

It works by providing a **text‑format filter** you turn on for the CKEditor text
formats where you want DSFR‑compliant output. With the filter enabled, it manages
DSFR behaviors on several components that editors can contribute through CKEditor:

- **Blockquote** — wraps quotes in the DSFR quote component markup;
- **Embedded media alignment** — applies DSFR handling to media alignment;
- **Table** — wraps tables in the DSFR table component markup.

This is a theming/editor‑integration module with **no configuration page of its
own** and no security surface — the setup is simply enabling its filter on the
right text formats. It depends on core's **Editor** module and is part of the
**DSFR for Drupal** suite; it is strongly recommended to use it alongside the
base **DSFR for Drupal** theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page**. Setup is done on your text formats,
described below.

## Where it lives in the admin menu

The module adds no settings page of its own. Its filter is enabled from
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — edit a format, then switch on the DSFR filter.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the CKEditor text format you use for content that must be DSFR‑compliant
   (for example *Full HTML* or a custom format).
3. In the **Enabled filters** list, tick the DSFR filter provided by this module.
4. If you use ordering, place the filter appropriately in the **Filter
   processing order**, and save.
5. Edit a piece of content using that format and confirm blockquotes, embedded
   media alignment, and tables render with the DSFR component markup.
