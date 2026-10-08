<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Tabs Widget (paragraphs_tabs_widget) — agent index

A single **field widget** that renders each item of a multi-value Paragraphs field as a Drupal
core **vertical tab** in the entity edit form. Package `Paragraphs`. Core `^10.2 || ^11`. License
GPL-2.0-or-later. Version `2.x` (installed 2.0.0).

- **The widget, its settings, config schema, the permission, and the JS** →
  [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `ParagraphsTabWidgetVerticalTabs` (id **`paragraphs_tabs_widget_vertical_tabs`**,
  label *"Vertical tabs"*) in
  `src/Plugin/Field/FieldWidget/ParagraphsTabWidgetVerticalTabs.php`, **extending
  `Drupal\paragraphs\Plugin\Field\FieldWidget\InlineParagraphsWidget`**.
- `field_types = { "entity_reference_revisions" }` — targets Paragraphs reference fields. No
  formatter, no field type, no routes, no services, no hooks, no Drush.
- Changes only the **edit form** (Manage form display), not stored data or front-end display.

## Dependencies

- Module dep: **`paragraphs`** (`paragraphs:paragraphs (>=1.3)`), which supplies the parent widget.
- JS library `paragraphs_tabs_widget/vertical_tabs` depends on core `jquery`, `once`,
  `drupalSettings`, `drupal.vertical-tabs`.

## Provides

- **Plugin (widget)**: `paragraphs_tabs_widget_vertical_tabs` — see
  [fields/widget.md](fields/widget.md).
- **Permission**: `change paragraphs_tabs_widget summary_selector`
  (`paragraphs_tabs_widget.permissions.yml`, `restrict access: true`) — gates the "Tab summary
  selector" setting.
- **Config schema**: `field.widget.settings.paragraphs_tabs_widget_vertical_tabs`
  (`config/schema/paragraphs_tabs_widget.schema.yml`).
- **Library**: `vertical_tabs` (`paragraphs_tabs_widget.libraries.yml`,
  `js/paragraphs_tabs_widget_vertical_tabs.js`).

## Mechanism (from source)

- `formMultipleElements()` renders the base Paragraphs widget, then unsets `#theme`, sets
  `#type => 'vertical_tabs'`, and turns each numeric-delta child into a `#type => details` with a
  `#title` (the widget's `title` setting or *"Paragraph"*) and a `#group` so core's vertical-tabs
  JS collects them. It hides the duplicate paragraph-type title and the weight element, and
  rewrites the Remove/Confirm/Restore and Add-more AJAX `#ajax['wrapper']` to the field wrapper id.
- `defaultSettings()` adds `summary_selector` (`''`) and forces `edit_mode => 'open'`;
  `settingsForm()` hides `edit_mode` and exposes `summary_selector` **only** when the current user
  has the `change paragraphs_tabs_widget summary_selector` permission.
- `extractFormValues()` unsets the vertical-tabs `..__active_tab` value before delegating to the
  parent so the active-tab name is not mistaken for paragraph data.
- JS `Drupal.behaviors.paragraphs_tabs_widgetVerticalTabs` sets each tab's summary from the
  configured selector's element value, escaped via `Drupal.checkPlain()`, and moves the "Add more"
  button into the tab menu.
