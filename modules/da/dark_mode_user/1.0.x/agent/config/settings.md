<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dark Mode User — settings, per-user override, and mechanism

## Install / enable

`drush pm:install dark_mode_user`. No dependencies to add (declares none; uses core `user`). The module ships no theme CSS — it only sets attributes on `<html>`; the active theme is responsible for styling against them.

## Global default (config object `dark_mode_user.settings`)

- Form `SettingsForm` (`src/Form/SettingsForm.php`), route `dark_mode_user.settings` → `/admin/config/user-interface/dark-mode-user`, permission **`administer site configuration`** (`dark_mode_user.routing.yml`).
- Single field `system_default`: a required radios of `light` / `dark` / `system`. Saved to `dark_mode_user.settings:system_default`.
- Schema: `config/schema/dark_mode_user.schema.yml` → `system_default` is a `string`. Install default (`config/install/dark_mode_user.settings.yml`): `system_default: system`.
- This value is the mode for **anonymous users** and for any authenticated user who has not set (or set to "global") a personal preference.

Config export example:

```yaml
# dark_mode_user.settings.yml
system_default: dark
```

## Per-user override (stored in `user.data`, not a field)

Implemented in `DarkModeUserHooks`:

- `#[Hook('entity_extra_field_info_alter')]` `entityExtraFieldInfoAlter()` registers a pseudo-field `dark_mode_user` on the user form display (label "Dark Mode Toogle settings", weight 50).
- `#[Hook('form_user_form_alter')]` `formBaseFormIdAlter()` adds a `details` element **"Dark mode user settings"** with a required radios `dark_mode_user`: `light` / `dark` / `system` / **`global`** (= use the site default). Shown only when the **current** user is not anonymous **and** holds **`access dark mode user`** (`$this->currentUser->hasPermission('access dark mode user')`). Default value = stored `user.data` value or `'global'`. Appends `submitDarkModeUser` to the form submit handlers.
- `submitDarkModeUser()` writes the chosen value with `userData->set('dark_mode_user', $account->id(), 'dark_mode_user', …)`.

Note: the visibility/permission check is on `$this->currentUser`, so an admin editing another user's account sees the section based on the admin's own permission, and the value is saved against the edited account (`$account->id()`).

## How the mode reaches the page

- `#[Hook('page_attachments')]` `pageAttachments()` attaches library `dark_mode_user/dark-mode-user` on every page.
- `#[Hook('js_settings_alter')]` `jsSettingsAlter()` computes the effective mode into `drupalSettings.dark_mode_user`: it starts from config `system_default`, then — only if the current user is authenticated and has `access dark mode user` — overrides with the stored `user.data` value when it is set and not `'global'`.
- Library `dark-mode-user.anti-flicker` (`js/dark-mode-user.anti-flicker.js`, scope **header**, minified:false): reads `drupalSettings.dark_mode_user`. If `'system'`, it reads `window.matchMedia('(prefers-color-scheme: dark)')` and sets `data-dmu-mode` = `dark`/`light` with `data-dmu-source='system'`. Otherwise sets `data-dmu-mode` = the value with `data-dmu-source='user'`. Runs in the header to avoid a flash of the wrong theme.
- Library `dark-mode-user` (`js/dark-mode-user.js`, `Drupal.behaviors.darkModeUser`, deps `core/drupal`, `core/once`, and the anti-flicker lib): once per `html`, adds a `matchMedia` `change` listener that, while `data-dmu-source === 'system'`, updates `data-dmu-mode` live when the OS preference changes.

## Attributes a theme styles against

- `data-dmu-mode`: `light` or `dark`.
- `data-dmu-source`: `user` (explicit choice) or `system` (following OS).

Tailwind example (from README):

```css
@custom-variant dark (&:where([data-dmu-mode=dark], [data-dmu-mode=dark] *));
```

## What it does NOT provide

No entities, no field type/widget/formatter, no plugin types, no services, no Drush commands, no CSS. Only the one config object, one permission, one admin form, one hook class, and two JS libraries.
