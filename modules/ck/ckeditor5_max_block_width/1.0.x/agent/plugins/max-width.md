<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# maxWidth — CKEditor 5 block-width plugin

Single feature: a toolbar dropdown that sets a block element's max width by toggling a fixed CSS
class. All logic lives in `js/ckeditor5_plugins/maxWidth.js`; wiring is in
`ckeditor5_max_block_width.ckeditor5.yml`; visuals in `css/`.

## Install / enable

1. `drush en ckeditor5_max_block_width` (or via the UI). Module type: standard module; the only
   PHP hook is `hook_page_attachments()` in `ckeditor5_max_block_width.module`, which attaches the
   `ckeditor5_max_block_width/styles` library to every page so width classes render on the front end.
2. Go to **Admin → Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`), edit a **CKEditor 5** format.
3. Drag the **Block width** button into the Active toolbar.
4. Ensure the format's allowed HTML permits `class` on the target tags. The plugin's
   `elements` (`<table class>`, `<img class>`, `<drupal-media class>`) are merged into the format's
   allowed HTML automatically for the "Limit allowed HTML tags" filter.

There is **no module settings form, no route, no permission, no config object/schema** — nothing to
configure besides the per-format toolbar. `configure` is null.

## Plugin declaration (`*.ckeditor5.yml`)

```yaml
ckeditor5_max_block_width_block_width:
  ckeditor5:
    plugins: [ maxWidth.MaxWidth ]
  drupal:
    label: Block width
    library: ckeditor5_max_block_width/ckeditor5_max_block_width
    admin_library: ckeditor5_max_block_width/admin
    toolbar_items:
      maxWidth: { label: Block width }
    elements: [ '<table class>', '<img class>', '<drupal-media class>' ]
```

`CKEditor5.maxWidth.MaxWidth` is the exported global the plugin manager loads.

## Options (the closed value set)

From `OPTIONS` / `LABELS` in the JS:

| Label         | Value          | Effect                          |
|---------------|----------------|---------------------------------|
| Regular width | `''`           | removes both width classes      |
| Wide width    | `max-w-wide`   | adds class `max-w-wide`         |
| Full width    | `max-w-full`   | adds class `max-w-full`         |

These are the **only** values the command accepts; there is no free-text or numeric width input,
and nothing is written into an inline `style` attribute.

## How it works (classes in `src`)

- **`MaxWidthEditing.init()`** — extends schema `$block`, `$blockObject`, `imageInline` with a
  `maxWidth` attribute; `schema.addAttributeCheck` denies it on `EXCLUDED_BLOCKS`
  (`paragraph`, `heading1`–`heading6`). Registers upcast + downcast converters and the command.
- **`MaxWidthCommand`** — `refresh()` computes the current target via `getSelectedTarget()`
  (selected object element, adjacent `imageInline`, nearest `table` ancestor, else nearest allowed
  block ancestor) and exposes `isEnabled`/`value`. `execute({value})` runs `model.change`:
  re-checks `schema.checkAttribute(target, 'maxWidth')`, then `setAttribute('maxWidth', value)` for
  a non-empty value or `removeAttribute` for Regular.
- **Downcast** (`attribute:maxWidth`) — `removeClass` for both `ALL_WIDTH_CLASSES`, then
  `addClass(data.attributeNewValue)` (a constant). Never emits `style`.
- **Upcast** — element listener (priority `lowest`) reads the view `class` string and
  `maxWidthFromClassString()` returns only `max-w-full`/`max-w-wide`; `resolveModelElementForViewUpcast`
  maps the view element back to a model element before setting the attribute. Upcast + downcast give a
  full "class as storage" round-trip.
- **`MaxWidthUI.init()`** — builds the dropdown (`createDropdown` + `addListToDropdown`), binds the
  button label to the command value, and on `execute` calls `editor.execute('maxWidth', {value})`.

## CSS / theming

- `css/max-width.css` (front-end `styles` library) + `css/editor.css` (editor `admin`/plugin
  library) define custom properties: `--max-w-regular: 740px`, `--max-w-wide: 1032px`,
  `--max-w-full: 100%`. Override these in a theme to change the actual widths.
- Front-end rules apply under `.max-w-container` (e.g. `.max-w-container > *`); add that class to the
  body/field wrapper so `max-w-wide` / `max-w-full` take effect on rendered content.
- Editor CSS caps `.ck-content > *` at `--max-w-regular` and animates `max-width` transitions.

## Operating notes

- Behaviour is per text format; no global switch. If widths do not show on the rendered page,
  confirm the content is inside a `.max-w-container` and the `styles` library loaded.
- If a chosen width does not stick after reload, verify the format's allowed HTML still permits
  `class` on that tag (the upcast only restores the class it is allowed to keep).
- Applies to block/object elements and inline images; not to plain paragraphs or headings
  (excluded by design).
