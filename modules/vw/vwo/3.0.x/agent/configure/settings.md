<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VWO (Wingify) — configuration

Enable: `drush en vwo`. All settings live in the single config object **`vwo.settings`**
(`config/install/vwo.settings.yml`, schema `config/schema/vwo.schema.yml`). No content entities.

## Routes, menu, permission

Three routed config forms (`vwo.routing.yml`), all under `/admin/config/system/vwo` and all requiring
the **`administer wingify`** permission:

| Route | Path | Form class | Title |
|---|---|---|---|
| `vwo.settings` | `/admin/config/system/vwo` | `Form\Settings` | Wingify Setup |
| `vwo.settings.visibility` | `/admin/config/system/vwo/visibility` | `Form\Visibility` | Visibility |
| `vwo.settings.vwoid` | `/admin/config/system/vwo/vwoid` | `Form\ExtractID` | Extract Account ID |

`vwo.links.menu.yml` places the Settings link under `system.admin_config_system`; `vwo.links.task.yml`
adds the three as local tabs. `configure` in `vwo.info.yml` points at `vwo.settings`.

Note: the routes require `administer wingify`, but `vwo.permissions.yml` only declares
`administer vwo` ("Administer VWO"). The required permission is therefore not one this module defines,
so only user 1 / the superuser (who bypasses permission checks) reaches these forms out of the box
unless another module supplies `administer wingify`.

## Config keys (`vwo.settings`)

- `id` (int, nullable) — VWO/Wingify Account ID. **null = snippet is never added.** Default `null`.
- `is_wingify_account` (bool, nullable) — cached flag: is `id` a newer Wingify account? Fetched by
  `AccountInfo`; `null` means "not yet detected". Reset to `null` whenever `id` changes.
- `coll_url` (string, nullable) — collection URL cached from the account-info fetch (stored, not
  currently emitted to the page).
- `filter.enabled` (`'on'`/`'off'`) — master toggle for module-driven visibility processing.
  Default `'on'`. When `'off'`, `hook_page_attachments()` adds nothing unless another module flags it.
- `filter.userconfig` — `nocontrol` | `optout` | `optin`. Per-user opt-in/out (see api doc). Default `nocontrol`.
- `filter.nodetypes` (sequence of content-type machine names) — include only on these node pages.
- `filter.page.type` — `listexclude` | `listinclude` | `usephp`. Default `listexclude`.
- `filter.page.list` (string, nullable) — one Drupal path per line; `*` wildcard, `<front>` for front page.
- `filter.roles` (sequence of role machine names) — include only for users with any listed role.
- `loading.type` — `async` (default, recommended) | `sync`.
- `loading.timeout.settings` (int, ms) — async settings-tolerance (anti-flicker). Default `2000`
  (Settings form enforces min 2000, max 9999).
- `loading.timeout.library` (int, ms) — default `2500` (present in config/schema; not exposed in the form).
- `loading.usejquery` (string) — default `import` (present in config/schema; not exposed in the form).

Multiple filters combine as **boolean AND** — every set condition must pass for the code to be added.

![VWO Settings form](../../../../../../../screenshots/vwo/3.0.x/settings-form.png)

![VWO Visibility form](../../../../../../../screenshots/vwo/3.0.x/visibility-form.png)

## Form: Settings (`Form\Settings`, id `vwo_settings`)

`ConfigFormBase`; injects `vwo.help` and `vwo.account_info`. Fields → config map (see `submitForm`):
`id` → `id`, `synchtype` → `loading.type`, `asynctolsettings` → `loading.timeout.settings`.
The account ID field accepts the literal `NONE` to disable; `validateForm` requires `^\d+$` or `NONE`,
and `NONE` is translated to `null`. Changing the ID clears `coll_url` and `is_wingify_account`.
Renders promotional help blocks from `VwoHelp` and attaches the `vwo/admin` CSS library.

## Form: Visibility (`Form\Visibility`, id `vwo_settings_visibility`)

Sets `filter.enabled`, `filter.userconfig`, `filter.nodetypes`, `filter.page.type`, `filter.page.list`,
`filter.roles`. The `usephp` page mode is only offered when the core-contrib `php` module is enabled
**and** the current user has `use PHP for settings`; otherwise it is hidden/locked. Role labels are
`Html::escape()`d when building options.

## Form: Extract Account ID (`Form\ExtractID`, id `vwo_settings_vwoid`)

Paste a full Smart Code; `validateForm` regexes the numeric ID out of it (patterns for the
`/tag/<id>.js` or legacy `/lib/<id>.js` URL, the async `var account_id = <id>,`, or the legacy
`var _vis_opt_account_id = <id>;`), saves it to `id`, and redirects to `vwo.settings`.

## Drush / import

No Drush commands. Manage via core config: `drush cget vwo.settings`,
`drush cset vwo.settings id 123456`, or ship `vwo.settings.yml` in a config sync.
