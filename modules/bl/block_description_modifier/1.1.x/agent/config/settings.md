<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin UI, routes, permission & config storage

## Install / enable

`drush en block_description_modifier -y` then `drush cr`. Requires core `block_content` +
`layout_builder` and contrib `inline_entity_form` (all listed as `dependencies` in
`block_description_modifier.info.yml`). No settings needed to boot; behavior is off until you
configure a bundle.

## Permission

`block_description_modifier.permissions.yml` defines a single permission:
`administer block description modifier`. It is also the `admin_permission` of the `bdm_bundle`
config entity. All four routes require it — there is no anonymous or low-privilege surface.

## Routes (`block_description_modifier.routing.yml`)

| Route id | Path | Handler | Purpose |
|---|---|---|---|
| `...overview` | `/admin/config/content/block-description-modifier` | `OverviewController::build` | Lists all block_content types in two tables: **Selected inline blocks** and **Available blocks**. |
| `...configure` | `.../{bundle}` | `InlineBlockBundleConfigForm` | Configure the **inline** mode for a bundle. |
| `...configure_content` | `.../content/{bundle}` | `ContentBlockBundleConfigForm` | Configure the **content** mode for a bundle. |
| `...delete` | `.../{bundle}/delete` | `InlineBlockConfigDeleteForm` | Confirm-delete the inline config (`ConfirmFormBase`). |

A menu link (`system.admin_config_content` parent) and a local task tab point at the overview.
There is no `configure` key in info.yml, so the module page has no "Configure" button on
`/admin/modules`; reach it via the menu link.

## Overview page (`src/Controller/OverviewController.php`)

`build()` loads all `block_content_type` entities, sorts by label (`strnatcasecmp`), and asks
`BundleConfigRepository::allInline()` / `allContent()`. A bundle appears in **Selected inline
blocks** only when `inline_bundle.enabled` is true (with Edit/Delete operations); every bundle
appears in **Available blocks** with a *Configure* (content) and, when not already inline, a *Use as
inline block* operation. `summarizeInline()` / `summarizeContent()` describe the chosen strategy;
both build their strings with `t()` placeholders (`@v`, `@f`), so any stored string/field value is
auto-escaped in the table. Attaches the `block_description_modifier/admin` CSS library.

## The two config forms

Both extend `FormBase` (CSRF token protected) and share a shape:

- `enabled` checkbox.
- `provider` radios: `string`, `content_block_label`, and `field` — the `field` option is added
  **only if** `TextFieldOptionsProvider::getBlockContentTextFieldOptions($bundle)` returns eligible
  text fields.
- `string_value` textfield (`#maxlength 60`, shown when provider = string).
- `field_name` select (shown when provider = field).
- `validateForm()`: when enabled and provider=string, requires non-empty ≤ 60 chars; when
  provider=field, requires a selection.

`InlineBlockBundleConfigForm::submitForm()` → `repository->saveInline()` (or `deleteInline()` when
unchecked). `ContentBlockBundleConfigForm::submitForm()` → `repository->saveContent()` (passing
`enabled=false` when unchecked, which resets that section). Both redirect back to the overview and
add a status message. Unknown bundle → a plain message, no form.

`InlineBlockConfigDeleteForm` is a `ConfirmFormBase`; `submitForm()` calls `deleteInline()`.

## Storage: `bdm_bundle` config entity (`src/Entity/BundleConfig.php`)

`@ConfigEntityType(id="bdm_bundle", config_prefix="bundle")` → config names
`block_description_modifier.bundle.<bundle>`. `config_export`: `id`, `label`, `inline_bundle`,
`content_bundle`. Each of `inline_bundle` / `content_bundle` is `{enabled: bool, provider: string,
string_value: string, field_name: string}` (getters union-merge defaults so missing keys are safe).

### Repository semantics (`src/Repository/BundleConfigRepository.php`)

- `normalizeInline()` / `normalizeContent()`: if `enabled=false`, provider/string_value/field_name
  are forced to `''`; an empty provider defaults to `content_block_label`.
- `getInline($bundle)` returns the section **only if enabled**, else `NULL`. `getContent($bundle)`
  returns the normalized section **always** (even if disabled), or `NULL` if the entity is missing.
- `saveInline` / `saveContent` create the entity if absent (label defaults to the bundle id).
- `deleteInline` / `deleteContent` reset that section; **if the other section is also disabled the
  whole entity is deleted** so no orphan config file remains.

### Config schema (`config/schema/block_description_modifier.schema.yml`)

Defines `block_description_modifier.bundle.*` (the active model) plus the now-legacy
`block_description_modifier.settings` object (kept only so the pre-1.1.0 object still validates
before migration).

## 1.1.0 migration (`block_description_modifier.install`)

`block_description_modifier_update_11001()` reads legacy `block_description_modifier.settings`
(active storage, falling back to sync), maps `bundles` → inline and `content_bundles` → content
(tolerating legacy `hide_label` / `hide_info` flags), writes one `bdm_bundle` entity per bundle,
deletes the entity when both sections end up disabled, and finally deletes the legacy settings
object from active config. Run order per CHANGELOG: `drush updb -y` → `drush cr` → `drush cex -y`,
then remove `block_description_modifier.settings.yml` from `config/sync`.
