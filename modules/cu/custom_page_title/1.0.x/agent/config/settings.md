<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Page Title — settings, config object, and runtime matcher

## Install / enable

- `composer require drupal/custom_page_title` then `drush en custom_page_title -y`.
- No dependencies beyond Drupal core. Core requirement `^8.9 || ^9 || ^10 || ^11`.
- Uninstalling runs `custom_page_title_uninstall()` (`custom_page_title.install`), which deletes
  the `custom_page_title.settings` config object.

## The settings form

- Class: `Drupal\custom_page_title\Form\CustomPageTitleSettingsForm`
  (`src/Form/CustomPageTitleSettingsForm.php`), extends core `ConfigFormBase`.
- Route: `custom_page_title.custom_page_title_settings_form` →
  `/admin/config/custom-page-title/custom-page-title-settings`
  (`custom_page_title.routing.yml`). Requirement `_permission: 'administer site configuration'`,
  `options._admin_route: TRUE`.
- Menu link (`custom_page_title.links.menu.yml`): title "Custom Page Title", parent
  `system.admin_config_system` (Configuration → System), weight 100.
- Form id `custom_page_title_settings_form`; editable config
  `custom_page_title.settings` (`getEditableConfigNames()`).
- Dependencies injected via `create()`: `language_manager` (optional — only used if the container
  has it) and `module_handler`.

### Form structure

- `#type => table` `custom_page_table` with tabledrag weight ordering
  (group `custom_page_table-order-weight`). Rows are draggable.
- Per-row elements:
  - `status` — checkbox, whether the rule is active.
  - `pages` — required textarea; one path per line. Examples from the form help: `/node/1`,
    `/hello-world`, `/node/*`.
  - `title` — required textfield, `#maxlength => 60`, placeholder "Title".
  - `language` — `checkboxes` of installed languages; **only rendered** when
    `languageManager->isMultilingual()` OR core `language` module is installed.
  - `remove` — AJAX submit (`::removeElement` / `::removeCallback`) deleting that row.
  - `weight` — `#type => weight`, drives tabledrag order.
- `add_name` — AJAX submit "Add one more" (`::addOne` / `::addmoreCallback`) appending a blank row.
- `$form_state->setCached(FALSE)` is set so AJAX add/remove rebuild cleanly.

### Validation (`validateForm()`)

For each row, `pages` is split on `\r\n|\r|\n`. Per non-empty, trimmed line:
- must start with `/` (else "must start with a forward slash");
- lines containing `*` (wildcards) are skipped from further checks;
- duplicates within the same row are rejected;
- the line is resolved with `path_alias.manager->getPathByAlias($line, 'en')`, and if it resolves,
  `path.validator->isValid()` must pass (else "The page or alias does not exist").

### Submit (`submitForm()`)

Trims each row's `title`, then saves the full `custom_page_table` array to
`custom_page_title.settings` and calls `parent::submitForm()`.

## Config object

- Name: `custom_page_title.settings`. Key: `custom_page_table` = array of rows, each with
  `status`, `pages` (multiline string), `title`, `weight`, and (multilingual) `language`
  (array of langcode => langcode/0).
- **No `config/schema/` ships** — the object is schema-less (untyped config). No
  `config/install/` defaults either; the object exists only once the form is saved.

## Runtime override (`custom_page_title.module`)

`custom_page_title_preprocess_page_title(array &$page)`:
1. Loads `custom_page_title.settings`::`custom_page_table`; returns if empty.
2. Resolves current path via `path.current->getPath()`.
3. For each row with `status == 1`, builds a match condition:
   `path.matcher->matchPath($current_path, $row['pages'])` OR the same against
   `path_alias.manager->getAliasByPath($current_path)` — so both the internal path and its alias
   are tested, and `*` wildcards are honored.
4. If the site is multilingual or `language` is installed, the condition additionally requires the
   row's `language` set to be empty (all) or to include the current language id.
5. On a satisfied condition it sets `$page['title'] = $row['title']`.

Rows are iterated in array order (weight-sorted as stored); a later matching row overrides an
earlier one. The assigned title is a plain string rendered by core `page_title.html.twig`
(`{{ title }}`, Twig-autoescaped).

## Operating notes

- Order matters: put the most specific rule last if it must win, or rely on weights.
- A rule with an empty language set applies to every language on a multilingual site.
- Wildcard lines bypass the existence check, so `/node/*` is accepted without validating targets.
- Editing rules requires `administer site configuration`; there is no per-rule access control.
