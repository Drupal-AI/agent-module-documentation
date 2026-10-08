<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon Filter (amazon_pa_filter) — agent index

Submodule of **Amazon PAAPI5**. Provides ONE text-format filter that expands
`[amazon:ASIN:selector]` tags in body text into rendered Amazon product output. Package `Amazon`.
Core `^8 || ^9 || ^10 || ^11`. Depends on `amazon_pa` (`dependencies: amazon_pa:amazon_pa`) and core
`filter`. Version 3.0.1.

## What it provides

- **One plugin**: `Drupal\amazon_pa_filter\Plugin\Filter\AmazonFilter` (id **`amazon`**, type
  `TYPE_TRANSFORM_IRREVERSIBLE`). No routes, no permissions, no config schema, no services.
- **`amazon_pa_filter.module`**: only `hook_help` (`help.page.amazon_pa`) documenting the token syntax.

## How the filter works → [filter/amazon-tag.md](filter/amazon-tag.md)

`AmazonFilter::process($text, $langcode)` regex-matches `[amazon … : action]` tokens, gathers ASINs
(pipe `|` = a group), de-dupes, `array_chunk`s into 10s, and calls `amazon_pa_item_lookup($group, FALSE, NULL)`
per chunk (sleeping `tokens.amazon_token_request_delay` between chunks). A per-request `global $amz_items`
cache avoids re-querying repeated ASINs. Each token is replaced by rendered theme output selected by the
`action`: `group`, `button`, `sbutton`, `amzwidget`, `inline`/empty, `full`/`details`, `thumbnail`, or
(default) `amazon_detail` with `#detail = <action>` to emit any single item field. Unresolved / invalid
ASINs are replaced with `details.amazon_invalid_asin_alt`.

## Enable

Enable the module, then on *Admin → Config → Content authoring → Text formats* add the **Amazon filter**
to a format. Only users with access to that format (trusted authors) can emit these tags. Product strings
are `Xss::filter()`ed in the parent module's preprocess before rendering.
