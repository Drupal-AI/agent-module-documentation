<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcode plugin type

The module defines one plugin type: **Shortcode**, the thing that turns a `[tag ...]...[/tag]`
(or self-closing `[tag ... /]`) marker in filtered text into HTML.

- Manager service: `plugin.manager.shortcode` (`ShortcodePluginManager`, extends
  `DefaultPluginManager`).
- Discovery dir: `src/Plugin/Shortcode/` in any enabled module.
- Annotation: `@Shortcode` (`Drupal\shortcode\Annotation\Shortcode`).
- Interface / base: `ShortcodeInterface` / `ShortcodeBase` (abstract, extends `PluginBase`).
- Alter hook: `hook_shortcode_info_alter()`.

## Annotation fields

```php
/**
 * @Shortcode(
 *   id = "col",                 // required. Internal plugin id.
 *   token = "column",           // optional. Parsed tag name in [brackets]; defaults to id
 *                                // (lowercased) if omitted.
 *   provider = "my_module",     // auto-filled by Drupal from the defining module; used to
 *                                // group the settings form by "Shortcodes provided by @provider".
 *   title = @Translation("My shortcode"),        // required. Admin-facing label.
 *   description = @Translation("What it does."), // optional. Shown next to the enable checkbox.
 *   status = TRUE,               // optional, default TRUE. Default enabled/disabled state.
 *   weight = 99,                 // optional, default 99. Lower runs first; when two plugins
 *                                // share a token, the higher-weighted definition wins.
 *   settings = {},               // optional. Default plugin settings array.
 * )
 */
```

**id vs token:** `id` is the plugin's identity in the backend (used for
`plugin.manager.shortcode`, `filter_settings.shortcode` keys, `createInstance()`). `token` is
what the parser actually looks for inside `[...]` — it defaults to `strtolower($id)` when not
set, so most plugins never set it explicitly and `[id]` and the token are the same string.

## Implement one

```php
namespace Drupal\my_module\Plugin\Shortcode;

use Drupal\Core\Language\Language;
use Drupal\shortcode\Plugin\ShortcodeBase;

/**
 * @Shortcode(
 *   id = "callout",
 *   title = @Translation("Callout"),
 *   description = @Translation("Wraps text in a styled callout box.")
 * )
 */
class CalloutShortcode extends ShortcodeBase {

  public function process(array $attributes, $text, $langcode = Language::LANGCODE_NOT_SPECIFIED) {
    $attributes = $this->getAttributes(['class' => '', 'type' => 'info'], $attributes);
    $class = $this->addClass($attributes['class'], 'callout callout--' . $attributes['type']);
    return '<div class="' . $class . '">' . $text . '</div>';
  }

  public function tips($long = FALSE) {
    return $this->t('[callout (type="info"|class="extra")]text[/callout]');
  }

}
```

- `process(array $attributes, string $text, string $langcode)` — required. `$attributes` is the
  parsed `key="value"` map from the opening tag; `$text` is the content between opening and
  closing tags (`NULL` for a self-closing `[tag /]`). Return the replacement HTML string.
- `tips($long = FALSE)` — optional but conventional. Short form shows in the text format's
  filter-tips list; `$long = TRUE` renders on the "more info about text formats" page.
- `settingsForm()` — optional per-plugin config form (rarely used; most plugins configure
  purely through shortcode attributes instead).
- `ShortcodeBase` helpers available to `process()`: `getAttributes($defaults, $attributes)`
  (merge/whitelist attributes), `addClass($classes, $new)`, `getUrlFromPath($path, $mediaFileUrl)`,
  `getTitleFromAttributes($title, $text)`, `getImageProperties($mid)`,
  `render($renderArray)` (renders in isolation so the shortcode's cache metadata doesn't bubble
  up to the host entity).

No config schema is required for a plugin unless it defines its own `settingsForm()` values.

For a complete, minimal worked example see `shortcode_example`'s `col` plugin — the module's own
tutorial for this plugin type.
