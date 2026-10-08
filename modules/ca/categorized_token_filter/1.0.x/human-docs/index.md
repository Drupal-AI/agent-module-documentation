# Categorized Token Filter — manual setup guide

**Categorized Token Filter** (`categorized_token_filter`) is a small,
performance-focused enhancement for the
[Token](https://www.drupal.org/project/token) module's token browser. On sites
with a large number of entity types, clicking the familiar "Browse available
tokens" link can take a long time to load, because the browser tries to render
*every* token at once. This module replaces that with a **categorized, filtered**
approach: tokens are grouped into "Global types", the various entity types, and an
"Other" category, and you filter down to the group you want — so the interface
stays fast and responsive.

It's a developer and editor **UX enhancement** layered over Token, with no
content model or access-control role of its own. It depends on core's Token
module and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — there is nothing to set up.
Once it's enabled, the improved, categorized token filter is available wherever
the token browser appears.

## How to use it

After installing and enabling the module, use the token browser as you normally
would — click the **Browse available tokens** link on any form that offers it (for
example, when configuring a pattern with tokens). Instead of one long list, you
now get a modal filter with categories: choose Global types, a specific entity
type, or Other, and narrow the list to find the token you need quickly.
