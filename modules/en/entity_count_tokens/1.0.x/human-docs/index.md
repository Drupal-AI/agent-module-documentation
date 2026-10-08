# Entity Count Tokens — manual setup guide

**Entity Count Tokens** (`entity_count_tokens`) adds tokens that resolve to **the
number of entities of a given type and bundle**. Drop a token like
`[entity_count_token:node:article]` into your content or configuration and it prints
how many *Article* nodes exist; `[entity_count_token:product:book]` prints how many
*Book* products there are. It's a small, focused way to show live counters and
dynamic copy ("We've published 1,240 articles") without writing any code.

The module integrates with Drupal's **Token** system, so the tokens work anywhere
tokens are supported. To actually render a token inside body text or a text field,
you'll want the **[Token Filter](https://www.drupal.org/project/token_filter)**
module, which provides a text‑format filter that replaces tokens in field output.
The **[Entity Count](https://www.drupal.org/project/entity_count)** module is a
recommended companion.

There's nothing to configure — once enabled, the tokens are available for use. It
supports Drupal 8 through 11. Note this project is **not covered by the security
advisory policy**, so review it before using it on a high‑stakes site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus Token Filter, if you want tokens in text fields).

There is **no configuration page** for this module — it simply makes the count
tokens available.

## How to use it

Once enabled, use a token in the form `[entity_count_token:ENTITY_TYPE:BUNDLE]`:

- `[entity_count_token:node:article]` → the number of Article nodes.
- `[entity_count_token:product:book]` → the number of Book products.

To have such a token replaced inside body/field text, enable **Token Filter** and
add its filter to the relevant text format under **Configuration → Content authoring
→ Text formats and editors**. Tokens are also available in other token‑aware places
across the admin UI.
