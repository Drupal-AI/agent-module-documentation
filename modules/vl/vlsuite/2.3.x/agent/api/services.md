<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite — services, hooks, generator & extension points

VLSuite exposes helper services (no plugin managers, no public API interfaces), a few hooks, and a
Drush code generator. Nothing here is a stable programmatic API — treat method signatures as
current-version internals.

## Helper services (per foundational submodule)

| Service id | Class | Key ctor args |
|---|---|---|
| `vlsuite_utility_classes.helper` | `VLSuiteUtilityClassesHelper` | `@config.factory`, `@module_handler`, `@current_user` |
| `vlsuite_animations.helper` | `VLSuiteAnimationsHelper` | `@config.factory`, `@module_handler`, `@current_user` |
| `vlsuite_slider.helper` | `VLSuiteSliderHelper` | `@current_user` |
| `vlsuite_icon_font.helper` | `VLSuiteIconFontHelper` | `@config.factory` |
| `vlsuite_collection.helper` | `VLSuiteCollectionHelper` | `@extension.path.resolver`, `@entity_type.manager`, `@file_system`, `@file.repository` |
| `vlsuite_bundle_field.helper` | `VLSuiteBundleFieldHelper` | `@entity.definition_update_manager`, `@entity_type.manager` |

The `@current_user` in the utility/animations/slider helpers is how "Advanced" options are gated:
each helper checks the matching `use advanced vlsuite …` permission in its constructor and hides the
advanced utilities/animations/slider controls from users without it.

`VLSuiteUtilityClassesHelper` is the workhorse: `getUtilitiesMapClasses()`,
`checkUtilityApplyToValueIsValid()` (validates the apply_to route input),
`getUtilityKeyValueClasses()` (identifier→class resolution), `buildApplyUtilityClasses()` /
`buildLivePreviewer()` (merge classes and `data-vlsuite-…` preview attributes onto a render array),
and `getUtilitiesApplyToListFormElement()` (the "Appearance" form element).

`VLSuiteCollectionHelper` reads packaged preset YAML (`file_get_contents` on module-local paths)
and copies preset images into the files directory when a collection submodule installs — the paths
come from `extension.path.resolver`, not from request input.

## Modal services (`vlsuite_modal`)

More than a helper — modal rendering hooks several subsystems:
- `vlsuite_modal.theme_negotiator` (`VLSuiteModalThemeNegotiator`, priority 1004) — picks the theme
  for modal responses; ctor takes `@csrf_token`, `@config.factory`, `@request_stack`.
- `vlsuite_modal.route_subscriber` (event_subscriber) and
  `vlsuite_modal.library.discovery.collector` (decorates `library.discovery.collector`) — adjust
  libraries/routes for the modal context.
- `vlsuite_modal.vlsuite_modal_config_override` (tagged `config.factory.override`) — overrides
  config per request when rendering inside a modal.

## Hooks (parent `vlsuite.module`)

- `hook_help()` — renders `README.md` (via the `markdown` filter if present, else escaped `<pre>`).
- `hook_entity_view_alter()` — on a full-mode, Layout-Builder-enabled display, injects
  `vlsuite_full_content_top` (weight −99999) and `vlsuite_full_content_bottom` (weight 99999) view
  modes so a landing can have a fixed header/footer structure without per-node edits.

Submodule hooks of note: `vlsuite_bundle_field_entity_field_storage_info()` (bundle-field storages),
`vlsuite_block_remote_video_entity_bundle_info_alter()` (assigns the bundle class).

## Generator (`vlsuite_generator`, EXPERIMENTAL) — Drush CLI only

Provides a DrupalCodeGenerator generator, **not a web route and not a runtime API**. Run
`drush generate vlsuite-module` (alias `vlsuite-module`) — class
`VLSuiteGeneratorModuleGenerator` (`#[Generator(name: 'vlsuite-generator:module')]`,
`src/Drush/Generators/`). It interactively exports a chosen Section-Library template + its
components/config into a new custom module (uses `default_content` exporter and the process traits
`…ProcessTrait` / `…ProcessConfigTrait` / `…ProcessStylesTrait`, templates under
`templates/generator/_module/`). Depends on `vlsuite_block`, `vlsuite_layout`, `section_library`,
`default_content`. It scaffolds files on the developer's machine from installed site config; there
is no untrusted input path.

## Setup helpers (auto-uninstall)

- `vlsuite_shuttle` — enables the base suite (media, block, layout, layout_builder, utility_classes,
  icon_font, layout_tabs, headings_menu) for a customised install *without* demo entities, then
  auto-disables itself.
- `vlsuite_demo` — enables collections + landing content-editor and installs example content, then
  auto-disables itself. Intended for evaluation; remove its content before launch.
