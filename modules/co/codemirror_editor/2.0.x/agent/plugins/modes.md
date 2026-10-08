# Language mode plugins (`codemirror_mode`)

CodeMirror Editor defines a **language-mode plugin type**. Modes map a machine name to a
CodeMirror mode and its MIME types, so the editor can highlight that language.

## Plugin type wiring

- Manager service: `plugin.manager.codemirror_mode`
  (`Drupal\codemirror_editor\CodemirrorModePluginManager`, implements
  `CodemirrorModeManagerInterface`).
- Discovery: **YAML** — a `MODULE_NAME.codemirror_modes.yml` file in a module's base
  directory (not annotations). Default plugin class `CodemirrorModeDefault`.
- Alter hook: `hook_codemirror_mode_info_alter(array &$modes)`.

## Define a mode

`my_module.codemirror_modes.yml`:
```yaml
MACHINE_NAME:
  label: 'Human label'
  mime_types:
    - text/x-something
  usage: []            # optional: module names that force this mode to load
  dependencies: []     # optional: other mode ids this one needs
```

Example entry (shipped `codemirror_editor.codemirror_modes.yml`):
```yaml
css:
  label: CSS
  mime_types:
    - text/css
    - text/x-scss
    - text/x-less
```

## Modes shipped by default (12)

`clike`, `css`, `htmlmixed`, `javascript`, `markdown`, `php`, `python`, `ruby`, `sql`,
`twig`, `xml`, `yaml`.

Which modes are **preloaded globally** is the `language_modes` sequence in
`codemirror_editor.settings` (see `configure/settings.md`); individual editor/widget/filter
instances also select a `mode`.

## Force a mode to always load

```php
/**
 * Implements hook_codemirror_mode_info_alter().
 */
function my_module_codemirror_mode_info_alter(array &$modes) {
  $modes['php']['usage'][] = 'my_module';   // ensures PHP mode is loaded
}
```

## Add extra CodeMirror assets

For non-mode assets (addons), use:
```php
/**
 * Implements hook_codemirror_editor_assets_alter().
 */
function my_module_codemirror_editor_assets_alter(array &$assets) {
  $assets['js'][] = 'addon/dialog/dialog.js';
  $assets['css'][] = 'addon/dialog/dialog.css';   // paths relative to libraries/codemirror
}
```
