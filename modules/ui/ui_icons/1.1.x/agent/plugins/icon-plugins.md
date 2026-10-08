# Icon packs & extractor plugins

UI Icons relies on **Drupal core's** Icon API (`\Drupal\Core\Theme\Icon`, 11.1+).
The base `ui_icons` module defines **no** plugin manager of its own — it consumes:

- `plugin.manager.icon_pack` → `\Drupal\Core\Theme\Icon\Plugin\IconPackManager`.
  Discovers icon packs from `EXTENSION_NAME.icons.yml` in any module or theme root.
- `plugin.manager.icon_pack.extractor` → `\Drupal\Core\Theme\Icon\IconExtractorPluginManager`.
  Runs extractor plugins declared with the `#[IconExtractor]` attribute
  (`\Drupal\Core\Theme\Icon\Attribute\IconExtractor`), base class
  `\Drupal\Core\Theme\Icon\IconExtractorBase`.

## Declare an icon pack — `mymodule.icons.yml`

Place at the extension root. Each top-level key is a `pack_id`.

```yaml
my_pack:
  label: "My icons"            # recommended
  description: "Project icons" # optional
  extractor: svg               # required: path | svg | svg_sprite | (contrib, e.g. font)
  config:
    sources:                   # required for path/svg/svg_sprite
      - icons/{icon_id}.svg    # {icon_id} captures the id from the filename
      - icons/*.svg            # glob is allowed
  template: >                  # required: Twig to render one icon
    <img src="{{ source }}" width="{{ size|default(24) }}" height="{{ size|default(24) }}"/>
  # optional metadata
  version: 1.0.0
  license: { name: GPL-2.0-or-later, url: '...', gpl-compatible: true }
  links: ['https://example.com']
  enabled: true                # set false to skip discovery
  library: mymodule/my_icons   # attach a Drupal library (icon-font CSS/JS)
  preview: >                   # optional admin-only preview template
    <i class="my-icon my-icon-{{ icon_id }}"></i>
  settings:                    # optional per-icon settings → Drupal Form API
    size:
      title: "Size"
      type: integer            # string|number|integer|boolean (JSON-Schema subset)
      default: 24
```

### Core extractors
- `path` — icons are files (any type) or remote URLs; template gets `source`.
- `svg` — local SVG only (no remote, for security); template also gets `content`
  (the inner SVG markup without the `<svg>` wrapper).
- `svg_sprite` — one sprite file; template gets a symbol reference; remote allowed.

Template variables: `icon_id`, `source`, any extractor-specific vars, plus every key
from `settings`. `config.sources` patterns support `{icon_id}` and `{group}` captures
and `*` globs; a leading `/` resolves from the Drupal root (e.g. `/libraries/...`).

## Provide a custom extractor

Add a class under `src/Plugin/IconExtractor/` with the `#[IconExtractor(id, label, ...)]`
attribute, extending `IconExtractorBase` (or implement
`IconExtractorWithFinderInterface` to reuse `config.sources` discovery). See the
submodule `ui_icons_font`'s `FontExtractor` for a working web-font example.
