# DROWL Layouts for Bootstrap — manual setup guide

**DROWL Layouts for Bootstrap** (`drowl_layouts_bs`) provides DROWL's default set
of **Bootstrap‑grid layouts** for Drupal. They are responsive, multi‑column
section layouts — defined as Layout Discovery / Layout Options plugins — that you
use when building pages, and they are the Bootstrap successor to the older
Foundation‑based [DROWL Layouts](../../drowl_layouts/4.2.x/human-docs/index.md).
For new sites, this is the layout module DROWL recommends.

It is designed to work as part of the wider DROWL toolset — most naturally
alongside **Layout Paragraphs** and
[DROWL Paragraphs for Bootstrap](../../drowl_paragraphs_bs/4.2.x/human-docs/index.md) —
to build responsive page sections. It depends on core **Layout Discovery**, plus
**Twig Real Content** (for realistic previews) and **Layout Options** (which adds
the per‑section option controls).

The layouts work the moment the module is enabled; there is nothing to configure.
Note that this module does **not** currently have Drupal security‑advisory
coverage, so weigh that as you would for any not‑covered contrib module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its layout dependencies.

There is **no configuration page** for this module — the layouts appear directly
in the Layout Builder / Layout Paragraphs interface, as described below.

## Where it lives in the admin menu

DROWL Layouts for Bootstrap adds no settings page. Its Bootstrap layouts show up
wherever you choose a section layout — in **Layout Builder** and in Layout
Paragraphs. Pick a DROWL Bootstrap layout for a section and set its column and
grid options right there in the section configuration (the extra controls come
from the Layout Options module).
