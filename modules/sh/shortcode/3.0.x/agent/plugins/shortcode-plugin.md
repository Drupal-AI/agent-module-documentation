<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a shortcode plugin

A tag is a plugin of type **`shortcode`**: a class in `src/Plugin/Shortcode/` extending
`Drupal\shortcode\Plugin\ShortcodeBase` and carrying a `#[Shortcode]` attribute (or the legacy
`@Shortcode` annotation — both are discovered).

## Minimal plugin

```php
namespace Drupal\my_module\Plugin\Shortcode;

use Drupal\Core\Language\LanguageInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\shortcode\Attribute\Shortcode;
use Drupal\shortcode\Plugin\ShortcodeBase;

#[Shortcode(
  id: 'cta',
  title: new TranslatableMarkup('Call to action'),
  description: new TranslatableMarkup('Renders a call-to-action box.'),
)]
class CtaShortcode extends ShortcodeBase {

  #[\Override]
  public function process(array $attributes, string $text, string $langcode = LanguageInterface::LANGCODE_NOT_SPECIFIED): string {
    $attributes = $this->getAttributes(['class' => ''], $attributes);
    // ... return the replacement markup ...
  }

  #[\Override]
  public function tips($long = FALSE): string {
    return (string) $this->t('[cta]text[/cta]');
  }

}
```

`[cta]hello[/cta]` calls `process(['...'], 'hello')`; the returned string replaces the tag.

## The `#[Shortcode]` attribute (`src/Attribute/Shortcode.php`)

Constructor properties: `id` (required), `token` (parse token; defaults to `id`), `title`,
`description` (both `TranslatableMarkup`), `status` (default `TRUE` = enabled by default),
`weight` (default `99`; lower processes first, higher wins a token collision), `settings`,
`deriver`. The `@Shortcode` annotation (`src/Annotation/Shortcode.php`) exposes the same fields
and is still valid.

## `ShortcodeInterface` / `ShortcodeBase`

`ShortcodeInterface` extends `ConfigurableInterface`, `DependentPluginInterface`,
`PluginInspectionInterface`, `ContainerFactoryPluginInterface`. Contract methods: `getLabel()`,
`getDescription()`, `settingsForm()`, `process($attributes, $text, $langcode)`, `tips($long = FALSE)`.

`ShortcodeBase` (`src/Plugin/ShortcodeBase.php`) implements the boilerplate. **Constructor
(3.0.x):**
`__construct(array $configuration, $plugin_id, $plugin_definition, protected RendererInterface $renderer)`
— note it **no longer** accepts a `FileUrlGeneratorInterface` (2.x did). Helper methods:

- `getAttributes(array $defaults, array $attributes)` — merge caller attrs over defaults.
- `addClass($classes = '', $new_class = '')` — merge a class into a class string; values run
  through `Html::escape()`.
- `getTitleFromAttributes($title, $text)` — derive a title (`<none>` → empty; else escaped title
  or stripped text).
- `render(array &$elements): string` — `(string) $this->renderer->renderInIsolation($elements)`;
  use this rather than calling the renderer directly (it casts the `Markup` down to `string` to
  match the `: string` return type).
- Config plumbing: `getConfiguration()`, `setConfiguration()`, `defaultConfiguration()`,
  `calculateDependencies()` (returns `[]`), `getType()`, `settingsForm()` (returns `[]` by default).

## Resolving media / path URLs — `MediaUrlResolverTrait`

Plugins that accept a path/media attribute inject
`Drupal\shortcode\MediaUrlResolverInterface` and `use MediaUrlResolverTrait`
(`src/Plugin/MediaUrlResolverTrait.php`), which adds:

- `getUrlFromPath($path, $media_file_url = FALSE)` — normalises `<front>`, returns valid
  absolute/external URLs as-is, otherwise `Url::fromUserInput()`; a `media_file_url` path under
  `/media/<id>` is resolved to the file URL via the injected resolver.
- `getMidFromPath($path)` — extracts the media id from a `media/<n>` path.

The trait requires the including class to declare
`protected MediaUrlResolverInterface $mediaUrlResolver`. See
`shortcode_basic_tags`'s `LinkShortcode`/`ButtonShortcode` (trait) and `ImageShortcode` (direct
resolver injection) for working examples.

## Discovery & registration

- Autowiring resolves `RendererInterface`, `MediaUrlResolverInterface`,
  `EntityTypeManagerInterface`, etc. by type-hint — a hand-written `create()` is only needed for a
  dependency without an FQCN alias.
- `hook_shortcode_info_alter(&$definitions)` lets a module change/override registered tag
  definitions (e.g. weight or token) after discovery.
- After adding a plugin, `drush cr` (rebuilds the `shortcode_info_plugins` cache); the tag then
  appears as a checkbox on every text format's *Shortcodes* filter settings.

**Escaping:** the filter inserts your `process()` return value into the text without further
escaping, so a plugin must escape any attribute value it writes into markup itself (use
`Html::escape()`, an `Attribute` object, or a Twig template with autoescape). See UPGRADING.md in
the module for the full 2.x→3.0 conversion guide.
