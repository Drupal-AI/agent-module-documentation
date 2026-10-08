<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# autoshortqr — configuration, third-party settings, UTM & tokens

## Install / enable

`composer require drupal/autoshortqr` (pulls `drupal/barcodes ^2.1`, which needs the
`tecnickcom/tc-lib-barcode` PHP library) then `drush en autoshortqr`. No permissions are declared;
there is no dedicated admin/settings route (`configure` is null). You configure it per bundle.

## Where you enable it (form alters in `autoshortqr.module`)

The module injects a details group `autoshortqr` (**"Autocode"**, under `additional_settings`) into
four forms via `_autoshortqr_build_form()`:

| Form altered | Alter hook | Bundle carrier |
|---|---|---|
| Content type add/edit | `autoshortqr_form_node_type_form_alter` | `NodeType` config entity (real third-party settings) |
| Vocabulary add/edit | `autoshortqr_form_taxonomy_vocabulary_form_alter` | `Vocabulary` config entity |
| Account settings | `autoshortqr_form_user_admin_settings_alter` | `UserThirdpartyWrapper` (fake) |
| Redirect settings | `autoshortqr_form_redirect_settings_form_alter` | `RedirectThirdpartyWrapper` (fake) |

Node/term use core third-party settings on their bundle config entity (saved through
`$form['#entity_builders'][] = '_autoshortqr_form_type_form_builder'`). User/redirect have no bundle
config entity, so `UserThirdpartyWrapper` / `RedirectThirdpartyWrapper` (`src/*ThirdpartyWrapper.php`)
implement `ThirdPartySettingsInterface` over the config object **`autoshortqr.settings`** with a key
prefix (`user.` / `redirect.`). Their save is wired as an extra `#submit`
(`_autoshortqr_form_submit_user` / `_autoshortqr_form_submit_redirect`) and the wrapper `__destruct()`
calls `$this->config->save()`.

## Settings keys (per bundle, module namespace `autoshortqr`)

Set in `_autoshortqr_form_type_form_builder()` / `_autoshortqr_save_utm_parameters()`:

- **QR:** `qr_enable` (bool — adds the `autoshortqr` field + routes for that bundle),
  `qr_base_domain` (url; default = current scheme+host), `qr_show` (show QR on edit form, default
  TRUE), `qr_show_url` (show the QR link text on edit form, default FALSE),
  `qr_utm_{source,medium,campaign,content,term}` (textfields, token-aware).
- **Short:** `short_enable` (bool — adds `autoshortqr_short_link`), `short_base_domain` (url),
  `short_show_url` (default TRUE), `short_utm_{source,medium,campaign,content,term}`.

An empty base-domain is unset (not stored). The UTM keys come from `CodeController::UTM_VARS`
(`utm_source, utm_medium, utm_campaign, utm_content, utm_term`). The UTM sub-form shows a
`token_tree_link` for the entity's token type.

`getThirdPartySetting()` on the wrappers treats **empty as unset** (`empty($value) ? $default`), so a
UTM value of `'0'` is dropped. Saving any type clears cached entity-type definitions
(`clearCachedDefinitions()`), so the computed base fields appear/disappear immediately.

## Config object

Runtime config is **`autoshortqr.settings`** (flat keys like `user.qr_enable`, `redirect.short_utm_source`;
node/term keep theirs inside the bundle config entity's `third_party_settings.autoshortqr`).
There is **no `config/schema/`** (so `provides_config_schema` is false) and **no `config/install/`**.
The file `config/optional/iq_autocode.settings.yml` ships a `user:` / `redirect:` tree but its object
name (`iq_autocode.settings`) does not match the object the code reads — treat it as vestigial.

## Tokens (`autoshortqr_token_info` / `autoshortqr_tokens`)

Three tokens on `node`, `term`, `user` and (if the redirect module is installed) `redirect`:

- `[<type>:iqac_short_link]` → `entity.autoshortqr_short_link.uri` (only if `short_enable`).
- `[<type>:iqac_qr_link]` → `entity.autoshortqr.uri` (only if `qr_enable`).
- `[<type>:iqac_qr_download_link]` → `<qr_base_domain|current host>/autoshortqr/<prefix>/<base36 id>`.

`autoshortqr_tokens()` reloads the entity with `loadUnchanged()` before reading. Note the prefix used
for the node download token is `'tc'` (a source quirk shared with terms), while term uses `tc`,
user `uc`, redirect `rc`.
