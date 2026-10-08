<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Promo Bar adds a fieldable `commerce_promo_bar` content entity and a block that displays one or more promotional/notification bars at the top of (or anywhere on) a store's pages.
---
The module solves the recurring store need to surface sale banners, coupon codes and time-limited announcements without hand-editing templates. Each promo bar is a translatable Commerce content entity with a title, a WYSIWYG body (token-enabled), background/text colours (via the color_field module), start/end dates, an optional countdown date, an optional related `commerce_promotion` reference (so coupon codes can be tokenised into the body), and visibility restrictions by store, customer role and path. Entities are managed at `/admin/commerce/promo-bars`; field, form and display settings live at the field-UI base route `admin/commerce/config/promo_bar`.

Rendering is done by the `promo_bar_block` block plugin (place it in a region via Block layout). At build time the block asks `PromoBarStorage::loadAvailable()` for bars matching the current store and the current user's roles, then applies per-page visibility with `PromoBar::evaluateVisibility()` (path-alias aware, show/hide semantics). A "Stack promo bars" block setting controls whether all matching bars render or only the highest-weighted one; dismissible bars and countdown timers are driven client-side via `drupalSettings.commercePromoBar` and the bundled `countdown` library. Access is governed by the Entity API: the entity declares `admin_permission = "administer commerce promo bar"` with `EntityPermissionProvider`/`EntityAccessControlHandler`, and the settings route is gated by the `administer commerce promo bar` permission — no anonymous or mutating endpoints are exposed.
---
- Enable the module together with Commerce, commerce_promotion and color_field.
- Place the "Promo bar block" in a region through Block layout.
- Create a new promo bar at `/admin/commerce/promo-bars`.
- Write the bar message in the WYSIWYG body field.
- Insert a coupon code or promotion data into the body with tokens.
- Reference a `commerce_promotion` so its tokens become available in the body.
- Set a background colour for the bar.
- Set a text colour for the bar.
- Give the bar a start date so it appears only after a moment.
- Give the bar an end date so it auto-expires.
- Set a countdown date to display a live countdown timer.
- Mark a bar dismissible so visitors can close it (per session).
- Restrict a bar to one or more specific stores.
- Restrict a bar to selected customer roles.
- Restrict a bar to specific paths (e.g. `/blog/*` or `<front>`).
- Invert the path rule to hide the bar on the listed pages instead.
- Order competing bars by setting their weight.
- Enable or disable a bar without deleting it via the enable/disable forms.
- Turn off "Stack promo bars" to always show only the top-weighted bar.
- Duplicate an existing bar to create a variant quickly.
- Bulk-delete promo bars from the collection's delete-multiple form.
- Translate a promo bar's title/body into other languages.
- Add custom fields to the promo bar bundle via the field-UI settings route.
- Adjust the promo bar view mode / field formatters for custom layouts.
- Override `commerce-promo-bar.html.twig` for full markup control.
