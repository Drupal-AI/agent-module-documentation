# Alternative Color — manual setup guide

**Alternative Color** (`altcolor`) is a modern replacement for Drupal's legacy
core **Color** module. It lets administrators customise a theme's colour scheme
through the admin UI — the kind of "pick your theme colours" feature the old Color
module provided, brought forward to newer Drupal versions where that core module
has been deprecated and removed.

It is purely a theming utility: it changes how the site looks and has no content or
access-control role of its own. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** the underlying module documentation for Alternative Color is brief, so
> this guide describes what the module is for rather than a field-by-field tour of
> its screen. Exact options depend on your theme.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling the module, you customise a theme's colours from the admin UI, in
the same spirit as the old Color module — choose the colour scheme for a
colour-aware theme and save. If a theme you use previously relied on core Color,
Alternative Color is what restores that colour-customisation capability on Drupal
10/11.
