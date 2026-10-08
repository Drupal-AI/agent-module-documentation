<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dsfr_menu — import form, Menus service, routes & permissions

## Install / enable

Depends on `dsfr_core` (+ core `block`, `menu_link_content`, `text`). Enable with
`drush en dsfr_menu -y` (or `ddev drush en dsfr_menu -y`). `configure:` points at `dsfr_menu.import`.
No config objects are installed and no schema ships, so there is nothing to export beyond the menus,
menu links and blocks it creates as normal entities.

## Route & permission

- Route `dsfr_menu.import` (`dsfr_menu.routing.yml`): path `/admin/dsfr/import/menus`,
  `_form: \Drupal\dsfr_menu\Form\ImportmenusForm`, requirement `_permission: 'administer dsfr_menu settings'`.
- Permission `administer dsfr_menu settings` (`dsfr_menu.permissions.yml`) with `restrict access: false`.
  It is the only gate on the form; grant it only to trusted admins (it lets a user create menus and place blocks).
- Menu tab `dsfr_menu.admin_settings` (`dsfr_menu.links.menu.yml`), title "Menus import (DSFR)", parented to
  `dsfr_core.settings`.

## The `Menus` service (`dsfr_menu.config` → `src/Menus.php`)

`Menus extends ControllerBase` and is registered in `dsfr_menu.services.yml` as `dsfr_menu.config`. It is a
plain template/factory holder — **all menu content is hardcoded here**:

- `regionList()` — the 9 DSFR region machine names: `follow_social`, `footer_top_1..6`, `footer_menu_first`,
  `footer_menu_last`.
- `labelMenus()` / `description()` — human labels and descriptions for each of the 9 menus.
- `defaultItems()` — placeholder items `['Item 1', 'Item 2']` used for the footer-top columns.
- `socialItems()` — 15 social network names (Facebook, Twitter-X, Instagram, LinkedIn, YouTube, Mastodon,
  Slack, Telegram, TikTok, Dailymotion, GitHub, Snapchat, Twitch, Threads, Vimeo).
- `institutionalItems()` — 4 fixed `label`/`url` pairs to the official gouv.fr sites
  (legifrance.gouv.fr, service-public.fr, numerique.gouv.fr, data.gouv.fr).
- `lastItems()` — legal footer labels (Sitemap, Accessibility, Legal mention, Personal data, Cookies management).
- `createItems($items, $id, $internal)` — turns a template list into `menu_link_content` value arrays. When
  `$internal` is true the link `uri` is the placeholder `internal:#` and the title is the item string; when false
  each item is `['label' => ..., 'url' => ...]` and the `url` becomes the link `uri` (used only for the
  institutional menu's hardcoded gouv.fr URLs).
- `createMenu($id, $label, $desc, $items, $region, $is_region, $theme)` — STEP 1: if `Menu::load($id)` is null,
  creates the `menu` entity and saves each `MenuLinkContent`. STEP 2: if `$is_region == '1'`, and a block with id
  `{id-with-dashes-as-underscores}_{theme}` does not already exist, creates a `system_menu_block:{id}` block,
  sets its region and saves it (`status = true`). Returns a `$log` array (`import`, `already_menu`, `layout`,
  `already_block`). Existing menus/blocks are left untouched.
- `manageMenu($id, $label, $desc, $items, $region, $is_region, $theme = 'dsfr', $internal = true)` — convenience
  wrapper: `createItems()` then `createMenu()`.

## The import form (`ImportmenusForm`, `src/Form/ImportmenusForm.php`)

`FormBase`, form id `dsfr_menu_import`. It **does not import from any uploaded file or textarea** — the user only
chooses which shipped menus to create.

`buildForm()`:
- Reads `regionList()` and `labelMenus()` from `dsfr_menu.config`.
- Uses `dsfr_core.tools` (`checkTheme()`, `checkRegions()`) to find the current default theme and its regions;
  warns via `$tools->msg(...)` if the DSFR theme is missing or a region is absent.
- Builds a `checkboxes` element `options_menu`; a menu whose region is missing gets its label suffixed with `(*)`.
  Menus that already exist (looked up via `Menu::load()` on the cleaned id) are disabled via
  `#options_attributes` (from the `form_options_attributes` module).
- Two `hidden` fields carry state to submit: `theme` (`#value` = current theme) and `has_region` (a `/1`/`/0`
  string, one flag per menu, marking which regions exist).

`submitForm()`:
- Iterates the checked `options_menu` keys and calls `Menus::manageMenu(...)` per menu:
  key 1 = `social` (social items), keys 2–7 = `footer-top-1..6` (placeholder items, forced region `footer_top_N`),
  key 8 = `institutional` (gouv.fr items, `$internal = false`), key 9 = `footer-last-menu` (legal items).
- `$is_region` for each menu comes from `explode('/', $has_region)`, so a block is placed only where the theme
  declared the region.
- Aggregates the per-menu `$log` and reports imported/placed counts and already-existing menus/blocks with
  `$tools->msg()`. If nothing is checked it shows an error.

## Operating notes

- The form only **seeds** menus. Edit titles/URLs afterwards at Structure -> Menus; adjust placement at
  Structure -> Block layout. Placeholder footer/social/last links point at `internal:#` until you edit them.
- Re-running the form is safe: existing menus and blocks are detected and skipped, not overwritten.
- `submitForm()` uses `extract($form_state->getValues())` to pull `$options_menu`, `$has_region`, `$theme` into
  scope — a code smell, but the values are the form's own controlled fields and the route already requires the
  admin permission.
