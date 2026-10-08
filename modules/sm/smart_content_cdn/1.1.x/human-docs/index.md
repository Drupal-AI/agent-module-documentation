# Smart Content CDN — manual setup guide

**Smart Content CDN** (`smart_content_cdn`) extends [Smart
Content](../../smart_content/3.1.x/human-docs/index.md) so that geo- and
interest-based personalization can happen at the **CDN edge** on Pantheon, using
Pantheon Edge Integrations. Instead of the usual client-side AJAX round-trip to
choose a variation, the CDN itself serves a personalized, cached variant per
audience segment.

It works by reading the geo and interest request headers that Pantheon's Edge
Integrations inject, and by setting `Vary` response headers so the CDN knows to
cache a distinct copy of the page per audience. When a page contains a geo
decision the module adds **Audience** to the `Vary` header; when it contains an
interest decision it adds **Interest**. The result is that visitors from different
countries or with different interests get their own cached variant straight from
the edge — no per-request PHP or JavaScript needed for those segments.

This is a Pantheon-specific integration: it only functions on a Pantheon
environment with Edge Integrations, and it requires the
`pantheon-systems/pantheon-edge-integrations` PHP library (Composer installs it
for you). It builds on Smart Content and the Smart Content Blocks submodule, and
uses the `js_cookie` library. It pairs naturally with **Smart Content Preview**
(to preview segments) and **Smart Content SSR** (server-side rendering).

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **What a visitor can and can't do:** personalization keys off Pantheon-injected
> request headers, so a visitor can only change which marketing variant *they*
> see — it's self-scoped and doesn't expose anyone else's content or any
> access-restricted content. The configuration form itself is behind a restricted
> permission.

## Contents

1. [Installation](installation/index.md) — install with Composer (Smart Content
   and the Pantheon library come along), and enable the module.
2. [Configuration](configuration/index.md) — enable the Vary header, set the
   default geo value, and map interest fields.

## Where it lives in the admin menu

The settings form sits at **Administration → Configuration → System → Smart
Content CDN Configuration** (`/admin/config/system/smart-content-cdn`), gated by
the **configure smart content cdn** permission (which is restricted).
