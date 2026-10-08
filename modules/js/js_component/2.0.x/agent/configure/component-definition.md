<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Defining a JS component (`*.js_component.yml`)

A component is a YAML plugin. Create `MODULE_OR_THEME.js_component.yml` at the extension root.
Auto-discovered by `JSComponentManager` (`YamlDiscoveryDecorator`) across every module and every
**enabled theme**. The provider may be a module or a theme; component id = `<provider>.<plugin_id>`.

## Definition keys

```yaml
my_widget:                         # plugin_id (unique within the provider)
  label: 'My Widget'               # required; used as the block admin_label
  description: 'Optional text.'
  root_id: root                    # DOM id the JS mounts on; default 'root'
  libraries:                       # SAME syntax as *.libraries.yml (js/css)
    js:
      /mytheme/dist/widget.js: {}          # path relative to the provider dir
      https://cdn.example/x.js: { type: external }   # 'external' left untouched
    css:
      theme:
        /mytheme/dist/widget.css: {}
  settings:                        # site-builder form; Form API element arrays
    heading:
      type: textfield
      title: 'Heading'
      description: '...'
    variant:
      type: select
      title: 'Variant'
      options: { a: 'A', b: 'B' }
      empty_option: '- Select -'
  settings_scope: dom              # 'dom' (default) or 'attribute'
  settings_allow_token: false      # true → run setting values through Token before render
  template: mytheme/tpl/widget.html.twig   # optional Twig wrapper (path under provider)
  handlers:                        # optional PHP handler classes (see api/handlers.md)
    component_form: \Drupal\my\MyComponentForm
    data_provider: \Drupal\my\MyDataProvider
```

### Key semantics (from `Plugin/JSComponent.php`)
- **`root_id`** — the mount `<div>`'s id. Rendered through `Html::getUniqueId()`, so multiple
  placements stay unique. Special form `settings:<key>` uses the value of setting `<key>` as the id.
- **`libraries`** — paths are rewritten to `/<provider_path><path>` at build time
  (`processLibraries()`); entries flagged `type: external` are passed through verbatim. Turned into a
  real library named `<provider>.<plugin_id>` by `hook_library_info_build()`, then attached as
  `js_component/<component_id>` when the block renders.
- **`settings`** — each entry is a near-verbatim Form API element (its keys become `#type`,
  `#title`, `#options`, …). Only elements whose `#type` is a registered `FormElementInterface` are
  rendered (`elementIsValid()`); others are skipped. Empty values are filtered out before render.
- **`settings_scope`** — `dom` publishes settings to
  `drupalSettings.jsComponent[<plugin_id>][<root_id>].settings`; `attribute` writes each setting as a
  `data-<key>` attribute on the mount `<div>` (values are `Attribute`-escaped).
- **`settings_allow_token`** — when true, each setting value is run through `Token::replace()` with
  the block's `node` context (`['clear' => TRUE]`); a token tree browser is added to the block form if
  the `token` module is enabled.
- **`template`** — when set, the component renders via this Twig file instead of an inline
  `<div>`; the theme hook is registered as the component id with a `template_preprocess_js_component`
  preprocessor (exposes `settings` and block `attributes.class`).

## Placement & configuration
- Each component becomes a block derivative `js_component:<plugin_id>` (category "JS Component"),
  produced by `JSComponentsBlocksDeriver`. Place it via *Structure → Block layout* (or Layout
  Builder). The block form renders the `settings` elements (or a custom `component_form` handler).
- Values are stored in the block's own config (`settings.js_component`). There is **no** module
  settings page and **no** `config/schema` shipped by this module.

## Runtime output shape
- Inline (no template): `<div id="<unique root_id>" class="js-component js-component--<id>"></div>`
  plus attached library and `drupalSettings.jsComponent` (or `data-*` attributes).
- Server-provided `data` (from a `data_provider` handler or the build-data event) is published to
  `drupalSettings.jsComponent[<plugin_id>][<root_id>].data`. See [api/handlers.md](../api/handlers.md).
