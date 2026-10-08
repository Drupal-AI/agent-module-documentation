# Facebook social plugins — manual setup guide

**Facebook social plugins** (`fb_social_plugins`) brings Facebook's official Social
Plugins into your Drupal site — the **Like** button, the **Share** button, the
**Page** plugin, and the **Comments** plugin. Each one is available two ways: as a
placeable **block** you drop into a region, and as an **extra display field** you
can switch on per content‑type (or other entity bundle) and position on the entity's
display. They render using Facebook's JavaScript SDK, which the module attaches only
on pages where a plugin actually appears.

You configure each plugin from its own settings form in the admin UI — choosing
which entity types it is active on and its layout/size options — then either place
the corresponding block or enable the extra field on a bundle's *Manage display*.
For Like, Share, and Comments the current page's URL is used automatically; the Page
plugin points at a Facebook Page you specify.

Because these plugins load Facebook's third‑party SDK, they can set cookies and let
Facebook observe your visitors even when nobody clicks. Obtain appropriate consent,
integrate with your cookie‑consent solution, and disclose the third‑party tracking
as your jurisdiction requires (for example GDPR). The module itself has no
access‑control role beyond a dedicated permission that restricts who can reach its
settings forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per‑plugin settings forms, and how
   to show plugins as blocks or as fields.

## Where it lives in the admin menu

The plugins are configured at `/admin/fb-social-plugins` (route
`fb_social_plugins.configurations`), with separate forms for Like, Share, Page, and
Comments. Access is gated by the *access fb social plugins config* permission. See
[Configuration](configuration/index.md).
