<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & the `browser_development.settings` config object

## Form `Form\Settings` (route `browser_development.settings`, `/admin/browser-development/settings`)

A plain `FormBase` (form id `browser_development_settings`) — **not** a `ConfigFormBase`. It reads current values through `FormsStorage::getStorage()` (which returns `browser_development.settings`'s `form_arrays` value) and exposes these textfields:

- `base_path` — hard-pinned to `public://browser-development/`, `#attributes: readonly` (comment in source: kept read-only until inline services are refactored).
- `api_uri` — stored as `uri`; used by `Controller\Editor::templateVariables()` as `api_url`.
- `api_website` — stored as `website`.
- `api_key` — stored as `key`.
- `js` — stored as `js`; a JS-library path surfaced to the editor template as `js_library`.

`validateForm()` is empty. `submitForm()` calls `FormsStorage::setStorage('browser_development_settings', [...])` with the five values, then echoes the stored array back to the current user via `messenger()->addMessage(print_r(...))`.

## `FormsStorage`

Thin wrapper over the config factory:

- `setStorage($formName, $input)` → `config.factory` `getEditable('browser_development.settings')->set('form_arrays', [$formName => $input])->save()`.
- `getStorage()` → `\Drupal::config('browser_development.settings')->get('form_arrays')`.

So the whole settings payload lives at `browser_development.settings:form_arrays.browser_development_settings` (`base_path`, `uri`, `website`, `key`, `js`). Note `setStorage` overwrites the entire `form_arrays` key each save (single form supported).

## Config schema

There is **no** schema file for `browser_development.settings` (only `config/schema/browser_development_storage.schema.yml`, which types the `browser_development_storage.*` config entity). The settings object is written without a matching schema.

## `info.yml` `configure` link

The module does **not** declare a `configure:` route in `browser_development.info.yml`, so there is no "Configure" action on the Extend page; reach settings via the home page links or the direct path. `data.json` `configure` is `null` accordingly.
