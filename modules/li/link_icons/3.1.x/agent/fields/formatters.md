# Field formatter — `link_icons_formatter` (fields)

The module's only registered formatter. Plugin id **`link_icons_formatter`**, label **"Link with
service icon"**, for field type **`link`** (core Link field). Class
`Plugin\Field\FieldFormatter\LinkIconsFormatter` (extends `FormatterBase`). It defers all markup to the
shared procedural helper `_link_icons_link_markup()` in `link_icons.module`.

> Dead code: `.module` also defines `link_icons_field_formatter_info()` (returns id `link_icons_icon`,
> label "Service icon (with options)", field type `link_field`). That is a **Drupal 7** hook signature
> Drupal 8+ does not call — it registers nothing. Ignore it; `link_icons_formatter` is the real one.

## Settings (schema `field.formatter.settings.[link_icons_formatter]`)

`defaultSettings()` and the shared form builder `_link_icons_config_fields()`:

| Key | Default | Type | Options / meaning |
|---|---|---|---|
| `text` | `title` | string | Text shown beside the icon. `none`, `title or else URL`, `title`, `URL`, `title - URL`, `title: URL`, `URL (title)`. |
| `hideURLscheme` | `TRUE` | bool | Strip `http://`/`https://`/`mailto:`/`tel:` from the URL when it appears in the text. |
| `order` | `first` | string | `first` = icon then text, `last` = text then icon. |
| `size` | `1x` | string | FA size class: `1x`,`lg`,`2x`,`3x`,`4x`,`5x` (only applied when `background=none`). |
| `width` | `fixed` | string | `fixed` adds `fa-fw`; `variable` = no fixed width. |
| `coloured` | `coloured` | string | `coloured` emits inline `style="color: <service color>;"`; `uncoloured` omits it. |
| `shaped` | `natural` | string | Which icon variant to prefer: `squared`, `circled`, `squared or else circled`, `circled or else squared`, `natural`. |
| `background` | `none` | string | Optional FA stacked background glyph (e.g. `circle`, `square`, `stop`, `play`, `heart`, `laptop`, …). When set, the icon is wrapped in `<span class="fa-stack …">` and `size` is ignored. |

`settingsSummary()` renders a one-line human summary of the above.

## How an icon is chosen — `_link_icons_link_markup()` (link_icons.module:209)

1. Loads all `link_icon_service` entities (or uses the ones passed in).
2. `parse_url($url)`:
   - scheme `mailto` → hardcoded envelope service (navy); `tel` → hardcoded phone service (navy).
   - `http`/`https`/other → splits the host and builds the trailing 2, 3, 4 and 5-label variants
     (`example.com`, `sub.example.com`, …). Iterates every service's `hostnames` and matches the first
     that equals one of those variants. No match ⇒ **generic navy `globe`** (class `generic`).
3. Picks the icon id per `shaped` (falls back through `icon_square`/`icon_circle`/`icon`), maps
   `icon_style` to FA classes (`fa-solid`, `fa-brands`, `fa-sharp-duotone`, …), appends `fa-<icon>`,
   plus `fa-fw`, size and `fa-stack-1x`/`fa-inverse` for backgrounds.
4. Builds `<i class="…" style="color: <color>;">` (colour only when `coloured != uncoloured`),
   optionally inside a `fa-stack` span for the background.

## Rendering path (safety-relevant)

`viewElements()` calls `_link_icons_link_markup($item->title, $item->getUrl()->toString(), $settings,
$services, TRUE)` with **`$link = TRUE`**. In that mode the icon markup and the text are each wrapped in
`Link::fromTextAndUrl(<text>, Url::fromUri($url, ['attributes' => ['title' => $title, 'target' =>
'_blank']]))->toString()`. The link **URL** goes through `Url::fromUri()` (scheme validation + href
escaping) and the **text/title** is passed as a plain string to `Link::fromTextAndUrl`, so it is
escaped on render. A crafted link *URL/domain* only *selects* a preconfigured service (or the generic
fallback) — the domain is never emitted as a class/attribute — so a content editor's link value cannot
inject markup through the formatter. The icon `class`/`color` come from the service **config entity**,
not from the link.

## Set the formatter from code

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_website', [
    'type' => 'link_icons_formatter',
    'settings' => [
      'text' => 'title',
      'hideURLscheme' => TRUE,
      'order' => 'first',
      'size' => '2x',
      'width' => 'fixed',
      'coloured' => 'coloured',
      'shaped' => 'natural',
      'background' => 'none',
    ],
  ])->save();
```

Font Awesome's library must load on the page (via the contrib `fontawesome` module) or the `<i class="fa
…">` markup renders as empty space.
