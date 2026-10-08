<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Page Title (custom_page_title) — agent index

Overrides the rendered **page title** on admin-chosen paths. An admin fills a weighted table
of rules (path pattern → replacement title, with an enabled flag and optional per-language
scoping); a `hook_preprocess_page_title()` swaps `$page['title']` when the current path matches.
No dependencies beyond Drupal core. No package set in `.info.yml`. Core requirement
`^8.9 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

- **The settings form, the config object, the runtime matcher, and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- One admin form: `CustomPageTitleSettingsForm` (id `custom_page_title_settings_form`,
  `src/Form/CustomPageTitleSettingsForm.php`, extends core `ConfigFormBase`) at route
  `custom_page_title.custom_page_title_settings_form`
  (`/admin/config/custom-page-title/custom-page-title-settings`, permission
  **`administer site configuration`**, `_admin_route: TRUE`). Menu link under
  `system.admin_config_system` (Configuration → System), weight 100.
- One config object: **`custom_page_title.settings`**, key `custom_page_table` — an array of
  rule rows (`status`, `pages`, `title`, `weight`, and `language` on multilingual sites).
  **No config schema ships** (no `config/schema/`), so the object is schema-less.
- One runtime hook: `custom_page_title_preprocess_page_title()` in `custom_page_title.module`.
- `hook_uninstall()` (`custom_page_title.install`) deletes `custom_page_title.settings`.
- **No** permissions of its own, **no** services, entities, plugins, or Drush commands.

## Mechanism (from source)

- `custom_page_title_preprocess_page_title(array &$page)` loads `custom_page_table`; for each row
  with `status == 1` it matches the current path (`path.current`) and its alias
  (`path_alias.manager::getAliasByPath`) against the row's `pages` via `path.matcher::matchPath`
  (supports `/node/*` wildcards). On multilingual sites (or when core `language` is installed) the
  row also requires the current language to be in the row's `language` set (empty = all). On a
  match it sets `$page['title'] = $value['title']`. Rows are processed in array order, so a later
  match overrides an earlier one.
- Form: a `#type => table` with tabledrag weight ordering; Add-one and per-row Remove are AJAX
  callbacks (`addOne`/`removeElement`). Language column (`checkboxes`) only appears when
  multilingual/`language` present. `validateForm()` splits `pages` into lines and requires each
  non-wildcard line to start with `/`, be non-duplicate in the row, and resolve to a valid
  route/alias (`path.validator` + `path_alias.manager`). `submitForm()` trims each `title` and
  saves the whole table to `custom_page_title.settings`.

## Notes / caveats

- The `title` field is a plain textfield capped at `#maxlength => 60`; the runtime hook assigns it
  as a plain string to `$page['title']`, which the core `page_title.html.twig` template renders
  with Twig autoescaping. Only holders of `administer site configuration` can edit these rules.
- `CustomPageTitleSettingsForm::__construct()` has an unusual signature (a nullable
  `$language_manager` before a required `$module_handler`); `create()` passes both, so the form
  builds normally.
