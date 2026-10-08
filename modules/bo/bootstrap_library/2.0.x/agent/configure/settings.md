<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `bootstrap_library.settings`

Shipped defaults (`config/install/bootstrap_library.settings.yml`):

```yaml
url:
  visibility: '0'
  pages:
    - 'admin*'
    - 'imagebrowser*'
    - 'img_assist*'
    - 'imce*'
    - 'node/add/*'
    - 'node/*/edit'
    - 'print/*'
    - 'printpdf/*'
    - 'system/ajax'
    - 'system/ajax/*'
theme:
  visibility: true
  themes: ''
minimized:
  options: true
cdn:
  bootstrap: 0
files:
  types:
    js: true
    css: true
```

## Key reference

| Key | Values | Effect |
|---|---|---|
| `url.visibility` | `0` = all pages **except** those listed, `1` = **only** the listed pages | inverts the path match |
| `url.pages` | array of paths, one per line in the form (`_bootstrap_library_string_to_array()`); `*` wildcard, `<front>` supported by `path.matcher` | compared against both the internal path and the path alias, lowercased |
| `theme.visibility` | `0` = all themes except those listed, `1` = only the listed themes | inverts the theme match |
| `theme.themes` | array of theme machine names (select multiple on the form; `''` when unset) | `in_array($activeTheme, $themes)` |
| `minimized.options` | `0` source, `1` minified, `2` composer | picks `bootstrap-dev` / `bootstrap` / `bootstrap-composer` |
| `cdn.bootstrap` | `0` = load locally, otherwise a version string (`'5.2.3'`, `'4.6.0'`, `'3.3.7'`, …) | non-zero switches to `bootstrap-cdn` and **overrides** `minimized.options` |
| `cdn.options` | JSON blob of `{"bootstrap": {"<version>": {"css": "...", "js": [...]}}, "fontawesome": {…}}` | only written by the settings form (hidden field); required whenever `cdn.bootstrap` is non-zero |
| `files.types` | `{css: 'css'\|0, js: 'js'\|0}` | **saved but never read** by the attach logic — both files always load |

## Visibility logic (`bootstrap_library.module`)

```
attach if  !InstallerKernel::installationAttempted()
       and _bootstrap_library_check_theme()
       and _bootstrap_library_check_url()
```

* `_bootstrap_library_check_theme()` → `!(visibility XOR in_array(active_theme, themes))`.
  With the default `visibility: true` and an empty `themes`, this is FALSE — i.e. **out of
  the box nothing is attached until you pick themes or flip the setting**.
* `_bootstrap_library_check_url()` → matches the current path and its alias against
  `url.pages`; result inverted when `url.visibility == 0`.
* `?bootstrap=no` on the query string returns FALSE immediately for that request.

## Read / write with Drush

```bash
drush cget bootstrap_library.settings
drush cget bootstrap_library.settings minimized.options
```

```bash
# only load Bootstrap on /campaign and below, in the Olivero theme, non-minified
drush cset bootstrap_library.settings url.visibility 1 -y
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("url.pages", ["/campaign", "/campaign/*"])
    ->set("theme.visibility", 1)
    ->set("theme.themes", ["olivero" => "olivero"])
    ->set("minimized.options", 0)
    ->save();
'
drush cr
```

Back to the shipped defaults:

```bash
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("url.visibility", "0")
    ->set("url.pages", ["admin*","imagebrowser*","img_assist*","imce*","node/add/*","node/*/edit","print/*","printpdf/*","system/ajax","system/ajax/*"])
    ->set("theme.visibility", TRUE)
    ->set("theme.themes", "")
    ->set("minimized.options", TRUE)
    ->set("cdn.bootstrap", 0)
    ->save();
'
```

## The settings form

`/admin/config/development/bootstrap_library` (route `bootstrap_library.admin`, form
`Drupal\bootstrap_library\BootstrapLibrarySettingsForm`, requirement
`_permission: administer site configuration`). Fieldsets and the config key each writes:

| Form element | Config key |
|---|---|
| *Load Bootstrap from CDN* → `bootstrap` select | `cdn.bootstrap` (option `0` is labelled "Load locally") |
| hidden `cdn_options` | `cdn.options` |
| *Minimized …* radios `minimized_options` | `minimized.options` |
| *Themes Visibility* radios `theme_visibility` | `theme.visibility` |
| *List of themes* multi-select `theme_themes` | `theme.themes` |
| *Activate on specific URLs* radios `url_visibility` | `url.visibility` |
| *Pages* textarea `url_pages` | `url.pages` (split on newlines) |
| *Files Settings* checkboxes `types` | `files.types` |

> Setting `cdn.bootstrap` to a version **without** also setting `cdn.options` breaks
> `hook_library_info_build()` (it `json_decode()`s a NULL). Always write both, or use the
> form, which always posts the hidden blob.

## Config schema warning

`config/schema/bootstrap_library.schema.yml` declares
`bootstrap_library.settings` as a mapping but nests `visibility`/`pages`/`options`/… directly
under `theme`, `url`, `minimized`, `cdn` and `files` without an intermediate
`type: mapping` + `mapping:` level. The schema therefore does not describe the real config;
do not rely on typed-config validation for these keys.
