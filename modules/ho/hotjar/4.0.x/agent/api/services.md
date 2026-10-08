# Hotjar — services & snippet flow

Three services (`hotjar.services.yml`). The snippet is emitted from
`hotjar_page_attachments()`: it calls `hotjar.access->check()`, and if allowed,
`hotjar.snippet->pageAttachment($attachments)`.

## `hotjar.settings` — `Drupal\hotjar\HotjarSettings`

Reads `hotjar.settings` config, back-fills defaults, runs `hook_hotjar_settings_alter()`.

| Method | Returns |
|---|---|
| `getSettings($force = FALSE)` | full settings array (cached; `$force` re-reads). |
| `getSetting($key, $default = NULL)` | one setting value. |

Interface constants (`HotjarSettingsInterface`): `HOTJAR_SNIPPET_VERSION`,
`HOTJAR_SNIPPET_PATH`, `HOTJAR_PAGES`, `ATTACHMENT_MODE_BUILD` (`build`),
`ATTACHMENT_MODE_DRUPAL_SETTINGS` (`drupal_settings`).

## `hotjar.access` — `Drupal\hotjar\SnippetAccess`

`check(): bool` — returns whether the snippet should be output for the current request.
Combines (via `AccessResult::andIf`): account set, status not 403/404 (`statusCheckResult`),
path visibility (`pathCheckResult`), role visibility (`roleCheck`), cookie consent
(`cookieConstentCheck`), then every `hook_hotjar_access()` result and `hook_hotjar_access_alter()`.
Constants: `ACCESS_ALLOW = TRUE`, `ACCESS_DENY = FALSE`, `ACCESS_IGNORE = NULL`.

## `hotjar.snippet` — `Drupal\hotjar\SnippetBuilder`

| Method | Purpose |
|---|---|
| `pageAttachment(array &$attachments)` | attach the snippet; dispatches to build-mode or drupalSettings-mode by `attachment_mode`. |
| `buildSnippet(): string` | build the Hotjar activation JS (the `(function(h,o,t,j,a,r){…})` IIFE with `hjid`/`hjsv`); runs `hook_hotjar_snippet_alter()`; minifies if JS aggregation/advagg is on. Returns `// Empty HotjarID.` when no ID. |
| `createAssets(): bool` | write the snippet JS file to `snippet_path` (called from `hook_rebuild()` / `drush cr`). |

Build mode (`build`): adds an `html_head` `<script src="…snippet_path?query">` tag.
drupalSettings mode: sets `drupalSettings.hotjar.account` / `.snippetVersion` and attaches the
`hotjar/hotjar` library (`js/hotjar.js`), escaping the ID with `Html::escape()`.

## Verifying on a live site

```php
// does the current request get tracked?
\Drupal::service('hotjar.access')->check();
// what ID/settings are effective (after alters)?
\Drupal::service('hotjar.settings')->getSetting('account');
// force-rebuild the snippet file
\Drupal::service('hotjar.snippet')->createAssets();
```

There are **no Drush commands** and **no plugin types**; extension is via the hooks in
[../hooks/hooks.md](../hooks/hooks.md) or by decorating these services.
