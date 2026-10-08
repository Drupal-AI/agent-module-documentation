<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Social Media Platform Links

Single block plugin. Class `Drupal\social_media_platforms\Plugin\Block\SocialMediaBlock`
(`src/Plugin/Block/SocialMediaBlock.php`), extends `Drupal\Core\Block\BlockBase` and implements
`ContainerFactoryPluginInterface`.

Annotation:

```
@Block(
  id = "social_media_platform_block",
  admin_label = @Translation("Social Media Platform Links"),
  category = @Translation("Social Media Platforms")
)
```

The block holds **no per-instance configuration** of its own — it always renders the site-wide
`social_media_platforms.settings` config object (see [config/settings.md](../config/settings.md)).
Placing several instances therefore shows the same links; to vary them per context you vary the
config (e.g. with Domain's `domain_config`), not the block.

## Dependencies injected

`create()` builds the block with three services:

- `theme.manager` (`ThemeManager $themeManager`) — injected but not used by `build()` in 1.1.0.
- `extension.path.resolver` (`ExtensionPathResolver $pathResolver`) — to locate the bundled
  icon images.
- `config.factory` (`ConfigFactory $config`) — to read `social_media_platforms.settings`.

## What `build()` does

1. Computes the icon base path: `'/' . $pathResolver->getPath('module', 'social_media_platforms')
   . '/images'`.
2. Loads the immutable `social_media_platforms.settings` config.
3. Returns a render array themed with `#theme => 'social_media_platforms_links'`, passing
   `#display_options` (the whole `display_options` map) and `#platforms`.
4. Sorts platforms by their `weight` (via `array_combine` + `asort`), then iterates. **A platform
   whose `url` is empty/NULL is skipped** (`if (!$platforms[$key]['url']) { continue; }`).
5. Each rendered platform is the stored row `array_merge`d with two extra keys:
   - `image` → `"<base>/<key>.png"` (e.g. `/modules/contrib/social_media_platforms/images/facebook.png`),
   - `attributes` → a fresh `Drupal\Core\Template\Attribute`.

## Caching

The render array sets cache metadata from the config object itself:

```php
'#cache' => [
  'tags'    => $config->getCacheTags(),      // e.g. config:social_media_platforms.settings
  'context' => $config->getCacheContexts(),
  'max-age' => $config->getCacheMaxAge(),
],
```

So the block is invalidated automatically when the settings config changes. (Note the key is
spelled `context`, not the canonical `contexts`, but that does not affect config-tag
invalidation.)

## Theme, template and icons

- Theme hook `social_media_platforms_links` is declared in
  `social_media_platforms_theme()` with variables `display_options`, `platforms`, `attributes`
  (default `new Attribute()`).
- `social_media_platforms_preprocess_social_media_platforms_links()` attaches the CSS library
  `social_media_platforms/social_media_platforms.theme` (`css/social_media_platforms.theme.css`,
  just link spacing + hover colour).
- Template `templates/social-media-platforms-links.html.twig` wraps everything in
  `<div class="social-media-platforms__container">` and renders one `<a>` per platform:
  - `href` = the platform `url`; `title` = the label; `target="_blank"` added when
    `display_options.target_blank` is true (no `rel="noopener"` is set — modern browsers imply
    it for `target=_blank`).
  - Link classes: `social-media-platforms__link` and `social-media-platforms__link--<key>`.
  - Icon: when `icon_source == 'image'`, an `<img src="{{ item.image }}" alt="{{ item.label }}">`;
    when `icon_source == 'font'`, an `<i class="{{ item.font_classes }}">` (empty when no classes
    configured); when `none`, no icon.
  - Label: a `<span class="social-media-platforms__label">{{ item.label }}</span>` when
    `display_options.show_label` is true.

All dynamic values (url, label, font classes, image path) go through Twig autoescaping / the
`Attribute` object, and URLs are constrained to safe schemes at the form (see
[config/settings.md](../config/settings.md)).

## Custom icon images

To swap the bundled PNGs, override
`template_preprocess_social_media_platforms_links()` (or the template) in a theme and rewrite each
`platforms[<key>].image`. The module builds the default path but expects the theme layer to
customise it (README: "Customize your own icons images via preprocess hook in the theme").

## Placing it

Structure › Block layout › Place block › **Social Media Platform Links** (core `administer
blocks`). It renders nothing but the empty container until at least one platform has a URL set in
the settings form.
