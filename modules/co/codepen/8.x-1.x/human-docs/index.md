# Codepen Field — manual setup guide

**Codepen Field** (`codepen`) provides a field type for embedding **CodePen**
pens on any fieldable entity — content types, users, custom entities, and so on.
Editors paste a CodePen URL into the field and the module derives the pen and user
identifiers from it; a formatter then renders either a live, interactive embed or
a plain link to the pen. It is a lightweight, editorial-friendly alternative to
pasting raw iframe embed code, and it is built as a trimmed-down adaptation of the
YouTube field module.

Use it to show live front-end demos in articles and tutorials, embed interactive
examples in documentation, or present a portfolio of CodePen demos on a user
profile. Because it is a real field, you can make it multi-value (several pens per
entity), reuse it across bundles, and map imported values onto it with Feeds.

The field offers useful display options: choose which tabs (HTML/CSS/JS/result)
show by default, pick a preset or responsive embed size, set a custom height, and
toggle a result-only preview. Module-wide defaults for these live on a small
settings page.

One thing to be aware of: the live embed loads **CodePen's external embed script**
in the visitor's browser, so the usual third-party-embed privacy considerations
apply (a request to codepen.io is made when the embed renders). If that matters
for your site, the **URL formatter** renders a plain link instead of loading the
external script.

It depends only on core's **Field** module and supports Drupal 8 through 11. The
only route it adds is its own admin settings form, gated by the **Administer
codepen** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Field dependency.
2. [Configuration](configuration/index.md) — site-wide defaults and adding a
   Codepen field to a bundle.

## Where it lives in the admin menu

Module-wide defaults sit at **Configuration → Media → Codepen**
(`/admin/config/media/codepen`), reachable by users with the **Administer
codepen** permission. The field itself is added and configured through the usual
**Manage fields / Manage form display / Manage display** screens on your entity
bundle.
