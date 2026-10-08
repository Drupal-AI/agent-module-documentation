<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `file_link` theme override

Lets **themed file-field links** (core's *Generic file* formatter, theme hook `file_link`) carry
the same extension/size text + mime icon as the filter — with no text format involved.

## Wiring

- `src/Hook/ThemeHooks.php`, OOP hook `#[Hook('theme_registry_alter')]`
  (`themeRegistryAlter(array &$theme_registry)`), autowired service. Legacy bridge in
  `append_file_info.module` (`append_file_info_theme_registry_alter()` with `#[LegacyHook]`).
- It **replaces core's preprocessor** for `file_link`:
  - If `$theme_registry['file_link']['preprocess functions']` contains
    `template_preprocess_file_link`, that entry is swapped for
    `[ThemeHooks::class, 'preprocessFileLink']`.
  - Else (Drupal 11.3+ where the key may be absent, see change record 3504125) it sets
    `$theme_registry['file_link']['initial preprocess'] = static::class . ':preprocessFileLink'`.
- `hook_install()` (`append_file_info.install`) calls `theme.registry->reset()` so the override
  takes effect immediately on enable. **Clear caches** (`drush cr`) after enabling if links look
  unchanged.

## `preprocessFileLink(array &$variables)` (static)

Reimplements `template_preprocess_file_link` and appends the info:

1. Resolves the `file` entity (`$variables['file']`, or loads by `->fid`).
2. Builds an absolute URL with `file_url_generator->generateAbsoluteString($uri)` and adds the
   `url.site` cache context (multisite/HTTP-HTTPS correctness; core issue 2646744 noted inline).
3. Sets the microformat anchor attribute `type = "<mime>; length=<size>"`
   (http://microformats.org/wiki/file-format-examples).
4. Link text = the file description if set (and the filename becomes the `title` attribute), else
   the filename.
5. Adds mime CSS classes `file`, `file--mime-<icon>`, `file--<icon>`
   (`IconMimeTypes::getIconClass()`).
6. Reads `display` from **config object `append_file_info.settings`** (default `both`) and adds the
   cache tag `config:append_file_info.settings`.
7. Appends `append_file_info.file_info_formatter->getExtraLinkText($file, $display)` to the link
   text, then rebuilds `$variables['link'] = Link::fromTextAndUrl($link_text, Url::fromUri($url,
   $options))` — link text is escaped by core's Link rendering.

## Operating notes

- This path honors the **site-wide** `append_file_info.settings.display` (not a per-format
  setting); the filter honors its own per-format `display`. See
  [../config/settings.md](../config/settings.md).
- Applies wherever the `file_link` theme hook is used (e.g. a file field with the *Generic file*
  display formatter). It does not touch image-style or custom formatters.
- Because it swaps the single core preprocessor, another module that also overrides
  `file_link`'s preprocess list can conflict — check order if both are installed.
