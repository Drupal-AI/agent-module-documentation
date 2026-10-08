<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Builder UI (display_builder_ui) — agent index

Admin front-end for the [Display Builder](../../../1.x/agent/start.md) project. Depends on
`display_builder:display_builder`. Core `^11.3`. Package **User interface**. No config schema of
its own. Part of the `display_builder` project.

## What it provides (from source)

- **Routes** (`display_builder_ui.routing.yml`) under `/admin/structure/display-builder`:
  - `display_builder_profile` collection / add / edit / delete forms — permission
    `administer display builder profile`.
  - `pattern_preset` collection / add / edit / delete forms — permission
    `administer pattern preset` (path `…/preset`).
  - `display_builder_instance` collection (`…/instances`) — permission
    `view display builder instance`.
  - The profile/preset entity forms and route provider live in the base module
    (`ProfileForm`, `ProfileRouteProvider`); this module supplies the list builders and links.
- **Permissions** (`display_builder_ui.permissions.yml`): `administer display builder profile`,
  `administer pattern preset`, `view display builder instance`.
- **List builders / forms** (`src/`): `ProfileListBuilder`, `InstanceListBuilder` (the list
  builder referenced by the base module's Instance entity type), `PatternPresetListBuilder`,
  `Form/InstanceListFilterForm`. Hooks in `src/Hook/DisplayBuilderUiHooks.php`.
- **Links:** `*.links.menu.yml`, `*.links.task.yml`, `*.links.action.yml`.
- **Library:** `instance_list` (`css/instance-list.css`).

## Notes

- This is the module you enable to get any admin UI; the base module has no configure route.
- Profiles/presets are config entities — export them with the rest of your site config.
