<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The YAML-only CKEditor 5 plugin registration

This module defines **no plugin type of its own** — it *implements* one CKEditor 5 plugin using
Drupal core's `plugin.manager.ckeditor5.plugin` discovery, entirely in YAML. It is a compact,
reusable pattern for exposing a CKEditor 5 feature that already ships in core's bundled build (here,
`SelectAll`) as a placeable Drupal toolbar button, with zero PHP and zero JavaScript.

## The whole definition

`ckeditor5_select_all.ckeditor5.yml`:

```yaml
ckeditor5_select_all_selectall:        # Drupal plugin id (must be prefixed with the module name)
  ckeditor5:
    plugins:
      - selectAll.SelectAll            # <package>.<PluginClass> exported by CKEditor 5's JS build
  drupal:
    label: Select All
    admin_library: ckeditor5_select_all/admin.selectall
    toolbar_items:
      selectall:                       # toolbar item id — the string stored in a format's toolbar
        label: 'Select All'
    elements: false                    # this plugin contributes no HTML tags
```

How each part resolves:

- **`ckeditor5.plugins`** — a list of JS plugin identifiers of the form `<package>.<Class>`. Because
  `selectAll.SelectAll` is part of the CKEditor 5 distribution that Drupal core bundles, **no JS
  library needs to be declared or shipped**. The module carries no `js/` build. If you wrapped a
  feature that is *not* in core's build, you would additionally declare a `drupal.library`
  (asset library) that loads the plugin's compiled JS.
- **No `drupal.class`** — omitting the class means core instantiates the definition as
  `Drupal\ckeditor5\Plugin\CKEditor5PluginDefault`. A PHP class is only needed for dynamic config,
  conditions (`getDynamicPluginConfig()`), or a settings form.
- **`toolbar_items`** — each key becomes a draggable button in the CKEditor 5 toolbar UI and the
  string persisted in `editor.editor.{format}` `settings.toolbar.items`. Here the id is `selectall`.
- **`admin_library`** — an asset library attached in the text-format admin UI. Here it is CSS-only,
  giving the toolbar button its icon.
- **`elements: false`** — declares the plugin adds no HTML elements, so it imposes no allowed-HTML
  requirements on the text format. (A plugin that produced markup would list tags here instead.)

## Config schema

`config/schema/ckeditor5_select_all.schema.yml` registers the plugin settings type:

```yaml
ckeditor5.plugin.ckeditor5_select_all_selectall:
  type: mapping
  label: 'CKEditor 5 Select All plugin'
  mapping: {}
```

The schema key is `ckeditor5.plugin.<plugin id>` and the mapping is **empty** because the plugin
stores no settings. Any CKEditor 5 plugin that *did* store settings would list them under `mapping`.

## The admin button icon

`ckeditor5_select_all.libraries.yml` declares the `admin.selectall` library; `css/selectall.admin.css`
sets the icon:

```css
.ckeditor5-toolbar-button-selectAll {
  background-image: url(../icons/marker.svg);
}
```

## To adapt this pattern for another core-bundled CKEditor 5 feature

1. Create `mymodule.ckeditor5.yml` with a `mymodule_<feature>` key.
2. Under `ckeditor5.plugins`, list the `<package>.<Class>` identifier(s) for the feature.
3. Add one `toolbar_items` entry (id + label) per button.
4. Set `elements` to `false` (no markup) or to the list of tags the feature emits.
5. Add `config/schema/mymodule.schema.yml` with `ckeditor5.plugin.mymodule_<feature>` (empty mapping
   if there are no settings).
6. Optionally add an `admin_library` for the button icon CSS.
