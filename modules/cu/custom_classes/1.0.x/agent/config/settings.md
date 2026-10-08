<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Classes — settings, rule format & mechanism

## Install / enable

- `drush en custom_classes -y`. Core `path_alias` (always present) is the only dependency.
- Grant **`administer custom_classes configuration`** (`custom_classes.permissions.yml`) to roles
  that may edit rules. Configure at **`/admin/config/system/custom-classes`**
  (route `custom_classes.settings_form`, menu *Configuration → System*).
- After editing rules, rebuild caches (`drush cr`) if the affected forms are cached, or changes
  may not appear.

## Config object

- **`custom_classes.settings`**, one key **`class_mappings`** (string; install default `''` from
  `config/install/custom_classes.settings.yml`). **No `config/schema/`** ships, so the key is
  untyped/opaque config. Export it with site config to move rules between environments.
- `SettingsForm` (`src/Form/SettingsForm.php`, `getEditableConfigNames()` →
  `['custom_classes.settings']`): a 20-row textarea (`class_mappings`) plus a read-only `details`
  "Preview" table rendering the parsed rows. `submitForm()` saves the raw textarea string verbatim.

## Rule format

The textarea holds newline-separated lines. Each line is a **6-field, `;`-delimited** record,
parsed by `CustomClassController::stringToCsv()` = `str_getcsv($line, ';', '\'')`:

```
route;url;form_id;$form["actions"]["submit"];class1 class2;class3 class4
```

| Idx | Field | Meaning | Wildcard |
|-----|-------|---------|----------|
| 0 | route | Exact route name to match | `*` or empty |
| 1 | url | Current URL/path glob (path-matcher) | `*` or empty |
| 2 | form_id | Form ID (`*` → regex `.*`, becomes `/^…$/Um`) | `*` or empty |
| 3 | path to element | `$form["a"]["b"]` render-array path | required |
| 4 | classes to add | space-separated | may be empty |
| 5 | classes to remove | space-separated | may be empty |

Shipped example patterns (from the form `#description`):

```
entity.commerce_product.canonical;*;*;$form["actions"]["submit"];cta;
*;*;node_article_form;$form["actions"]["submit"];;button--primary
*;/node/*/edit;*;$form["actions"]["preview"];preview-button;
```

**Validation** (`validateForm()`): every non-empty line must have **≥5 fields**, and each line must
specify at least one class to add **or** to remove (`INDEX_CLASSES`/`INDEX_CLASS_TO_REMOVE`),
else `setErrorByName` with the 1-based line number.

## How matching & rewriting works

`CustomClassController::getConfigValues()` normalizes each stored rule:

- Empty route/url/form-id → `*`. Form id gets `*`→`.*` then wrapped as `/^{id}$/Um`.
- **Element path** (`INDEX_PATH_TO_KEY`): `$form`, `"`, `[`, `]` are all replaced with `|`, then
  `preg_split('@\|@', …, PREG_SPLIT_NO_EMPTY)` yields the key list. This is **string parsing, not
  `eval()`** — the `$form[...]` text is only a convenient notation for a `NestedArray` key path.
- **Classes to add**: `Xss::filter()` then `Html::getClass()` per token (sanitized + normalized to
  valid CSS class names). Classes to remove are split on spaces but not re-sanitized (used only for
  `array_search` against the existing class list).

`customClassesFormAlter()` (called from `hook_form_alter`, forced to run **last** via
`hook_module_implements_alter`) iterates rules and `continue`s unless all apply:

- `checkRoute($route)` — exact `current_route_match->getRouteName() === $route` (no glob).
- `evaluate($path)` — `*`/empty short-circuits TRUE; otherwise lowercases and globs the current
  **internal** path with `path.matcher->matchPath()`. (Alias matching is present only as commented
  code, disabled for performance.)
- Form-id regex `preg_match` against `$form_id`.

For a matching rule it reads the target element via `NestedArray::keyExists/getValue`, ensures
`#attributes[class]` is an array, `array_merge`s the added classes, and writes back with
`NestedArray::setValue(..., TRUE)`.

## Class removal (deferred, trusted callback)

Removal can't happen in `form_alter` because the element's own process/pre-render haven't produced
the final class list yet. So for rules with classes-to-remove the controller:

1. sets `$element['#class_to_remove']`,
2. appends `[$this, 'processButton']` to `$element['#process']`.

`processButton()` (static) then appends `FormElementRemoveClasses::doRemoveClasses` to
`$element['#pre_render']` — done in `#process` (not directly in `form_alter`) so the button's
existing pre-render callbacks are not overwritten. `FormElementRemoveClasses`
(`src/FormElementRemoveClasses.php`) implements `TrustedCallbackInterface`
(`trustedCallbacks()` → `['doRemoveClasses']`); `doRemoveClasses()` `array_search`es each
`#class_to_remove` entry in `#attributes[class]` and `unset`s it, then removes the marker key.

## Operating notes

- **Removal is a last resort.** The README/`project_description` warns that stripping a class other
  code relies on (e.g. the Commerce Add-to-cart submit class) can trigger AJAX / `LogicException:
  The database connection is not serializable` errors. Prefer adding classes.
- Route matching is **exact**, path matching is **glob** — use the field that fits; combine route +
  path + form-id to scope a rule tightly.
- `hook_help()` for `help.page.custom_classes` renders `README.md`, using the `markdown` filter if
  the *markdown* module is enabled, otherwise wrapping it in `<pre>`.
