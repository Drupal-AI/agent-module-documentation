<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consumers Token (consumers_token) — agent index
**Provides one Drupal token, `[consumers:current-name]`, that resolves to the label of the Consumer that made the current API request.**

- **Version:** 8.x-1.x (8.x-1.0-beta4). **Core:** ^8 || ^9 || ^10 || ^11.
- **Depends on:** `consumers:consumers` (only dependency).
- **Package:** Consumers. Maintainer: SystemSeed.
- **Configure:** none — no routes, no permissions, no config, no settings form. Works as soon as it is enabled.

## What it is
The whole module is one file, `consumers_token.tokens.inc`. It is a thin bridge to Drupal's Token API for decoupled/headless sites where one back end serves several front ends that each want their own name (classic use: swap `[site:name]` for `[consumers:current-name]` in a Metatag pattern so each Consumer sees its own title).

## Mechanism (source)
- `hook_token_info()` — registers token type `consumers` and token `consumers:current-name`.
- `hook_tokens($type, $tokens)` — for the `consumers` type / `current-name` token:
  - calls `\Drupal::service('consumer.negotiator')->negotiateFromRequest()` (service owned by the Consumers module) to get the Consumer entity tied to the current request;
  - returns `$consumer->label()` (the Consumer's admin-set name) as the replacement, or an empty string when no Consumer is negotiated.

## Notes for agents
- The "token" here is a **Drupal text-replacement token**, NOT an OAuth/access token or secret. It exposes only the Consumer entity's public label.
- No route returns any value; there is nothing to CSRF-protect and no permission to grant.
- The replacement value is the Consumer label returned verbatim (the module does no encoding of its own; sanitization is left to the token render context, per README).
- `hook_tokens` uses the short `($type, $tokens)` signature — it reads neither `$options['sanitize']` nor the `BubbleableMetadata` argument.

See [../usage.md](../usage.md) and [../human-docs/index.md](../human-docs/index.md).
