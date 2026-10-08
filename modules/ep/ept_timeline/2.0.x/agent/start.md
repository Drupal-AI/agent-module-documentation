<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Timeline (ept_timeline) — agent index

Ships two Paragraphs bundles — **`ept_timeline`** (the wrapper: title, text, and a nested Paragraphs
field) and **`ept_timeline_item`** (one dated event: date, title, text, a "current" flag, and a
media image) — plus a settings widget and three Twig templates that render the events as a vertical
timeline. An editor adds the `ept_timeline` paragraph, adds `ept_timeline_item` children, fills a
date/title/text and optionally picks an image from the **media library**, and the module's templates
lay the events out down a central spine (see `css/simple_vertical/simple_vertical.css`). Everything
is installed **config + templates + one preprocess + one hook + one settings widget** — there is no
controller, route, service (other than the hook class), permission, Drush command, or config schema
of its own. The shared EPT design options (margin/padding/border/background/container width) and all
the `field_ept_settings`/`drupalSettings`/`{{ styles|raw }}` plumbing come from `ept_core`.

- Depends on: `ept_core:ept_core`, `paragraphs:paragraphs` (info.yml). Composer: `drupal/ept_core:^2.0`,
  `drupal/paragraphs:^1.0`. The item's media-image field also relies on the **`media`** /
  **`media_library`** core modules and an **`image`** media type, though info.yml does not list them.
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Paragraph Types`. Version `2.0.1`.
- No settings page / `configure` route. No permissions, no Drush, no plugin types, no config schema.
- **Install note:** `hook_requirements()` (`ept_timeline.install`) blocks install until an **`image`**
  media type (`MediaType` id `image`) exists — the item's `field_ept_timeline_media_image` config
  depends on `media.type.image`. Create one at `/admin/structure/media` first. This is also why the
  module could not be enabled in this environment without `ept_core` + an image media type present.

`EptSettingsTimelineWidget` extends `ept_core`'s `EptSettingsDefaultWidget` and **declares no
constructor** (source read), so it inherits the parent signature and carries no arity-mismatch risk
against the version of `ept_core` it is paired with — unlike its sibling `ept_cta` 2.0.1, which
overrides the constructor with a stale arity. Because the shared widget base class's signature has
changed between EPT releases and the individual modules do not constrain it, **pin the EPT modules
together** in composer.

## What you'd do → where

- **The two paragraph bundles, their fields, form/view displays** → [fields/paragraph-types.md](fields/paragraph-types.md)
- **The `ept_settings_timeline` widget (the `styles` selector) + how options reach ept_core/JS** → [configure/settings.md](configure/settings.md)
- **Templates, the module's `preprocess_paragraph`, the `theme_registry_alter` hook, `{{ styles|raw }}`, libraries** → [theme/rendering.md](theme/rendering.md)

## Key facts (real machine names)

- Paragraph bundles: `ept_timeline` (`paragraphs.paragraphs_type.ept_timeline`, label "EPT Timeline"),
  `ept_timeline_item` (`…ept_timeline_item`, label "EPT Timeline Event", description "Timeline section
  for EPT Timeline").
- Wrapper `ept_timeline` fields: `field_ept_title` (text_long), `field_ept_text` (text_long),
  `field_ept_timeline` (entity_reference_revisions → paragraph, cardinality **-1**, **required**,
  target bundle `ept_timeline_item`), `field_ept_settings` (`ept_settings`, from ept_core).
- Item `ept_timeline_item` fields: `field_ept_timeline_date` (string), `field_ept_timeline_title`
  (string), `field_ept_timeline_text` (text_long), `field_ept_timeline_current` (boolean,
  on/off labels `On`/`Off`), `field_ept_timeline_media_image` (entity_reference → media, `image`
  bundle, cardinality 1).
- Settings widget: id **`ept_settings_timeline`** →
  `Drupal\ept_timeline\Plugin\Field\FieldWidget\EptSettingsTimelineWidget` (field type `ept_settings`;
  extends ept_core `EptSettingsDefaultWidget`). Adds only a disabled `styles` radios (single option
  `simple_vertical`) + a hidden `pass_options_to_javascript`.
- Hooks: procedural `ept_timeline_preprocess_paragraph()` (in `ept_timeline.module`) builds the
  `media_image` file URL for `ept_timeline_item`; `ept_timeline_theme_registry_alter()` delegates to
  the autowired service `Drupal\ept_timeline\Hook\EptTimelineHooks::themeRegistryAlter()`
  (`#[LegacyHook]` wrapper).
- Registered theme hooks (via `themeRegistryAlter`): `paragraph__ept_timeline_item__default`,
  `field__paragraph__field_ept_timeline__ept_timeline`.
- Templates: `paragraph--ept-timeline--default.html.twig`,
  `paragraph--ept-timeline-item--default.html.twig`,
  `field--paragraph--field-ept-timeline--ept-timeline.html.twig`.
- Library: `ept_timeline/simple_vertical` (CSS only: `css/simple_vertical/simple_vertical.css`).
  (The wrapper template also calls a non-existent `ept_timeline/jquery_ui_timeline` — a dead
  reference; see [theme/rendering.md](theme/rendering.md).)
