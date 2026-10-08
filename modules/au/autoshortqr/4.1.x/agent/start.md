<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto short qr (autoshortqr) — agent index

Adds two **computed** link fields — a self-referencing **short URL** and a self-referencing
**QR/barcode** — to **node, user, taxonomy_term and redirect** entities, plus routes that resolve a
base36 entity id back to a redirect and stream the QR as SVG. Enabled per bundle via a third-party
**"Autocode"** settings section. Core `^10 || ^11`, PHP `^8.1`, GPL-2.0-or-later. Version 4.1.1.
**Not** security-advisory covered.

- **Dependency:** `barcodes` (drupal/barcodes ^2.1; needs the `tecnickcom/tc-lib-barcode` library).
  No permissions, no Drush, no config schema.
- **Configuration & tokens (the third-party "Autocode" settings, config object, UTM, form alters):**
  → [config/settings.md](config/settings.md)
- **Routes / controller (short-URL resolution + QR download):** → [routes/resolvers.md](routes/resolvers.md)
- **Fields, formatter, computed link lists, Views handlers:** → [fields/autocode-fields.md](fields/autocode-fields.md)

## What it actually provides (from source)

- **Field types** (`no_ui = true`, both extend core `LinkItem`): `autoshortqr`
  (`src/Plugin/Field/FieldType/AutoCodeLinkItem.php`, the QR link) and `autoshortqr_shortlink`
  (`src/Plugin/Field/FieldType/ShortLinkLinkItem.php`, the short link). Each computes its own
  `uri` = `<base_domain>/<prefix>/<base36(entity id)>` on read via `ensureCalculated()`.
- **Computed base fields** added in `autoshortqr_entity_bundle_field_info()`: `autoshortqr` (when
  bundle setting `qr_enable`) and `autoshortqr_short_link` (when `short_enable`), both using
  `AutoCodeLinkList` (`src/AutoCodeLinkList.php`, a computed `FieldItemList`).
- **Field formatter** `autoshortqr` (`src/Plugin/Field/FieldFormatter/AutoCodeFormatter.php`)
  extends the Barcodes module's `Barcode` formatter and hides the barcode-type selector.
- **Controller** `CodeController` (`src/Controller/CodeController.php`) with 12 routes
  (`autoshortqr.routing.yml`): resolve routes `/nc /uc /tc /rc` (QR) and `/ns /us /ts /rs` (short)
  that 302-redirect to the entity canonical URL; download routes `/autoshortqr/{nc,uc,tc,rc}/…`
  that return the QR SVG. All gated only by `_permission: "access content"`.
- **Views field handlers:** `autoshortqr` (`AutoCodeField`) and `autoshortqr_short_link`
  (`AutoCodeShortLinkField`); registered via `autoshortqr_views_data()`.
- **Tokens:** `iqac_short_link`, `iqac_qr_link`, `iqac_qr_download_link` on node/term/user/redirect
  (`autoshortqr_token_info()` / `autoshortqr_tokens()`).
- **Wrappers:** `UserThirdpartyWrapper` / `RedirectThirdpartyWrapper` fake `ThirdPartySettingsInterface`
  for the user & redirect "bundles" (which have no config entity), backing config object
  **`autoshortqr.settings`** (keys prefixed `user.` / `redirect.`).

No update hooks, no `.install`, no services.yml. The shipped `config/optional/iq_autocode.settings.yml`
is a legacy filename and is **not** the config object used at runtime (that is `autoshortqr.settings`).
