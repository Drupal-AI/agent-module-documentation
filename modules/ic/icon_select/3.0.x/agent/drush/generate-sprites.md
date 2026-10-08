# Drush — generate the SVG sprite

## Command

| Command | Alias | Class |
|---|---|---|
| `generate-sprites` | `gens` | `Drupal\icon_select\Commands\IconSelectCommands::sprites()` |

```bash
drush generate-sprites   # or: drush gens
```

Rebuilds the sprite sheet from every term in the `icons` vocabulary and writes it to
`public://<icon_select.settings:path>` (default `public://icons/icon_select_map.svg`). Prints
`Generated sprites in <uri>`. Registered via `drush.services.yml` (service `icon_select.commands`).

Use it after importing/altering icon terms outside the normal term forms (e.g. a migration), or
if the sprite file was deleted — the term forms already regenerate it automatically on
insert/update/delete via a shutdown function.

## Underlying API

`Drupal\icon_select\Helper\SvgSpriteGenerator` (static):

- `generateSprites(string $vocabulary_id): string` — loads the vocabulary's terms, reads each
  `field_svg_file`, extracts inner nodes and `viewBox`, wraps each as `<symbol id="{symbol_id}">`,
  **sanitizes** the whole sprite with `enshrined\svgSanitize\Sanitizer`, writes the file, and
  updates `State('icon_select_hash')` (cache-buster). Returns the sprite URI.
- `getSpriteDestinationPath(): string` — the configured relative path
  (`icon_select.settings:path`, default `icons/icon_select_map.svg`).

```php
$uri = \Drupal\icon_select\Helper\SvgSpriteGenerator::generateSprites('icons');
```

Terms whose SVG cannot be parsed are logged to the `icon_select` logger channel and skipped.
