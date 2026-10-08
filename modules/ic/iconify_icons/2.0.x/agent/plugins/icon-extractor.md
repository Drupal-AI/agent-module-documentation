# The `iconify` icon extractor & generated icon packs

Iconify Icons integrates with Drupal 11.1+ **Icon API**. It does two things: it provides an
`IconExtractor` plugin (`iconify`) and it generates one UI **icon pack** per configured collection.

## The extractor plugin

`src/Plugin/IconExtractor/IconifyExtractor.php`

```php
#[IconExtractor(
  id: 'iconify',
  label: new TranslatableMarkup('Iconify'),
  description: new TranslatableMarkup('Provides Iconify list of Icons.'),
  forms: ['settings' => IconPackExtractorForm::class],
)]
class IconifyExtractor extends IconExtractorBase implements ContainerFactoryPluginInterface
```

- This is an instance of **core's** `IconExtractor` plugin type (manager `plugin.manager.icon_pack`);
  the module does **not** define a new plugin type.
- `discoverIcons()` reads `configuration['config']['collections']` (throws
  `IconPackConfigErrorException` if missing), then for each collection calls
  `IconifyApi::getIconsByCollection($collection)` to list the icon slugs. For every slug it builds an
  icon entry:
  - `source = sprintf(IconifyApi::DESIGN_DOWNLOAD_API_ENDPOINT, $collection, $icon_id)`
    → `https://api.iconify.design/{collection}/{icon}.svg`
  - `id = IconDefinition::createIconId($configuration['id'], $icon_id)` → the pack-scoped icon id.
- Injects `iconify_icons.iconify_api` via `create()`.

## How icon packs are created — `hook_icon_pack_alter()`

`iconify_icons.module` implements `hook_icon_pack_alter(array &$icon_pack_definitions)`. For each
collection id stored in `iconify_icons.settings:collections` it adds a pack definition (unless one
with that key already exists), then calls `plugin.manager.icon_pack->processDefinition()`.

Pack id = `strtolower(preg_replace('/[^a-z0-9_]/', '_', <collection>))` — e.g. `mdi` → `mdi`,
`fa-solid` → `fa_solid`. The generated definition (`_iconify_icons_create_icon_pack_definition()`):

| Key | Value |
|-----|-------|
| `enabled` | `TRUE` |
| `label` | `t('Iconify @collection', ['@collection' => $collection])` |
| `extractor` | `iconify` |
| `config.collections` | `[$collection]` |
| `provider` | `iconify_icons` |
| `id` | normalized collection id (pack id) |
| `settings` | see per-icon settings below |
| `template` | the `<img>` template below |

**Per-icon `settings`** (exposed by Icon-API consumers when an editor inserts an icon):

| Setting | Type | Default | Notes |
|---------|------|---------|-------|
| `size` | integer | `32` | maps to `width` + `height` |
| `color` | string | `#000000` | `format: color` |
| `flip` | string enum | — | `original` / `horizontal` / `vertical` / `horizontal,vertical` |
| `rotate` | string enum | — | `0deg` / `90deg` / `180deg` / `270deg` |

## How an icon is rendered (and "stored")

The generated pack template (`_iconify_icons_build_icon_template()`):

```twig
{% set params = {width: size, height: size, rotate: rotate, flip: flip, color: color}|filter(v => v is not null) %}
<img class="{{ class }}" src="{{ source }}?{{ params|url_encode }}" />
```

So a rendered icon is an **`<img>` fetched client-side directly from `api.iconify.design`** — the
transforms (size/color/flip/rotate) are query params the Iconify server applies; the SVG is **not**
inlined into the page and does **not** pass through Drupal on render. The value persisted by the
consumer (UI Icons field/menu/embed, etc.) is the Icon-API id `pack_id:icon_id` (e.g. `mdi:home`);
this module only resolves that id to the `source` URL.

## Adding a collection

Collections are added by selecting them on the settings form — see
[configure/settings.md](../configure/settings.md). A site builder can also hand-define a UI icon
pack in a theme/module using `extractor: iconify` and `config.collections: [<id>]` directly.
