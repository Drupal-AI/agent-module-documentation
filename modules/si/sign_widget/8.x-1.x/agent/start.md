<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Signature (sign_widget) — agent index

Lets a user **draw a signature on an HTML5 canvas** and stores it as an image (PNG) or SVG file.
Ships three plugins over core's **image** field type plus a **CKEditor 5** toolbar button.
Version **8.x-1.12** (doc dir `8.x-1.x`). Core `^8.8 || ^9 || ^10 || ^11 || ^12`.
Package *Field types*. License GPL-2.0-or-later. Depends only on core **`image`**.
No composer requirements, no permissions of its own, no Drush, no install hooks, no config-install
objects.

## What it actually is

- **Field widget** `SignWidget` (id `sign_widget`, label *"Sign"*), `field_types: ['image']`,
  extends core `image`'s `ImageWidget`. Selected per form-display on *Manage form display*. →
  [fields/widget-and-formatter.md](fields/widget-and-formatter.md)
- **Field formatter** `SignFormatter` (id `sign_widget_formatter`, label *"Sign"*),
  `field_types: ['image']`, extends core `ImageFormatter`. Renders stored signatures and, when the
  field has spare cardinality, an extra live canvas so viewers can add a signature from the display.
  → [fields/widget-and-formatter.md](fields/widget-and-formatter.md)
- **CKEditor 5 plugin** `Signature` (`src/Plugin/CKEditor5Plugin/Signature.php`, YAML
  `sign_widget.ckeditor5.yml` id `sign_widget_plugin`) — a toolbar button that opens a signature
  pad and inserts the drawn SVG into rich text. → [plugins/ckeditor5.md](plugins/ckeditor5.md)

## Routes / services / theme

- Routes (`sign_widget.routing.yml`):
  - `sign_widget.sendSign` → `/ajax/sign_widget/sendSign/{selector}` → `SendSignForm::saveSign` —
    AJAX save from the **formatter's** live canvas; attaches the image to an entity field.
  - `sign_widget.save` → `/ajax/sign-widget/save` (POST) → `SignWidgetController::save` — AJAX save
    of a **CKEditor** SVG to `public://`.
  - Both are `_permission: 'access content'`. See [plugins/ckeditor5.md](plugins/ckeditor5.md).
- No `*.services.yml`. Controllers/plugins pull core services (`file.repository`,
  `file_url_generator`, `file_system`, `token`, `entity.repository`, `library.discovery`) via DI.
- `hook_theme` registers theme hook **`sign`** (`templates/sign.html.twig`) — the canvas +
  toolbox markup. `hook_help` provides the module help page.
- AJAX command `SendSignCommand` (`src/Ajax/`) → JS command `SendSign` in `js/sign_widget.js`.

## Libraries

- `sign_widget/signature_pad` loads **szimek/signature_pad 4.x** from the jsDelivr **CDN**;
  `signature_pad.local` loads it from `/libraries/signature_pad/docs/js/signature_pad.umd.js` when
  the per-display **`local`** setting is on. `sign_widget/sign_widget` is the module's own behavior
  (`js/sign_widget.js`); `sign_widget/sign` is the compiled CKEditor build.

## Settings (per form-display / view-display, no global config)

`dotSize`, `minWidth`, `maxWidth`, `backgroundColor`, `penColor`, `velocityFilterWeight`,
`canvasWidth`, `signTool` (toolbox), `show_remove_btn`, `local` — schema in
`config/schema/sign_widget.schema.yml` (widget + formatter) and
`sign_widget_plugin.schema.yml` (CKEditor, adds `file_directory`). Keys and defaults in
[fields/widget-and-formatter.md](fields/widget-and-formatter.md).
