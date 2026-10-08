# Authoring a component — the `*.component.yml` file

A component is a folder containing a `MACHINE_NAME.component.yml` file plus its assets (JS/CSS/HTML).
The machine name is the filename minus `.component.yml` and must match a PHP-function-name pattern
(`ComponentDiscovery::PHP_FUNCT_PATTERN`, i.e. `[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*`).

## Discovery rules (`ComponentDiscovery.php`)

- The file must live inside a **`components/`** subfolder of an **enabled** module or theme, or of
  the Drupal web root (`getSearchDirs()`, `ComponentDiscovery.php:195`). Disabled extensions are not
  scanned.
- Discovery recurses into subdirectories but hard-skips a blocklist
  (`RecursiveComponentFilterIterator::$blocklist`): `src`, `lib`, `vendor`, `assets`, `css`, `files`,
  `images`, `js`, `misc`, `templates`, `includes`, `fixtures`, `Drupal`, `node_modules`,
  `bower_components`, `tests`, plus anything in `settings.php`'s `file_scan_ignore_directories`.
  Dot-directories (`.git`) are skipped. Put your `.component.yml` at the top of its component folder,
  not under a `js/`/`css/`/`templates/` subfolder, or it will not be found.
- **`name` and `description` are required** (`$required`, `ComponentDiscovery.php:59`). A file missing
  either is skipped and a `component` logger notice is written (`ComponentDiscovery.php:236-244`).
- **Collision with core SDC:** Single-Directory Components also use `*.component.yml` in `components/`
  folders. This module scans them too and logs `missing required keys description` for each core SDC
  file on every discovery. Core SDC files are otherwise ignored (they lack the module's `description`).

## Keys (defaults from `ComponentDiscovery::$defaults`, lines 73-96)

| Key | Default | Meaning |
|---|---|---|
| `name` | `''` (**required**) | Human label / block `admin_label`. |
| `description` | `''` (**required**) | Shown on the admin table. |
| `type` | `block` | `block`, `library`, or `plugin`. Determines what the component becomes (below). |
| `js` | `{}` | Map of JS files → Drupal library options (`{}`, or `{type: external, minified: true, …}`, or `{attributes: {...}}`). Becomes the `js` section of library `component/<name>`. |
| `css` | `{}` | Map of CSS files → library options. Becomes the `css.component` section. |
| `template` | `index.htm` | HTML file (relative to the component folder) whose contents are printed as the block body. |
| `form_configuration` | `{}` | Per-block settings exposed via Form API on the block config form. See below. |
| `static_configuration` | `{}` | Fixed key/value data emitted as `data-*` attributes on the wrapper. |
| `cache` | `{max-age: 0}` | Block `#cache` array (e.g. `{max-age: 60}`). |
| `dependencies` | `[]` | Drupal library ids this component's library depends on (`core/jquery`, `component/other`, …). |
| `parent` | `''` | For `type: plugin` only — the machine name whose library this plugin can replace. See [../configure/settings.md](../configure/settings.md). |

Additional keys read outside `$defaults`:
- **`theme`** — override the theme hook used to render the block (`ComponentBlock::getThemeHook()`,
  `ComponentBlock.php:110`). Default `component_html`.
- **`contexts`** — `contexts: {entity: <entity_type>}` adds a block context definition
  `entity:<entity_type>` (`ComponentBlockDeriver::createContexts()`, `ComponentBlockDeriver.php:79`).
  Only the `entity` key is handled.
- **`enable_field`** appears in the bundled example ymls but is **not consumed** by this module (it
  targets a separate, not-present `component_field` module). Setting it here does nothing.

## Component types

- **`block`** (default) — a derived block plugin `component:<machine_name>` is created
  (`ComponentBlockDeriver`). Place it like any block. Render mechanics: [../plugins/block.md](../plugins/block.md).
- **`library`** — no block; only the Drupal library `component/<machine_name>` is registered. Use it
  to publish a shared/vendor bundle (e.g. React from a CDN) that other components list under
  `dependencies`. Example: `example_react_lib`.
- **`plugin`** — a "lite" swap-in. It is neither a block nor auto-attached; it appears on the admin
  form grouped by its `parent`, and the selection is stored in `component.admin`. On the next library
  rebuild the parent's `dependencies` are replaced with `component/<selected plugin>`
  (`component_library_info_build()`, `component.module:63-68`).

## Minimal example

```yaml
# widget.component.yml (in some_module/components/widget/)
name: Widget
description: 'A demo widget.'
type: block
js:
  widget.js: {}
css:
  widget.css: {}
static_configuration:
  greeting: 'Hello'
cache:
  max-age: 60
```

This yields block `component:widget` and library `component/widget`. The rendered wrapper carries
`data-greeting="Hello"`; `widget.js` reads it off its parent element.
