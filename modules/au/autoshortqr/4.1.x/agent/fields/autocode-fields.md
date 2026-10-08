<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# autoshortqr — computed fields, formatter & Views handlers

## Computed base fields (`autoshortqr_entity_bundle_field_info()`)

For node, taxonomy_term, user and redirect bundles the hook adds, **only when the bundle setting is
enabled**:

- `autoshortqr` — field type `autoshortqr`, added when `qr_enable`.
- `autoshortqr_short_link` — field type `autoshortqr_shortlink`, added when `short_enable`.

Both are `BaseFieldDefinition` with `setComputed(TRUE)`, `setClass(AutoCodeLinkList::class)`,
cardinality 1, and a view display (region hidden by default; display-configurable). Because they are
computed, nothing is stored in the DB. `AutoCodeLinkList` (`src/AutoCodeLinkList.php`) is a
`FieldItemList` using `ComputedItemListTrait`; `computeValue()`/`ensurePopulated()` just create item 0.

## Field types (both extend core `LinkItem`, `no_ui = true`)

`AutoCodeLinkItem` (id `autoshortqr`, `src/Plugin/Field/FieldType/AutoCodeLinkItem.php`) and
`ShortLinkLinkItem` (id `autoshortqr_shortlink`, `ShortLinkLinkItem.php`) both:

- lazily compute their value in `ensureCalculated()` (called from `__get()`, `isEmpty()`, `getValue()`);
- return early when `$entity->isNew()` (no id yet, so no link);
- build `uri = <host>/<prefix>/<base_convert(entity id, 10, 36)>` and `title = t('Self qr link')` /
  `t('Self short link')`;
- `host` = the bundle's `qr_base_domain` third-party setting, defaulting to
  `\Drupal::request()->getSchemeAndHttpHost()`.

Prefixes: node `nc`/`ns`, term `tc`/`ts`, user `uc`/`us`, redirect `rc`/`rs` (QR item / short item).
Note a source quirk: in `AutoCodeLinkItem` the redirect branch reads the base domain from
`UserThirdpartyWrapper` (not `RedirectThirdpartyWrapper`) — practically the same config object, so
the host resolves the same. Both declare the core link constraints (`LinkType`, `LinkAccess`,
`LinkExternalProtocols`, `LinkNotExistingInternal`).

The module also opts these custom types into core's link widget/formatter:
`autoshortqr_field_formatter_info_alter()` adds `autoshortqr_shortlink` to the `link` formatter and
`autoshortqr_field_widget_info_alter()` adds it to `link_default`.

## Formatter `autoshortqr` (`AutoCodeFormatter`)

`src/Plugin/Field/FieldFormatter/AutoCodeFormatter.php` extends the **Barcodes** module's `Barcode`
formatter (so it renders an SVG barcode/QR of the field's URI). Its only override is
`settingsForm()`, which hides the barcode-`type` selector (`$settings['type']['#type'] = 'hidden'`) —
locking the type to whatever the Barcode default is. It is the `default_formatter` for both field
types.

## Edit-form previews (`_autoshortqr_add_autocode_output()`)

The node/user/term/redirect edit-form alters add, into `$form['meta']`, a "QR Code" fieldset (when
`qr_show`) wrapping the rendered `autoshortqr` field inside an `<a href="/autoshortqr/<prefix>/<base36
id>" target="_blank">` link, and — when `qr_show_url` / `short_show_url` — a `#type => link` to the
computed `uri`. Skipped for new (unsaved) entities.

## Views field handlers (`autoshortqr_views_data()`)

Registered on the data/base table of node, user, term and redirect:

- `autoshortqr` → `AutoCodeField` (`src/Plugin/views/field/AutoCodeField.php`, `@ViewsField`): renders
  the QR field (400×400) wrapped in an `<a href="/autoshortqr/<prefix>/<base36 id>">`; `query()` is a
  no-op (computed, nothing to add to SQL).
- `autoshortqr_short_link` → `AutoCodeShortLinkField` (extends the core Views `Url` handler): returns
  `entity.autoshortqr_short_link->uri`; `render()` outputs either a `Link` or the value via
  `sanitizeValue(..., 'url')`. `query()` is a no-op.
