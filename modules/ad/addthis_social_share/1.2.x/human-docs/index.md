# AddThis Social Share — manual setup guide

**AddThis Social Share** (`addthis_social_share`) adds AddThis share buttons to
your site through a configurable block. Visitors use the buttons to share your
pages to social networks, and the module also exposes AddThis's targeting-tools and
content-recommendation features. Two admin settings forms control which services
appear and the more advanced options, and you place the buttons on the page using
Drupal's Block layout.

> **Important — the AddThis service was discontinued.** AddThis was shut down by
> its vendor in 2023. This module wires up the AddThis third-party script, but that
> service is no longer running, so the buttons will not function on a live site
> today. Consider a maintained alternative such as
> [AddToAny](https://www.drupal.org/project/addtoany) for new sites. The rest of
> this guide describes how the module is set up as-is.

The module depends only on core's Field and Block modules. It is a front-end
sharing widget with no access-control role of its own; it does add two permissions
that gate its configuration forms.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the two settings forms and how to
   place the share block.

## Where it lives in the admin menu

The basic settings form is at **Configuration → User interface → AddThis**
(`/admin/config/user-interface/addthis`), gated by the *administer addthis
settings* permission. There is a separate advanced settings form at
`/addthis/advanced`, gated by the *administer advanced addthis settings*
permission. You place the actual share buttons from **Structure → Block layout**.
