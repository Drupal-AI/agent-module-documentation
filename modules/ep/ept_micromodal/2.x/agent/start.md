<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Micromodal (ept_micromodal) — agent index

Ships one Paragraphs bundle — **`ept_micromodal`** (label "EPT Micromodal") — that renders a trigger
(a link or a button) plus an accessible modal dialog powered by the **Micromodal.js** library. The
paragraph holds an optional page-level title (`field_ept_title`), the modal's header title
(`field_ept_micromodal_title`), the modal body (`field_ept_text`), and a settings field
(`field_ept_settings`) whose custom widget exposes the trigger/close text, trigger style
(link vs button), close-icon toggle, and a "disable scroll while open" option. On render the template
emits the `data-micromodal-trigger` / `.modal` markup keyed by the paragraph id, ept_core copies the
`ept_settings` array into `drupalSettings.eptMicromodal['paragraph-id-<id>'].options`, and
`js/ept-micromodal.js` calls `MicroModal.init({disableScroll: …})`. Everything is installed **config +
one template + one settings widget + one help hook** — there is no controller, route, service (other
than the hook class), permission, Drush command, config schema, or plugin type of its own; the shared
EPT **Design options** (margin/padding/border/background/container width) and the per-paragraph
`<style>` block come entirely from `ept_core`.

- Depends on: `ept_core:ept_core`, `paragraphs:paragraphs`. Composer also requires
  `levmyshkin/micromodal:^1.0` (the Micromodal JS placed at `/libraries/micromodal/dist/micromodal.min.js`).
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Paragraph Types`. Version `2.0.1`.
- No settings page / `configure` route. No permissions, no Drush, no config schema, no plugin types.
  No `hook_requirements` (installs on a minimal profile; no media type needed).
- Only hook implemented: `hook_help` (`help.page.ept_micromodal`). One template, registered via the
  Paragraphs bundle suggestion (no `theme_registry_alter`).

## What you'd do → where

- **The `ept_micromodal` bundle, its four fields, and the form/view displays** → [fields/paragraph-types.md](fields/paragraph-types.md)
- **The `ept_settings_micromodal` widget + every setting key + how `disable_scroll` reaches the JS** → [configure/settings.md](configure/settings.md)
- **The template, the button/modal markup, `{{ styles|raw }}`, the MicroModal init behavior, libraries** → [theme/rendering.md](theme/rendering.md)

## Key facts (real machine names)

- Paragraph bundle: `ept_micromodal` (`paragraphs.paragraphs_type.ept_micromodal`, label "EPT
  Micromodal"). Added directly to content via a Paragraphs field.
- Fields: `field_ept_title` (text_long, shared storage from ept_core — page-level heading),
  `field_ept_micromodal_title` (text_long, storage **ships in this module**, translatable — modal
  header title), `field_ept_text` (text_long, shared storage from ept_core — modal body),
  `field_ept_settings` (`ept_settings`, from ept_core — per-paragraph settings + design options).
- Settings widget: id **`ept_settings_micromodal`** →
  `Drupal\ept_micromodal\Plugin\Field\FieldWidget\EptSettingsMicromodalWidget` (field type
  `ept_settings`; extends ept_core `EptSettingsDefaultWidget`). Adds `button_text`, `button_type`
  (`link`/`button`), `close_button_text`, `disable_scroll`, `display_close_icon` under `ept_settings`.
- Hook service (autowired via `ept_micromodal.services.yml`):
  `Drupal\ept_micromodal\Hook\EptMicromodalHooks` — implements `hook_help()` only.
  `ept_micromodal.module` keeps a thin `#[LegacyHook]` wrapper.
- Install: `ept_micromodal.install` provides only `ept_micromodal_update_9001()` (backfills
  `display_close_icon = TRUE` on existing paragraphs). No `hook_install`/`hook_requirements`.
- Library: `ept_micromodal/ept_micromodal` — JS `/libraries/micromodal/dist/micromodal.min.js`
  (vendored external lib) + `js/ept-micromodal.js`; CSS (component) `css/ept-micromodal.css`;
  dependencies `core/drupal`, `core/once`, `core/drupalSettings`. JS behavior `eptMicromodal` reads
  `drupalSettings.eptMicromodal`.
- Template: `templates/paragraph--ept-micromodal--default.html.twig` (the `paragraph__ept_micromodal__default`
  bundle suggestion Paragraphs already provides — no registration hook).
