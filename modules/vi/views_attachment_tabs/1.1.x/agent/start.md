<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Attachments as Tabs (views_attachment_tabs) — agent index

Turns a Views display and its **attachment displays** into a **tabbed panel** instead of a stacked
main-view-plus-attachments layout. The mechanism is a **Views display extender plugin**
(`views_attachment_tabs_extender`, class `TabsExtender`) that adds an *Enabled / Tab title / Tab
weight / tokenize* option group to any display that uses attachments and to each attachment display.
When a parent display has the extender enabled, the module supplies a dedicated theme hook
(`views_view_attachment_tabs`) with template suggestions, and its own preprocess
(`views_attachment_tabs_preprocess_views_view_attachment_tabs`) collects the main view plus each
enabled attachment into ordered `tab_navigations` (button render arrays with `role="tab"`) and
`tab_panels` (the rendered content, `role="tabpanel"`), sorted by tab weight. The base template emits
semantic `<ul role="tablist">` / `<section role="tabpanel">` markup but ships **no CSS/JS of its own** —
theme integration is the extension point: enable a submodule or implement
`hook_preprocess_views_view_attachment_tabs()` to add the classes/attributes/behavior your theme's tab
component needs.

- Depends on: core `views` (`drupal:views`). No other dependencies.
- Core: `^9 || ^10 || ^11`. Package: `Views`. Version `1.1.2`.
- No settings page / `configure` route, no permissions, no services, no routes, no drush. Provides
  config schema. Defines **no new plugin type** — it registers a plugin *of* the core Views
  `display_extender` type.
- Submodules (both disabled by default; enable the one matching your theme):
  - `views_attachment_tabs_bootstrap` — preprocess that adds Bootstrap 4/5 `nav nav-tabs` /
    `tab-content` markup (`data-toggle`/`data-bs-toggle`, `data-target`/`data-bs-target`); pure
    theming, no JS shipped (relies on Bootstrap's own tab JS).
  - `views_attachment_tabs_olivero` — preprocess + JS for core's Olivero theme; only acts when the
    active theme is `olivero` or has it as a base theme. Attaches library
    `views_attachment_tabs_olivero/tabs` (`Drupal.behaviors.viewsAttachmentTabsOlivero`, depends on
    `core/drupal`, `core/once`, `olivero/tabs`) and renders Olivero `tabs`/`tabs--primary` markup
    with a mobile trigger button.

## What you'd do → where

- **Enable the extender and configure a view's tabs (options, config keys, where it's stored)** →
  [configure/tabs.md](configure/tabs.md)
- **Understand/extend the display extender plugin (options, form section, methods)** →
  [plugins/display-extender.md](plugins/display-extender.md)
- **Theme the tabs / write a preprocess for a custom theme (theme hook, template variables, tab
  render arrays)** → [hooks/preprocess.md](hooks/preprocess.md)

## Key facts (real machine names)

- Display extender plugin id: `views_attachment_tabs_extender`
  (`src/Plugin/views/display_extender/TabsExtender.php`, `@ViewsDisplayExtender`, `no_ui = FALSE`).
- Extender options: `enabled` (bool, default `FALSE`), `title` (string, default `''`),
  `weight` (int, default `0`, min −100 / max 100), `tokenize` (bool, default `FALSE`).
- Options-form section machine name: `views_attachment_tabs` (checked via
  `$form_state->get('section')`).
- Extender methods: `isEnabled()`, `getTabTitle()`, `getTabWeight()`, `tokenizeValue($value)`,
  plus `buildOptionsForm()` / `submitOptionsForm()` / `optionsSummary()` / `tokenForm()`.
- Theme hook: `views_view_attachment_tabs` (`base hook` = `views_view`); template
  `templates/views-view-attachment-tabs.html.twig`.
- Theme suggestions (`views_attachment_tabs_theme_suggestions_views_view`):
  `views_view_attachment_tabs`, `…__{view_id}`, `…__{view_id}__{current_display}`.
- Own preprocess: `views_attachment_tabs_preprocess_views_view_attachment_tabs`.
- Documented API hook: `hook_preprocess_views_view_attachment_tabs(&$variables)`
  (`views_attachment_tabs.api.php`).
- Template variables added: `tab_navigations`, `tab_navigations_attributes`, `tab_panels`,
  `tab_panels_attributes`, `wrap_tab_navigations`, `tab_nav_tag_attributes`.
- Config schema type: `views.display_extender.views_attachment_tabs_extender`
  (`config/schema/views_attachment_tabs.views.schema.yml`). Per-display options are stored at
  `display_options.display_extenders.views_attachment_tabs_extender` in the view config.
- Registration: the extender id must appear in `views.settings:display_extenders`
  (see configure/tabs.md — the module's install hook that was meant to add it does not fire).
