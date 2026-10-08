<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ckeditor5_fe_color_config_example — the reference palette recipe

A minimal, working example of how to configure the FeColor palette from a custom module. There is
no UI, no config entity, no route — just three hooks in
`ckeditor5_fe_color_config_example.module` and one CSS file. Copy it to bootstrap your own palette.

## Files

- `ckeditor5_fe_color_config_example.info.yml` — `type: module`, `dependencies:
  [ckeditor5_fe_color]`, `core_version_requirement: ^10 || ^11`, and
  `ckeditor5-stylesheets: [css/ckeditor5.css]`.
- `ckeditor5_fe_color_config_example.module` — the three hooks below.
- `css/ckeditor5.css` — CSS variables + `span.color-*` rules for the editing view.

## The palette it defines

Helper `__ckeditor5_fe_color_config_example_colors()` returns four entries:
Black (`color-black`, `var(--color-black)`), White (`color-white`, `var(--color-white)`,
`hasBorder: TRUE`), Red (`color-red`, `var(--color-red)`), Green (`color-green`,
`var(--color-green)`). `__..._colors_classes()` is `array_column($colors, 'class')`.

## The three hooks

1. `ckeditor5_fe_color_config_example_editor_js_settings_alter(&$settings)` — assigns the palette to
   `$settings['editor']['formats']['basic_html']['editorSettings']['config']['fecolor']['colors']`.
   Change `basic_html` to your target format id (or loop over several).
2. `ckeditor5_fe_color_config_example_ckeditor5_plugin_info_alter(&$plugin_definitions)` — if
   `$plugin_definitions['ckeditor5_fe_color_fecolor']` exists, asserts it is a
   `CKEditor5PluginDefinition`, `->toArray()`, appends
   `'<span class="' . join(' ', __..._colors_classes()) . '">'` to `drupal.elements`, and stores a
   new `CKEditor5PluginDefinition`. This keeps your classes from being filtered out of saved markup.
3. `ckeditor5_fe_color_config_example_library_info_alter(&$libraries, $extension)` — when
   `$extension === 'ckeditor5'`, reads this module's own `ckeditor5-stylesheets` from its
   `.info.yml` (via `extension.list.module`), resolves each path (external / root-absolute kept as
   is, otherwise prefixed with the module path — `UrlHelper::isExternal()` check), and merges them
   into `internal.drupal.ckeditor5.stylesheets` so `css/ckeditor5.css` loads in the editor.

## `css/ckeditor5.css`

Defines `:root { --color-black/white/red/green: … }` and `span.color-black|white|red|green { color:
var(--color-*) }`, plus a `.ck-content h1` padding tweak. All values are hard-coded in-module — no
remote or request-derived sources.

## Reuse

Copy the module, rename functions/machine name, edit the color list and the target format id(s),
and ship your own `ckeditor5-stylesheets` CSS. Also add matching front-end (theme) CSS so the same
classes render on rendered pages, not just inside the editor.
