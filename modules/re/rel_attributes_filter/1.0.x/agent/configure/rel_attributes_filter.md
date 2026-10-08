<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — enabling the rel filters on a text format

There is **no admin settings form and no config schema** in this module. You configure it entirely
through Drupal core's Text Formats UI, by turning one or more of its three filters on for a format.

## UI steps

1. Go to **Administration → Configuration → Content authoring → Text formats and editors**
   (`admin/config/content/formats`).
2. Edit the text format you want (e.g. *Basic HTML*, *Full HTML*).
3. Under **Enabled filters**, tick any of:
   - *Add nofollow to all links* (`filter_nofollow`)
   - *Add noopener to all links* (`filter_noopener`)
   - *Add noreferrer to all links* (`filter_noreferrer`)
4. Under **Filter processing order**, place the enabled filter(s) appropriately (see below).
5. Save.

You can enable more than one on the same format; each adds its own token, producing e.g.
`rel="nofollow noopener"`.

## Config (drush / config export)

Filter state lives in the core `filter.format.<id>` config, not in module-owned config. To enable a
filter from config, add it under the format's `filters` key with `status: true`, e.g.:

```yaml
# filter.format.basic_html.yml (excerpt)
filters:
  filter_noopener:
    id: filter_noopener
    provider: rel_attributes_filter
    status: true
    weight: 100
    settings: {}
```

The plugins define **no settings**, so `settings: {}` is correct. Enable via drush by importing the
edited `filter.format.*` config (there is no dedicated `rel_attributes_filter` config object).

## Exact transform (what enabling actually does)

For each enabled filter, at render time (`process()` → `processAttributes()`):

- The text is parsed with `Html::load()` (DOMDocument), every `<a>` is examined, and the result is
  re-serialized with `Html::serialize()`.
- **Gate:** only anchors whose `target` attribute equals `_blank` are changed
  (`src/Plugin/Filter/NoopenerFilter.php:30`). Links without `target`, or with `target="_self"`, are
  **not** touched — the plugin title "all links" is misleading.
- If the anchor already has a `rel`, the token is **prepended** (`rel="noopener " . existing`);
  otherwise `rel` is set to the token (`NoopenerFilter.php:31-36`).
- The token value is a fixed literal (`nofollow` / `noopener` / `noreferrer`); nothing from the
  request or from config feeds it.

Verified live: `<a href="…" target="_blank">` → `rel="noopener"`; `<a href="…">` unchanged;
`target="_blank" rel="nofollow"` → `rel="noopener nofollow"`; `target="_self"` unchanged.

## Filter order relative to `filter_html`

These are `TYPE_TRANSFORM_IRREVERSIBLE` filters. If attributes are not appearing, check ordering:

- The filter must run at a point where the `<a target="_blank">` markup exists.
- Ordering with `filter_html` is safe either way — the token added is a constant string, and the
  DOMDocument round-trip escapes attribute values, so running after `filter_html` does not reintroduce
  unsafe markup. Ensure `filter_html`'s allowed-attributes list permits `rel` and `target` on `<a>`,
  or `filter_html` (whenever it runs) will strip them.

## Notes / limits

- Applies only to `target="_blank"` anchors (by design in the current code).
- No `hook_link_alter` integration (stated by the maintainer); this is render-time HTML filtering only.
- Works for any content rendered through the chosen format — existing, migrated, and API-submitted —
  not just newly typed CKEditor content.
