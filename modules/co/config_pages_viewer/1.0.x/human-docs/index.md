# Config Pages Viewer — manual setup guide

**Config Pages Viewer** (`config_pages_viewer`) is a small addition to the
[Config Pages](https://www.drupal.org/project/config_pages) module. Config Pages lets you
store site‑wide settings as fielded content that editors manage in the admin area — but out
of the box those pages are only *edited*, never *rendered* on the front end. This module
adds a controller that renders a Config Page at a route, so its field values can actually be
displayed on the site.

The route is `/config_pages_viewer/{config_page_type}`, where `{config_page_type}` is the
machine name of the Config Pages type you want to render. The module also provides a theme
hook suggestion so you can theme the output. That is the whole module — it was written as a
lightweight, temporary solution while a related core/contrib issue was being worked out.

It depends on the **Config Pages** module and works across Drupal `^8 || ^9 || ^10 || ^11`.
It is **minimally maintained** (maintenance fixes only), so treat it as a small utility
rather than an actively growing feature.

How access works: each viewer route carries the `_entity_access: config_pages.view`
requirement, which delegates to the Config Pages module. A visitor needs the
**`view config_pages entity`** permission (all types) or the per-type
**`view {type} config page entity`** permission to reach a page. This module adds no
permission of its own — you control who sees each config page's values by granting those
Config Pages permissions to the appropriate roles at **People → Permissions**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (Config
   Pages first).

There is **no configuration page** for this module — it has no settings form. You use it
purely through the viewer route, described below.

## How to use it

1. Make sure the [Config Pages](https://www.drupal.org/project/config_pages) module is
   installed and you have a Config Pages type with some fields and values.
2. Visit `/config_pages_viewer/{config_page_type}`, substituting the machine name of your
   Config Pages type. The controller renders that config page's fields.
3. To customise the markup, override the theme hook suggestion the module provides in your
   theme (`config_pages__{type}`, `config_pages__{view_mode}`, or the combined form).
4. Grant the matching Config Pages `view` permission to whichever roles should see that
   config page's values (see "How access works" above).
