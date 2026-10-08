<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building the feeds as Views

Both feeds are ordinary Views **Feed** displays. There is no admin form and no route of the
module's own — you add a Feed display to a View, pick the module's Format (style) and Show (row)
plugins, then map View fields to feed elements in the row plugin's settings form. Access, filters,
sorts, contextual arguments, pager and caching are the View's, not the module's.

## Google News sitemap

- Style (Format): `google_news_feed` (label "Google News").
- Row (Show): `google_news_rss_fields` (label "Google News Fields").
- Output: `<urlset xmlns:news=…>` with `<url><news:news>…` items — a Google News **sitemap**, not
  a classic `<rss>` document. Namespaces `xmlns=http://www.sitemaps.org/schemas/sitemap/0.9` and
  `xmlns:news=http://www.google.com/schemas/sitemap-news/0.9` are added automatically.

Row settings (option keys) and which are required (enforced by `validate()`):

| Option key | Emits | Required |
|---|---|---|
| `link_field` | `<loc>` (absolute node URL) | via `<loc>`; add an absolute-URL field |
| `name_field` | `news:name` — free-text publication name, must match news.google.com exactly | yes |
| `publication_date_field` | `news:publication_date` (W3C/RFC-3339 date) | yes |
| `title_field` | `news:title` | yes |
| `genre_field` | `news:genres` | no |
| `keywords` | `news:keywords` (comma list) | no |
| `stock_tickers` | `news:stock_tickers` (≤5, comma list) | no |

`news:language` is emitted automatically from the current language. `name_field` is a plain text
input (a literal string), not a View field. The genres field is the `field_goo` list_integer field
the module installs (allowed values: PressRelease, Satire, Blog, OpEd, Opinion, UserGenerated) — add
it to the relevant content types (`admin/structure/types/manage/<type>/fields`, re-use existing field
`field_goo`) and expose it in the View.

## Google Shopping / Merchant Center feed

- Style (Format): `google_shopping_feed` (label "Google shopping").
- Row (Show): `google_shopping_rss_fields` (label "Google Shopping Fields").
- Output: `<item>` blocks in the `g:` namespace (`xmlns:g=http://base.google.com/ns/1.0`).

Required row options (`validate()`): `id_field`, `title_field`, `description_field`, `link_field`,
`image_link_field`, `availability_field`, `price_field`, `brand_field`, `mpn_field`,
`product_type_field`. Optional: `condition_field`, `shipping_country_field`,
`shipping_service_field`, `shipping_price_field`, `gtin_field`, `google_product_category_field`,
`color_field`, `age_group_field`, `size_field`. When `shipping_*` fields are set they nest under a
`<g:shipping>` element. When **both** `mpn` and `gtin` resolve empty for a row, the plugin emits
`<identifier_exists>false</identifier_exists>` automatically.

## Two field formatters ship for the fussy fields

- `image_absolute_url` (image fields) — emits an **absolute** image URL string; Google rejects
  relative image links. Extends core `ImageUrlFormatter`, so an image style may be applied.
- `entity_reference_google_shopping_label` (entity reference) — for a taxonomy term, renders the full
  parent → child path joined with `&gt;` (Google product category format), commas in labels replaced
  with `&amp;`. Respects `view label` access on the referenced entity.

Add these as the field formatters on the image / category fields in the View, so the mapped
`image_link_field` and `google_product_category_field` carry Google-valid values.
