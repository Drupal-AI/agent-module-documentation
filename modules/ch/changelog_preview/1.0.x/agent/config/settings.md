<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Changelog Preview — configuration & operation

## Install / enable
```
composer require drupal/changelog_preview:^1.0
drush en changelog_preview
```
Composer pulls in `michelf/php-markdown` and `symfony/routing`. No other Drupal modules required.
No `config/install` or `config/schema` ships — the config object is created on first form save.

## Settings form
- Route: `changelog_preview.changelog_manage_form` → `/admin/changelog_manage`
  (requires core permission `administer site configuration`).
- Menu link: `changelog_preview.changelog_manage_form` under `system.admin_config_services`
  (Configuration › Web services).
- Class: `Drupal\changelog_preview\Form\ChangelogManageForm` (extends `ConfigFormBase`,
  form id `changelog_manage_form`).

The form renders a fieldset per "changelog item". Each item has three text fields:
- **Changelog file path** — path read from disk, prefixed at runtime with the Drupal root
  (`\Drupal::root()`), i.e. relative to the Drupal root directory.
- **Changelog name** — display title / tab label.
- **Changelog browser path** — the URL path the changelog page is served at (e.g. `/changelog/foo`).

"Add another changelog" (`::addField`, AJAX callback `::updateForm`) increments the item count and
rebuilds the form. `submitForm()` writes each field and the count.

## Config object: `changelog_preview.changelog_manage_form`
Editable via `getEditableConfigNames()`. Keys (indexed `<i>` from 0):
- `changelog_items_count` (int) — number of items.
- `changelog_file_path_<i>` (string) — root-relative file path.
- `changelog_name_<i>` (string) — display name.
- `changelog_browser_path_<i>` (string) — URL path.

Note there is no config schema, so these keys are untyped in Drupal's schema system.

## Operating
1. Grant `view changelog` to the roles that should see changelog pages (README explicitly notes it
   may be granted to anonymous). Manage config with `administer site configuration`.
2. Add an item with a valid root-relative Markdown path, a name, and a browser path.
3. Visit the browser path (dynamic route `changelog.<i>`) to view the rendered Markdown, or
   `/changelog/base` for the index of all items. A toolbar "Changelog" tab links to the index.

Set config from Drush instead of the UI, e.g.:
```
drush cset changelog_preview.changelog_manage_form changelog_items_count 1 -y
drush cset changelog_preview.changelog_manage_form changelog_file_path_0 /CHANGELOG.md -y
drush cset changelog_preview.changelog_manage_form changelog_name_0 'Changelog' -y
drush cset changelog_preview.changelog_manage_form changelog_browser_path_0 /changelog/main -y
drush cr   # rebuild routes/menu so the dynamic route registers
```
Dynamic routes and local tasks are derived from config, so clear caches after changing item paths.
