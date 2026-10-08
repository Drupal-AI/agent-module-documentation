# Iconify Icons — manual setup guide

**Iconify Icons** (`iconify_icons`) connects Drupal to the
[Iconify](https://iconify.design/) API, giving editors a searchable picker across
Iconify's enormous catalogue — over 200,000 icons from more than 150 open‑source
icon packs — without installing any icon font or SVG sprite locally. Icons are
rendered as clean, optimised inline SVG, so you get a consistent, lightweight
workflow and can add or swap icon sets without shipping unused assets in your
theme.

The module integrates as an **icon provider** for Drupal's Icon API, with the
integration enhanced by the **UI Icons** module. In practice that means once it's
set up, Iconify's collections appear wherever Drupal offers an icon picker — icon
fields, menu items, and other Icon‑API‑aware places.

Two facts decide whether it fits a given site. First, it is **Drupal 11.1+ only**
— there is no Drupal 10 support at all, which is unusually narrow. Second, icon
rendering depends on an **outbound HTTP call to the Iconify API**: a built‑in
cache softens that, but an air‑gapped site, a strict egress policy, or an upstream
outage will all affect it, and requests disclose your usage to a third party.
Where that matters, a self‑hosted alternative such as
[Iconify Field](../../iconify_field/1.2.x/human-docs/index.md) (which serves icons
from a local Composer package) or `font_iconpicker` is worth considering.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (via the recommended
   recipe or manually) and enable it.
2. [Configuration](configuration/index.md) — choose which Iconify icon sets are
   offered, and the egress considerations.

## Where it lives in the admin menu

The settings form is at **`/admin/config/iconify_icons/settings`**
(`iconify_icons.settings`), gated by the **Administer site configuration**
permission. See [Configuration](configuration/index.md).
