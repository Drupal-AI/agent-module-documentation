<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `shortcode` service & `ShortcodePluginManager`

Two services, declared in `shortcode.services.yml`:

```yaml
services:
  plugin.manager.shortcode:
    class: Drupal\shortcode\ShortcodePluginManager
    parent: default_plugin_manager
  shortcode:
    class: Drupal\shortcode\ShortcodeService
    arguments: ['@plugin.manager.shortcode']
```

## `plugin.manager.shortcode` (`ShortcodePluginManager`)

Standard `DefaultPluginManager` for the `shortcode` plugin type (discovery dir
`Plugin/Shortcode`, annotation `Drupal\shortcode\Annotation\Shortcode`, interface
`ShortcodeInterface`). Use it directly only for the usual plugin-manager calls
(`getDefinitions()`, `createInstance($id)`, `hasDefinition($id)`); most call sites go through
the `shortcode` service below instead, which adds token-aware lookups on top.

## `shortcode` (`ShortcodeService`)

```php
$shortcode = \Drupal::service('shortcode');
// or inject Drupal\shortcode\ShortcodeService.
```

| Method | Returns | Use |
|---|---|---|
| `loadShortcodePlugins()` | array of all plugin definitions, keyed by **id**, each with a normalized `token` (defaults to lowercased id) and `weight` (defaults to 99) | Enumerate every shortcode plugin discovered, regardless of any format. |
| `getShortcodePlugins(?FilterInterface $filter, bool $reset = FALSE)` | array of definitions keyed by **token** | No `$filter`: every defined shortcode, one entry per token (highest-weight wins on token collisions). With `$filter`: only the shortcodes enabled in that filter's `settings` (i.e. what a given text format actually renders). |
| `getShortcodePluginTokens(bool $reset = FALSE)` | array of token => token | Quick lookup table of every known token, statically cached. |
| `getShortcodePlugin(string $shortcode_id)` | `ShortcodeInterface` instance | Instantiate (or fetch from static cache) a single shortcode plugin by **id**. |
| `isValidShortcodeTag(string $tag)` | bool | Whether `$tag` matches a defined shortcode token (does not check per-format enablement). |
| `process(string $text, string $langcode, ?FilterInterface $filter)` | string | The core parser: recursively expands `[tag]...[/tag]` / `[tag /]` markup in `$text`, restricted to shortcodes enabled on `$filter` (or all, if `$filter` is `NULL`). This is what `Plugin\Filter\Shortcode::process()` calls; call it directly if you need shortcode expansion outside the filter pipeline (e.g. in a preprocess function or a custom render path). |
| `postprocessText(string $text, string $langcode, ?FilterInterface $filter)` | string | The `shortcode_corrector` filter's logic: strips invalid `<p>` wrapping WYSIWYG editors add around block-level shortcode output. |

### Programmatic expansion example

```php
$shortcode = \Drupal::service('shortcode');
$html = $shortcode->process('[quote author="Ada"]Hello[/quote]', 'en');
```

Passing no `$filter` (or `NULL`) expands **every defined shortcode plugin** regardless of any
text format's per-shortcode enablement — useful for programmatic/administrative rendering, but
not what happens when a real text format processes user-entered content (which is scoped to
that format's enabled shortcodes via the third argument).

### Filter plugin classes that consume these services

- `Drupal\shortcode\Plugin\Filter\Shortcode` (`@Filter(id = "shortcode")`) — injects both
  services; `process()` calls `ShortcodeService::process()`, `tips()` iterates enabled plugins
  via `ShortcodeService::getShortcodePlugins($this)`.
- `Drupal\shortcode\Plugin\Filter\ShortcodeCorrector` (`@Filter(id = "shortcode_corrector")`) —
  calls `\Drupal::service('shortcode')->postprocessText()` directly (not constructor-injected).
