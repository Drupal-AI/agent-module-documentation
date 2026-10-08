# DSFR for Drupal Links — manual setup guide

**DSFR for Drupal Links** (`dsfr4drupal_links`) applies the DSFR — *Système de
Design de l'État*, the French State Design System — conventions to **external
links**. The DSFR has specific rules for links that leave the site (an accessible
indication that the link is external, plus safe link attributes), and this module
applies them automatically.

Concretely, it does two things. Based on Drupal's own link generation, it
automatically adds `target="_blank"` to links it considers external — and it does
this **in the backend**, not with client‑side JavaScript. It also adds
`rel="noopener external"` to those external links, as the DSFR recommends (the
`noopener` part is also the general safe‑linking best practice for anything opened
in a new tab). In addition, it lets editors manage the `target` attribute on
links inside CKEditor by providing a dedicated **text‑format filter**.

This is a theming/accessibility module with **no configuration page of its own**
and no security surface — it styles and marks links. It is part of the **DSFR for
Drupal** suite, and it is strongly recommended to use it alongside the base
**DSFR for Drupal** theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page**. External‑link handling works once
enabled; the optional CKEditor filter is turned on per text format, described
below.

## Where it lives in the admin menu

The module adds no settings page of its own. Its automatic external‑link handling
applies as soon as the module is enabled. The optional CKEditor `target` filter
is enabled from **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. **Automatic external‑link handling** — nothing to configure. Once the module
   is enabled, links Drupal generates that point off‑site receive
   `target="_blank"` and `rel="noopener external"` automatically, server‑side.
2. **Optional CKEditor target control** — if you want editors to manage the
   `target` attribute on links within the editor, go to **Configuration →
   Content authoring → Text formats and editors**
   (`/admin/config/content/formats`), edit the relevant CKEditor text format, and
   enable the link/target filter this module provides.
