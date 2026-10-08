<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles Paragraphs (ui_styles_paragraphs) — agent index

Bridges **UI Styles** with **Paragraphs**: it ships a single Paragraphs *behavior* plugin
(`ui_style_options`) that (1) lets a site builder pick, per paragraph type, which UI Styles a
contributor may apply, and (2) lets the contributor choose values from those styles on the
paragraph add/edit form, then applies the chosen CSS classes to the rendered paragraph. The styles
themselves are declared by the **theme/module** in UI Styles' YAML — this module contributes no
styles and no classes of its own; if the picker is empty, UI Styles has none enabled.

The whole module is one class: `src/Plugin/paragraphs/Behavior/UIStyleOptions.php`
(`extends ParagraphsBehaviorBase`). It reads UI Styles definitions from the
`plugin.manager.ui_styles` service, builds select/checkbox form elements from them, stores the
selection in the paragraph type's behavior configuration (`enabled_styles`) and in each paragraph's
behavior settings, and in `view()` appends the resulting classes to the paragraph render array's
`#attributes['class']`.

- Depends on: `ui_styles:ui_styles`, `paragraphs:paragraphs` (both hard deps).
- Core: `^9 || ^10 || ^11`. Package: none declared (info.yml has no `package`).
- **No** dedicated settings page / `configure` route, **no** routes, **no** services.yml, **no**
  permissions, **no** `.install`/`.module`, **no** config schema, **no** hooks, **no** drush, **no**
  templates/JS/CSS. Configuration lives entirely inside the Paragraphs behavior UI.
- Defines **no** plugin type; it provides one plugin *of* Paragraphs' existing `ParagraphsBehavior`
  type.
- **Release is 1.1.0-alpha2 — alpha.** (Runtime-verified enabled: ui_styles_paragraphs
  1.1.0-alpha2 with ui_styles 8.x-1.21, paragraphs 8.x-1.23, Drupal 11.x.)

## What you'd do → where

- **Enable it on a paragraph type, choose which styles editors may use, understand where the choice
  is stored, or how classes reach the markup** → [plugins/behavior.md](plugins/behavior.md)

## Key facts (real machine names)

- Plugin: `ParagraphsBehavior` id **`ui_style_options`**, label "UI Style Options", class
  `Drupal\ui_styles_paragraphs\Plugin\paragraphs\Behavior\UIStyleOptions`, weight `0`.
- Config key (paragraph-type behavior settings): **`enabled_styles`** — nested by style *category*
  group key, `defaultConfiguration()` = `['enabled_styles' => []]`.
- Per-paragraph behavior form elements: `#type => 'select'` named **`ui_styles_<styleId>`**, options
  from the UI Style definition's `getOptionsAsOptions()`, plus a `- None -` empty option.
- Constant: `UIStyleOptions::MULTIPLE_GROUPS_KEY = 'ui_styles_groups'` (form-state flag).
- Injected services: `plugin.manager.ui_styles` (`StylePluginManager`), `entity_field.manager`,
  `transliteration`.
- Key methods: `buildConfigurationForm()`, `submitConfigurationForm()`, `buildBehaviorForm()`,
  `view()`, `getEnabledStyles()`, `getFlattenedSettings()`, `getMachineName()`,
  `defaultConfiguration()`.
