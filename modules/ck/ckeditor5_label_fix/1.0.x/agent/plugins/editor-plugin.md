<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 plugin + form_alter (label preservation)

Two pieces make CKEditor 5 keep `<label>` markup: the plugin definition
(`ckeditor5_label_fix.ckeditor5.yml`) + its JS (`js/label-fix-plugin.js`), and a `form_alter`
that attaches the library.

## Plugin definition — `ckeditor5_label_fix.ckeditor5.yml`

Plugin id `ckeditor5_label_fix_plugin`. Under `ckeditor5.plugins` it loads two CKEditor plugins:
`htmlSupport.GeneralHtmlSupport` (core GHS) and `ckeditor5_label_fix.CKEditor5LabelFixPlugin`
(this module's JS). Its `ckeditor5.config.htmlSupport` block **disallows** `label`, then **allows**
`a`, `cite`, `em`, `span`, `b`, `strong`, `br` (several with `classes: true`, `attributes: true`,
and `styles: true`) — this is the client-side GHS config for what the editor keeps while editing.

The `drupal` block controls Drupal integration:
- `label`: *"CKEditor5: Preserve <label> markup within li elements"*.
- `library` / `admin_library`: `ckeditor5_label_fix/htmlsupport`.
- `elements`: the **server-side allowed HTML** contributed to the text format when the plugin is
  enabled — `<label for class style lang title>`, `<a href class style lang name id title>`,
  `<cite class style>`, `<em>`, `<b>`, `<strong>`, `<span class style lang title>`, `<br>`.
  (These are enforced by the format's "Limit allowed HTML tags" filter; the `htmlSupport.allow`
  block above only affects in-editor preservation.)
- `toolbar_items.cke5_label_fix_dummy`: a faux toolbar button (label "Label Fix Dummy Plugin",
  icon `cke5_label_fix_dummy`). It is the **enable switch** — dragging it onto the toolbar turns
  the plugin on for that format. The JS registers it via
  `editor.ui.componentFactory.add('cke5_label_fix_dummy', () => null)`, so it renders nothing.

## Client plugin — `js/label-fix-plugin.js`

IIFE using `window.CKEditor5.core.Plugin`. Class `CKEditor5LabelFixPlugin` (static `pluginName`),
exposed at `window.CKEditor5.ckeditor5_label_fix.CKEditor5LabelFixPlugin`. In `init()`:
- `schema.register('label', { inheritAllFrom: '$inlineObject', allowAttributes: ['for','class','style','lang','title'] })`.
- Allows `em, strong, b, i, span, cite, a, br, $text` **inside** `label` (via `schema.extend(... allowIn: 'label')`, guarded by `isRegistered`).
- Allows `label` as a child of `paragraph, listItem, li, span, $root`.
- Extends `cite` to be allowed in `a` and `label`; extends `a` to allow `cite` children.
- Upcast (`converterPriority: 'high'`) and downcast `elementToElement` converters map the `label`
  view element to a model element and back to a container element, copying attributes.

## Library — `ckeditor5_label_fix.libraries.yml`

`htmlsupport`: JS `js/label-fix-plugin.js`; CSS `css/cke5.admin.css` (theme, preprocess);
depends on `core/ckeditor5`.

## `hook_form_alter` — `src/Hook/Ckeditor5LabelFixHooks.php`

OOP hook class `Ckeditor5LabelFixHooks::formAlter()` registered with `#[Hook('form_alter')]`;
`ckeditor5_label_fix.module` provides the `#[LegacyHook]` procedural shim delegating to it. The
class is an autowired service (`ckeditor5_label_fix.services.yml`). Logic: if module `ckeditor5`
exists, iterate top-level form elements; for the first non-object element whose
`['widget'][0]['#type']` is `text_format`, attach library `ckeditor5_label_fix/htmlsupport` and
break. This ensures the JS plugin is present on edit forms even outside the CKEditor build.

## Enable procedure

1. `drush en ckeditor5_label_fix` (or Extend UI).
2. At `/admin/config/content/formats/manage/<format>`, with CKEditor 5 as the editor, drag
   **Label Fix Dummy Plugin** onto the Active toolbar (the enable switch — no visible button).
3. Enable the **Fix CKEditor5 label/link nesting issue** filter (see [filter.md](filter.md)).
4. Save. The allowed-HTML tags/attributes from `elements` are added automatically.
