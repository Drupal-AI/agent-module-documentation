# Smart Content Data Layer — manual setup guide

**Smart Content Data Layer** (`smart_content_datalayer`) is a helper submodule for
[Smart Content](../../smart_content/3.1.x/human-docs/index.md). It lets your
personalization decisions read values straight out of the browser's
`window.dataLayer` — the object that Google Tag Manager and similar tag managers
populate — so you can segment visitors on the analytics and campaign data you're
already collecting.

Concretely, it adds a new group of **dataLayer-backed conditions** to Smart
Content's condition system. When you author a segment you gain conditions whose
keys map to dataLayer properties; at runtime the front-end JavaScript reads those
properties from `window.dataLayer` and supplies the values the conditions are
evaluated against. If your segmentation signals already live in the dataLayer,
this saves you writing custom JavaScript to expose them to personalization.

This is a lightweight integration module. It adds **no admin pages and no
permissions of its own** — all the setup happens inside Smart Content's normal
segment authoring — and it depends only on Smart Content. There's nothing to
configure beyond choosing the dataLayer keys you want to match on when you build a
segment.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

Once enabled, open your Smart Content Decision Block and author a segment as usual.
Among the available conditions you'll now find **dataLayer** conditions: give each
one the dataLayer property key you want to test and the value to match. The module
injects the necessary dataLayer configuration into Smart Content's decision
JavaScript settings, and the front-end reads the live `window.dataLayer` values to
evaluate your conditions — keeping the whole flow client-side and cacheable. It
pairs well with the other Smart Content submodules.
