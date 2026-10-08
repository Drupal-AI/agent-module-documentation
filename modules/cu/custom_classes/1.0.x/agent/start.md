<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Classes (custom_classes) — agent index

Adds or removes CSS classes on form elements from admin config, matching by **route name**,
**URL/path**, and **form ID** — no custom `hook_form_alter()` needed. Package `Form`. Core
`^10 || ^11`. Depends on core **`path_alias`**. License GPL-2.0-or-later. Version 1.0.0-alpha1.
No config schema, no submodules, no Drush, no plugin types.

- **Settings form, the rule/config format, matching + add/remove mechanism, permission** →
  [config/settings.md](config/settings.md)

## What it actually is

- One settings form `SettingsForm` (`src/Form/SettingsForm.php`, form id `custom_classes_settings`)
  at route **`custom_classes.settings_form`** = `/admin/config/system/custom-classes`, gated by
  permission **`administer custom_classes configuration`**. Menu link under
  *Configuration → System* (`custom_classes.links.menu.yml`). It writes one config object
  **`custom_classes.settings`** with a single string key **`class_mappings`** (install default `''`).
- One service **`custom_classes.controller`** = `CustomClassController`
  (`src/Controller/CustomClassController.php`), injected with `path_alias.manager`,
  `path.matcher`, `request_stack`, `path.current`, `config.factory`, `current_route_match`.
- `custom_classes.module`: `hook_form_alter()` calls
  `$controller->customClassesFormAlter()`; `hook_module_implements_alter()` moves this module's
  `form_alter` to run **last**; `hook_help()` renders `README.md` (via the `markdown` filter if
  the *markdown* module is present, else `<pre>`).
- One trusted-callback class `FormElementRemoveClasses` (`src/FormElementRemoveClasses.php`,
  implements `TrustedCallbackInterface`) whose `doRemoveClasses()` `#pre_render` callback strips
  classes after the element's final class list is built.

## Rule format (the `class_mappings` string)

Newline-separated lines, each a `;`-delimited 6-field CSV (parsed by
`CustomClassController::stringToCsv()` with `str_getcsv($line, ';', '\'')`):

`route;url;form_id;$form["a"]["b"];classes-to-add;classes-to-remove`

Field index constants: `INDEX_ROUTE 0`, `INDEX_PATH 1`, `INDEX_FORM_ID 2`, `INDEX_PATH_TO_KEY 3`,
`INDEX_CLASSES 4`, `INDEX_CLASS_TO_REMOVE 5`. Empty/`*` = wildcard. Add/remove lists are
space-separated. Validation requires ≥5 fields per line and at least one of add/remove non-empty.

## Mechanism (from source)

- `getConfigValues()` parses each rule: form id `*` → regex `/^.*$/Um`; `$form["x"]["y"]` path
  → keys via `str_replace` of `$form`/`"`/`[`/`]` to `|` then `preg_split` (NOT `eval`);
  classes-to-add run through `Xss::filter()` then `Html::getClass()`.
- `customClassesFormAlter()` skips a rule unless `checkRoute()` (exact `getRouteName()` compare),
  `evaluate()` (`path.matcher` glob on the current internal path), and the form-id regex all
  match. It merges added classes onto `NestedArray::getValue($form, path)["#attributes"]["class"]`.
- Removal: sets `#class_to_remove` and appends `[$this,'processButton']` to `#process`; that
  process callback appends `FormElementRemoveClasses::doRemoveClasses` to `#pre_render`
  (workaround so button pre-render methods are not overwritten).

Details, examples and operating notes → [config/settings.md](config/settings.md).
