<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config

Form `src/Form/AdminLanguageSettingsForm.php` (extends `ConfigFormBase`), route
`admin_language_t_function_override.settings`.

## Route / access / menu

- Path: `/admin/config/regional/admin-language-t-function-override`
- Requirement: `_permission: 'administer site configuration'`
- Menu link (`*.links.menu.yml`): title "Admin Language Override Settings", parent
  `system.admin_config_regional`, weight 100.

## Config object: `admin_language_t_function_override.settings`

Editable name returned by `getEditableConfigNames()`. Keys (install defaults in
`config/install/admin_language_t_function_override.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | bool | `true` | Master switch; when false the decorator never overrides. |
| `force_english_paths` | list<string> | see below | Wildcard path patterns that trigger the override. |

Default `force_english_paths`:

```
/admin/*
/*/edit
/*/delete
/*/revisions
/*/layout
/*/translations
```

**No config schema file ships** (`config/schema/` absent), so these keys are untyped for
config-inspection/typed-config purposes.

## Form fields

- `enabled` — checkbox.
- `force_english_paths` — textarea; on build the stored array is joined with `\r\n`; on submit it is
  split with `preg_split('/[\r\n]+/', …, PREG_SPLIT_NO_EMPTY)` and each line `trim`-ed before saving.
  Visible only when `enabled` is checked (`#states`).
- `force_english_paths_help` — static markup describing the wildcard syntax (one pattern per line,
  `*` = wildcard) with examples.

## Pattern semantics

Each pattern is matched against the request path with `\*` replaced by `[^?]*` and anchored at start,
allowing an optional trailing `?query`. So `/*/edit` matches any single-prefix edit path
(`/fr-ca/node/1/edit`), and `/admin/*` matches everything under `/admin`. Any route already flagged
`_admin_route` is treated as matched even without a pattern.

## Operating

1. Enable module + core `language`.
2. Go to *Configuration → Regional and language → Admin Language Override Settings*.
3. Toggle `enabled`, edit the path list, save.
4. Optionally, each user sets their preferred admin language on their own user edit form; matched
   paths then render in that language (else English).
