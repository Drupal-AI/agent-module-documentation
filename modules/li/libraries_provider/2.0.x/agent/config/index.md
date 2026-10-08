<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Declaring and configuring a managed library

## 1. Declare it in `*.libraries.yml`

A module or theme opts a library into Libraries Provider by adding a `libraries_provider` key alongside the normal `css`/`js`/`version` keys. Example (Font Awesome 5 from jsDelivr):

```yaml
fontawesome:
  remote: https://github.com/FortAwesome/Font-Awesome
  version: 5.8.0
  css:
    base:
      https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.8.0/css/all.min.css:
        type: external
        minified: true
  libraries_provider:
    enabled: true
    source: cdn.jsdelivr.net
    npm_name: '@fortawesome/fontawesome-free'
```

The declared `css`/`js` URLs must match the `source` plugin so the module can normalise them (`getCanonicalPath()`) and re-emit them for whatever source the site later chooses.

### `libraries_provider` keys
- `enabled` (bool) — if false, the library's assets are voided when attached (`css` → `['base' => []]`, `js` → `[]`). Used to disable optional libraries or defer to a replacement.
- `source` (string) — default LibrarySource plugin id (`cdn.jsdelivr.net` or `local`, or one from another module).
- `npm_name` (string) — the npm package id; used to query jsDelivr versions and to build CDN/local paths. Defaults to the library key.
- `minified` — `always`, `never`, or `when_aggregating` (default). `when_aggregating` follows `system.performance`'s `css.preprocess`/`js.preprocess`.
- `blacklist_releases` (list) — versions to hide from the version selector (broken or insecure upstream builds).
- `variants_available` (list) — named variants `{name, description?, url?}`; combined with `variant_regex`.
- `variant_regex` — regex matching the path segment swapped when a variant is selected (`applyVariants()`).
- `variant` — default variant key.
- `replaces` (list of library-provider ids `ext__name`) — libraries this one supersedes; a replaced library is force-disabled and gains a dependency on the replacer. Useful for skins (Bulmaswatch, Bootswatch) that already bundle the base framework.
- `custom_options` — schema/process definition for user-overridable values (currently SASS variables). See below.

## 2. The `library` config entity

Site overrides are stored as config entities `libraries_provider.library.<extension>__<name>` (config prefix `library`, note the **double underscore** between extension and library name). Exported/importable fields (`config_export`): `id`, `label`, `enabled`, `version`, `source`, `minified`, `variant`, `replaces`, `custom_options`.

Schema: `config/schema/libraries_provider.schema.yml` (`libraries_provider.library.*`, type `config_entity`).

`Library::calculateDependencies()` adds a config dependency on the extension that declares the library and on the module providing the chosen source plugin. `Library::postSave()` clears the library-discovery cache so the alter runs again; `preDelete()` reverts custom-option side effects.

When no config entity exists for a managed library, its declared defaults are used as-is (the UI list synthesises an unsaved entity for display).

## 3. Custom options (SASS)

If a library declares `custom_options` with a `process: {sass: {source: [...]}}` block and a `schema` (JSON) path, admins can override upstream SASS variables. On save, `Library::applyCustomOptions()` builds the SASS source (imports + `name: value;` lines from the overrides), compiles it with `new \Sass()` (compressed), and writes the result to the library's first CSS `data` file path. Requirements enforced by `LibrariesProviderManager::getCustomOptionsRequirements()`: the referenced libraries must be present locally and use the `local` source, and any required PHP extension (e.g. `sass`/`sassphp`) must be loaded. Reverting (delete) rewrites defaults.

## 4. Tokens

`libraries_provider.tokens.inc` exposes token type `library` with `[library:version]` and `[library:variant]`, used e.g. inside custom-option SASS `source` paths.

## Notes
- Installing the module (`hook_install`) and saving/deleting a library all clear cached library definitions.
- The base module ships no configuration form; use the `libraries_provider_ui` submodule (see `submodules/`) or write config entities directly.
