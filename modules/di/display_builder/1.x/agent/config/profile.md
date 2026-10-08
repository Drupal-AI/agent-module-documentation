<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Profiles, islands, presets & config

## Install & enable

```bash
composer require drupal/display_builder
# enable the engine + the admin UI + the builder(s) you want
drush en display_builder display_builder_ui -y
drush en display_builder_entity_view display_builder_page_layout display_builder_views -y
drush cr
```

Requires Drupal **11.4+**, PHP **>=8.3** and **UI Patterns 2** (`drupal/ui_patterns:^2.0.21`);
info.yml pulls in `ui_patterns:ui_patterns_field` and `ui_patterns:ui_patterns_library`. For the
full design-system experience also install `ui_styles`, `ui_icons`, `ui_skins` (composer
`suggest`). The base module alone has no builder screen — a submodule must be enabled.

## Profile config entity (`display_builder_profile`)

`src/Entity/Profile.php`, config prefix `profile` (`display_builder.profile.<id>.*`),
`admin_permission: administer display builder profile`, `id` immutable. `config_export`: `id`,
`label`, `description`, `islands`, `library_flat`, `weight`. Managed at
**Structure → Display builder** (`display_builder_ui`), forms `ProfileForm` and per-island
`ProfileIslandPluginForm` (route `…/edit/{island_id}`), route provider `ProfileRouteProvider`.

A profile is essentially a keyed list of **islands**, each `{status, weight, …island-specific
keys}`. Schema `config/schema/display_builder.schema.yml`:

- `display_builder.islands` base: `status` (bool), `weight`.
- Typed island overrides add keys, e.g.:
  - `component_library`: `exclude` (by provider), `exclude_id`, `component_status`
    (experimental/deprecated/obsolete toggles), `include_no_ui`, `show` (grouped/…), `preview`.
    (`show_grouped`/`show_variants`/`show_mosaic` are deprecated → removed in 1.0.0-rc1, use `show`.)
  - `block_library`: `exclude` (providers), `exclude_id` (newline-separated block IDs), `show`,
    `preview`.
  - `preset_library`: `preview`.
  - `collaboration`: `image_field`, `image_style` (for presence avatars).
  - `viewport`: `exclude`.
  - `scaffold`: `components`.
  - `state`: `revert` (offer the Revert action).
- `library_flat` (bool) merges the library panels into one flat list.

The shipped **`default`** profile (`config/optional/display_builder.profile.default.yml`) enables
the common islands (component/block/preset libraries, builder, scaffold, preview, tree, history,
state+revert, styles, visibility conditions, menu, save status, viewport, highlight, help…) and
disables `theme`, `collaboration` and `tokens` by default. Its `block_library.exclude_id` shows a
real example of hiding admin/devel menu blocks and the clear-cache block.

## Permissions

- `administer display builder profile`, `administer pattern preset`, `view display builder
  instance` (defined in `display_builder_ui`).
- `administer page_layout` (display_builder_page_layout), `administer views` (Drupal, used by
  display_builder_views).
- **Dynamic, per profile** (`ProfilePermissions::permissions`): one
  *"Use the %label Display Builder profile"* permission per profile, each carrying an explicit
  *"may have security implications depending on how the display builder is configured"* warning.
  `ProfileAccessControlHandler` grants `view` on a profile to holders of that permission (or of
  the admin permission), which is what lets a user reach any instance using that profile.

## Pattern presets (`pattern_preset`)

Config entity `src/Entity/PatternPreset.php` (schema key `display_builder.pattern_preset.*`:
`id`, `label`, `description`, `group`, `weight`, `sources`). A preset stores a reusable UI Patterns
source sub-tree. Created from the builder via `ApiActionsController::saveAsPreset` (label taken
from the HTMX `hx-prompt` header, machine name derived and de-duplicated) or via the admin UI, and
attached back with `ApiController::attachPresetToRoot` / `attachPresetToSlot`.

## Text format

`config/optional/filter.format.display_builder_html.yml` installs a **`display_builder_html`**
filter format (restrictive `filter_html` allow-list incl. `<drupal-icon>`, plus htmlcorrector and
url filters) for rich-text sources used inside displays.

## Uninstall

`display_builder_uninstall()` deletes all `display_builder_instance` entities and clears plugin
caches. `display_builder_views` add/removes itself from `views.settings` `display_extenders` on
install/uninstall.
