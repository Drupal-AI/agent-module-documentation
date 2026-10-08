# Info Banner — manual setup guide

**Info Banner** (`info_banner`) displays configurable, site-wide notifications
across your Drupal site — announcements, promotions, maintenance notices,
emergency alerts, legal disclaimers, or any time-sensitive message — without
writing custom code. You control not just the message but exactly *how* and
*where* it appears.

A banner can be rendered in one of three ways: pinned to the **top of the page**,
injected into a **specific DOM element** by its ID (so it lands wherever your
theme has a slot for it), or shown as a **modal popup**. Message text is edited
through Drupal's normal rich-text formats, so links and formatting work as usual.

Beyond the message itself, Info Banner gives you the controls that make banners
practical on a real site: **scheduling** with start and end dates so a banner
activates and expires on its own; an optional **dismiss button** that remembers a
visitor's choice with a cookie; and **path-based visibility rules** (including
wildcards) so a banner shows only on the pages you choose. It is built to be
cache-friendly and **Varnish-compatible**, so it keeps working behind edge
caching.

If you need several independent banners at once, enable the bundled
**Info Banner Blocks** submodule, which lets you create multiple banners as
blocks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally turn on the blocks submodule.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   message, display style, scheduling, dismissal, and path targeting.

## Where it lives in the admin menu

The main banner settings live on the module's settings form (its
`info_banner.settings` route), under **Configuration**. If you enable the
**Info Banner Blocks** submodule, you create additional banners as blocks via
**Structure → Block layout**.
