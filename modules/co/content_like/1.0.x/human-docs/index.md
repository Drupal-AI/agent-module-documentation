# Content Like — manual setup guide

**Content Like** (`content_like`) adds a simple, AJAX-powered *like / unlike*
widget to your content. Visitors can like a node or a custom block without a page
reload, and the widget shows a running like count. It works for both logged-in
users and anonymous visitors: authenticated likes are tracked by Drupal user ID,
while anonymous likes are tracked with a browser cookie (the module stores a hash
of the cookie value, not the raw value). A unique database key prevents the same
user or the same browser from liking the same item twice.

The module does not turn likes on everywhere by default. After enabling it, you
choose exactly which content types and which custom block types should show the
like widget from its settings page — so you can, for example, enable likes on
blog posts and articles but leave other content untouched.

Once a bundle is enabled, the widget appears automatically wherever that entity's
rendered content is printed (`{{ content }}` in a theme). If your theme prints
fields individually in a custom Twig template, you can place the widget yourself
with a small snippet (shown in the configuration guide).

A note on trust: anonymous liking is intentional, and cookie-based tracking is
best-effort, so treat like counts as a **non-authoritative** measure of
engagement rather than a precise metric. The module depends on core's **Node** and
**Block Content** modules and supports Drupal 10, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which content types and block
   types show the like widget, and how to print it in a custom template.

## Where it lives in the admin menu

Once enabled, the settings page sits at **Configuration → Content authoring →
Content Like** (`/admin/config/content/content-like`). Reaching it requires the
**Administer content like settings** permission.
