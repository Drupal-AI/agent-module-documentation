# Libraries & theming

## The Select2 JS asset library

`select2.libraries.yml` defines:

- **`select2/select2`** — the module's `js/select2.js` behavior; depends on `select2/select2.min`
  and `core/sortable`. This is the library the render element attaches.
- **`select2/select2.min`** — the external vendored library: `/libraries/select2/dist/js/select2.min.js`
  + `/libraries/select2/dist/css/select2.min.css` (MIT, GPL-compatible). Depends on
  `core/drupal`, `core/jquery`, `core/once`. **The Select2 library (>=4.0.x) must be installed at
  `web/libraries/select2`** (via asset-packagist/npm-asset or a manual download) — it is not
  bundled with the module.

`select2.module` adjusts these paths at runtime:

- `hook_library_info_alter()` rewrites the min JS/CSS paths using
  `library.libraries_directory_file_finder` (so `libraries/` in a profile/site dir also works),
  and registers a `select2.i18n.<langcode>` library for every installed language that has an
  `i18n/<langcode>.js` file. It also registers the theme skin library (below).
- `hook_library_info_build()` similarly builds the i18n libraries.

## Per-theme Select2 skin — `select2.theme`

The render element automatically uses a Select2 "theme" matching the **active Drupal theme** if
that theme (or the select2 module) declares a `select2.theme` library. To ship a custom skin, add
to your theme's `*.libraries.yml`:

```yaml
select2.theme:
  css:
    component:
      css/my-select2-theme.css: {}
```

The module detects it via `library.discovery` and sets Select2's `theme` option to your theme's
machine name (otherwise `default`). Start from `select2/dist/css/select2.css`, copy the
`--default` rules, and rename `--default` to `--<your_theme_machine_name>`.

The module itself provides skins for the admin themes: `css/select2.claro.css`,
`css/select2.gin.css`, `css/select2.seven.css` (registered as `select2/select2.theme` for the
matching active theme via `hook_library_info_alter`).

## Select2 config emitted by the element

`preRenderSelect()` builds a `data-select2-config` attribute (JSON) with, among others:
`multiple`, `placeholder` (`- Select -` / `- None -` or `#placeholder` / `#empty_option`),
`allowClear` (single, non-required), `dir` + `language` (from current language),
`tags` (when `#autocreate`), `maximumSelectionLength` (from cardinality), `tokenSeparators`,
`selectOnClose`, and `width` (default `100%`). `#select2` overrides win — see extend/select2.md.
