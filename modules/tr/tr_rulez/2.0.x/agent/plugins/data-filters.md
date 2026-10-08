<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TypedData filters added by tr_rulez

Source: `src/Plugin/TypedDataFilter/`. These are `typed_data` (Typed Data API module) data filters, registered via `@DataFilter` + `#[DataFilter]`, usable in Rules token/placeholder replacement (e.g. `{{ variable | link:'text' }}`). Both verified present in the `plugin.manager.typed_data_filter` on a running site.

## `link` — URI → HTML anchor
`LinkFilter.php`, extends `Drupal\typed_data\DataFilterBase`.
- `canFilter()`: applies when the data class is a `UriInterface`.
- `filtersTo()`: returns a `string` definition.
- Requires 1 argument (the link text). `validateArguments()` validates the text against the data definition.
- `filter()`: `Link::fromTextAndUrl(Xss::filterAdmin($arguments[0]), Url::fromUri($value))->toString()`, returned as `Markup`. The link text is admin-XSS-filtered; the href comes from the URI value.

## `raw` — prevent HTML-encoding of a string
`RawFilter.php`, extends `DataFilterBase`.
- `canFilter()`: applies to `StringInterface` data.
- `filtersTo()`: returns a `string` definition.
- `filter()`: `Markup::create(Xss::filterAdmin($value))`. It runs the value through `Xss::filterAdmin()` (which strips scripts/unsafe attributes but allows a broad admin tag set) and marks the result safe, so subsequent rendering does not double-encode it. Use it when a Rules message field should emit already-prepared markup instead of escaped text.

## Notes for agents
- `raw` is NOT a pass-through of arbitrary HTML: it always applies `Xss::filterAdmin()` first, so `<script>` and dangerous attributes are removed. Its purpose is to avoid double-encoding of admin-authored markup, not to inject unfiltered HTML.
- `rules_examples` includes `rules.reaction.datafilter_demonstration.yml` / `tr_rulez_datafilter_demonstration.yml` showing these in use.
