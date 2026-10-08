<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# amazon_pa_filter — the `amazon` filter plugin

File: `src/Plugin/Filter/AmazonFilter.php`, class `AmazonFilter extends FilterBase`, id `amazon`,
type `TYPE_TRANSFORM_IRREVERSIBLE`.

## Token grammar

`process()` matches with `@\[amazon(?: |:|%20)+(.*?)(?:(?: |:|%20)(.*?))?\]@`. So the separator between
the parts can be `:`, a space, or `%20` (space form is deprecated per `hook_help`). Group 1 = ASIN(s),
group 2 = the action/selector (may be empty).

- `[amazon:ASIN:inline]` (or empty action) → theme `amazon_pa_item`
- `[amazon:ASIN:full]` / `[amazon:ASIN:details]` → theme `amazon_details`
- `[amazon:ASIN:thumbnail]` → theme `amazon_item_thumbnail_medium` (uses `$render_[0]`)
- `[amazon:ASIN:button]` → theme `amazon_item_button`
- `[amazon:ASIN:sbutton]` → theme `amazon_item_sbutton`
- `[amazon:ASIN:amzwidget]` → theme `amazon_widget`
- `[amazon:A|B|C:group]` → theme `amazon_asin_group` (multiple items)
- `[amazon:ASIN:<field>]` (default case) → theme `amazon_detail` with `#detail = <field>`, emitting any
  single item value (`title`, `author`, `detailpageurl`, `largeimage`, `amazonpriceformattedprice`, …).

Every render attaches `library: amazon_pa/amazon_pa`.

## Processing steps

1. `preg_match_all` collects `$tokens`, `$asins`, `$actions`.
2. A per-request `global $amz_items` acts as a one-run cache; it is purged if any requested ASIN is
   missing, then rebuilt.
3. All ASINs (splitting `|`-grouped ones) are flattened into `$asin_list`, de-duplicated with
   `array_unique`, and `array_chunk`ed into groups of **10** (Amazon's request max).
4. Each chunk is looked up: `$amz_items = amazon_pa_item_lookup($group, FALSE, NULL) + $amz_items;`
   with `sleep($config->get('tokens.amazon_token_request_delay'))` between chunks (not after the last).
5. Results are re-assembled per token into `$amazon_data`; items with `invalid_asin == 1` are skipped.
6. A `switch ($action)` renders each item to a string via the renderer; `str_replace($tokens, $replace, $text)`
   swaps them back in.
7. ASINs in `$asin_list` that never got processed are appended as `details.amazon_invalid_asin_alt`
   (the configured fallback link).

Returns a `FilterProcessResult($text)`. `tips()` / `settingsForm()` provide the editor help and an
(empty) per-format settings form.

## Notes for agents

- The filter never calls Amazon directly — all network/caching is delegated to `amazon_pa`.
- Because it batches and de-dupes, N tokens for the same ASIN cost one lookup, and >10 distinct ASINs on a
  page trigger multiple sequential requests (hence the token delay to avoid throttle bans).
- Only usable by roles that can use a text format carrying this filter; product strings are XSS-filtered by
  `template_preprocess_amazon_pa_item()` in the parent module.
