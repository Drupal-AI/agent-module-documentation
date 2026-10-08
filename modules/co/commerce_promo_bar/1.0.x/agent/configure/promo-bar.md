<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring promo bars

## Place the block
Block layout → place **Promo bar block** into a region. Block setting `stack`:
- on (default): render every matching bar.
- off: render only the highest-weighted matching bar.

## Create/edit a bar
Collection: `/admin/commerce/promo-bars` → **Add promo bar** (`/promo-bar/add`).
Base fields on the `commerce_promo_bar` entity:
- `label` (title), `body` (text_with_summary, tokens allowed).
- `background_color`, `text_color` (color_field; rendered as CSS on `article.promo-bar-wrapper-<id>`).
- `start_date` (required), `end_date`, `countdown_date` (datetime; countdown JS targets `promo-bar-countdown-<id>`).
- `promotion_id` (entity_reference → commerce_promotion; inline entity form) — enables promotion tokens in the body.
- `stores` (limit availability per store), `customer_roles` (limit per role).
- `pages` + `visibility` boolean: newline path patterns with `*` wildcard and `<front>`; visibility on = show on listed pages, off = hide on them.
- `dismissible` (per-session close), `weight`, `status` (enabled).

## Visibility model
General store/role/date filtering happens in `PromoBarStorage::loadAvailable()`. Per-page show/hide is evaluated at block build in `PromoBar::evaluateVisibility()` using the path matcher against both the internal path and its alias (lower-cased).

## Field UI
Add fields / change form & display modes at `admin/commerce/config/promo_bar` (`entity.commerce_promo_bar.settings`). Insert added fields into the bar via tokens or a custom `commerce-promo-bar.html.twig`.
