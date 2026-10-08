<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service, delivery hooks and theme negotiator

## `css_editor.css_generator`

`Drupal\css_editor\CssEditorService`, constructed with `@config.factory`, `@file_system`,
`@logger.channel.css_editor`.

```php
public function generateCssFile(string $theme): bool
public function regenerateAllCssFiles(): int   // returns the number of files written
```

`generateCssFile()`:

1. returns FALSE if `css_editor.theme.<theme>:enabled` is falsy, or `css` is empty;
2. `prepareDirectory('public://css_editor', CREATE_DIRECTORY | MODIFY_PERMISSIONS)` —
   logs an error and returns FALSE if that fails;
3. `saveData($css, 'public://css_editor/<theme>.css', EXISTS_REPLACE)` + `chmod()`;
4. writes the resulting URI back to `css_editor.theme.<theme>:path` and returns TRUE.
   Exceptions are caught and logged to the `css_editor` channel.

`regenerateAllCssFiles()` iterates `configFactory->listAll('css_editor.theme.')` and calls
`generateCssFile()` for each.

Other services registered by `css_editor.services.yml`:
`logger.channel.css_editor` and `theme.negotiator.css_editor`.

## How the CSS reaches the page

Two procedural hooks in `css_editor.module`, both keyed on the **active** theme:

```php
function css_editor_library_info_alter(&$libraries, $extension) {
  // when $extension === active theme and _css_editor_get_stylesheet($theme) returns a file:
  $libraries['css_editor']['css']['theme'][$file]['weight'] = 9999;
}

function css_editor_page_attachments(array &$page) {
  // attaches "<active_theme>/css_editor" when a stylesheet exists
}
```

`_css_editor_get_stylesheet($theme)` returns `css_editor.theme.<theme>:path` only when
`enabled` is TRUE **and** `file_exists($path)` — otherwise FALSE. Because the library id used is
`<theme>/css_editor` (i.e. it is added to the *theme's* library namespace, not the module's),
the file is appended at weight 9999 and therefore wins over the theme's own stylesheets.

`css_editor_cache_flush()` calls `regenerateAllCssFiles()` on every cache clear, so a missing or
stale `public://css_editor/<theme>.css` is self-healing as long as the config is right.

## Live preview theme negotiator

`Drupal\css_editor\Theme\CssEditorThemeNegotiator`, tagged `theme_negotiator` with
**priority 100**:

```php
applies()  → isset($_REQUEST['theme']) && $_SERVER['HTTP_REFERER'] === <absolute URL of>
             /admin/appearance/settings/{$_REQUEST['theme']}
determineActiveTheme() → $_REQUEST['theme']
```

So `?theme=<name>` only switches themes for the iframe embedded in that theme's own settings
page — the referer check prevents arbitrary theme switching. The form supplies the iframe URL
in `drupalSettings.CSSEditor.frontPage` (the front page with `?theme=<theme>`).

## Extending

There is no plugin type, no event and no `*.api.php`. To customise behaviour, decorate or
replace the `css_editor.css_generator` service, or implement your own
`hook_library_info_alter()` at a heavier module weight to change where the generated file is
injected.
