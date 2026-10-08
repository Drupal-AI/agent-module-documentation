<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Vertical tabs" paragraphs widget

## Install & enable

```bash
composer require drupal/paragraphs_tabs_widget
drush en paragraphs_tabs_widget -y
```

Requires the **Paragraphs** module (`paragraphs` >= 1.3), which provides the parent
`InlineParagraphsWidget`. No sub-modules, no Drush commands, no configuration route.

## Enable it on a field

The widget (plugin id **`paragraphs_tabs_widget_vertical_tabs`**, label *"Vertical tabs"*) applies
to **`entity_reference_revisions`** fields — i.e. Paragraphs reference fields. It does not apply to
plain entity-reference or other field types.

UI path: *Structure → (bundle) → Manage form display* → set the Paragraphs field's widget to
**Vertical tabs** → click the gear to set the options below.

Drush / config equivalent (form display):

```bash
drush cset core.entity_form_display.node.page.default \
  content.field_paragraphs.type paragraphs_tabs_widget_vertical_tabs -y
drush cr
```

It is a drop-in replacement for the stock Paragraphs "Paragraphs (inline)" widget: stored data and
front-end display are unchanged; only the edit form becomes tabbed. Switch back at any time by
choosing another widget on the same screen.

## Settings

`defaultSettings()` in `ParagraphsTabWidgetVerticalTabs.php` adds one setting of its own and forces
one inherited default; everything else is inherited from the Paragraphs widget.

| Setting key | Default | Meaning |
|---|---|---|
| `summary_selector` | `''` | A **jQuery selector** for an element inside each tab whose `.value` becomes that tab's summary text (shown next to the tab). Empty = no summary. Exposed in the settings form only to users with the module's permission (see below). |
| `edit_mode` | `open` | Inherited from Paragraphs, but **forced to `open`** and its settings-form control is hidden (`#access = FALSE`) — collapsing a paragraph inside a tab would hide controls behind extra clicks. |

Inherited Paragraphs settings still apply and appear in `settingsSummary()`: `title`,
`title_plural`, `add_mode` (select list / buttons / dropdown), `form_display_mode`,
`default_paragraph_type`, plus `closed_mode`, `autocollapse`, `closed_mode_threshold`, `features`.
The tab label comes from the `title` setting (falls back to *"Paragraph"*).

Config schema: **`field.widget.settings.paragraphs_tabs_widget_vertical_tabs`** in
`config/schema/paragraphs_tabs_widget.schema.yml` — `summary_selector` (string, not translatable)
plus the inherited Paragraphs keys.

### Example form-display config

```yaml
# core.entity_form_display.node.page.default
content:
  field_paragraphs:
    type: paragraphs_tabs_widget_vertical_tabs
    settings:
      title: Section
      title_plural: Sections
      edit_mode: open
      add_mode: dropdown
      form_display_mode: default
      default_paragraph_type: ''
      summary_selector: 'input[name$="[subform][field_heading][0][value]"]'
```

## Permission

`paragraphs_tabs_widget.permissions.yml` defines one permission,
**`change paragraphs_tabs_widget summary_selector`** (`restrict access: true`). `settingsForm()`
sets the `summary_selector` field's `#access` to `$this->currentUser->hasPermission(...)`, so only
users granted this permission can see or change the selector on Manage form display. The selector is
evaluated by jQuery in the browser, so the module deliberately restricts who may set it — grant it
to trusted roles only.

## How the tabs are built (`formMultipleElements()`)

1. Calls `parent::formMultipleElements()` to render the normal inline-paragraphs widget, then
   derives a `#group` name from `#parents` + field name.
2. Attaches library `paragraphs_tabs_widget/vertical_tabs` and passes the `summary_selector` to
   `drupalSettings.paragraphs_tabs_widget_vertical_tabs[$group].summarySelector`. Wraps the widget
   in a `<div>` with a unique id (`Html::getUniqueId()`) and a
   `data-paragraphs-tabs-widget-group-wrapper` attribute (`Html::escape()`).
3. Unsets `#theme` and sets `#type => 'vertical_tabs'`.
4. For each numeric-delta child: `#type => details`, `#title` = `title` setting or *"Paragraph"*,
   `#group` = the group, and a `data-paragraph-tabs-widget-tab-group` attribute. Removes the
   per-item `#prefix`/`#suffix` (they would break core's vertical-tabs DOM requirement — details
   must be direct children of the panes element). Marks the paragraph-type title and the `_weight`
   element `#printed = TRUE` so they don't render inside the tab.
5. Rewrites the AJAX wrapper of the `remove_button`, `confirm_remove_button`, `restore_button` and
   every `add_more` button to the field wrapper id, and moves the add-more button (via
   `data-paragraphs-tabs-widget-addmore-group`) so JS can relocate it into the tab menu.

`addMoreAjax()` (static) strips the default `ajax-new-content` wrapper from the newest item and sets
`#default_tab` so a freshly-added paragraph opens as the active tab. `extractFormValues()` unsets
the `{parents}__{field}__active_tab` form value before delegating to the parent, so the active-tab
marker is never parsed as paragraph sub-form data — all real field access and value extraction stays
in the parent `InlineParagraphsWidget`.

## JavaScript (`js/paragraphs_tabs_widget_vertical_tabs.js`)

`Drupal.behaviors.paragraphs_tabs_widgetVerticalTabs`:

- For every `details[data-paragraph-tabs-widget-tab-group]`, calls `drupalSetSummary()`; when the
  group has a `summarySelector`, reads the first matching element's `.value` and returns it through
  **`Drupal.checkPlain()`** — so the summary text is HTML-escaped before display.
- Uses `once('paragraphs_tabs_widget-move-addmore-button', ...)` to move the add-more button into
  the `.vertical-tabs__menu`.

Library deps: `core/jquery`, `core/once`, `core/drupalSettings`, `core/drupal.vertical-tabs`.

## Gotchas

- Core's `vertical_tabs` render element is fragile: the tab `details` elements must be **direct
  children** of the panes element. A theme that wraps or moves them can stop the tabs from working
  (the README's Troubleshooting section covers this). The module removes item prefixes/suffixes to
  keep the DOM valid.
- The widget only affects **editing**. To render paragraphs as tabs on the front end you need a
  different, display-side solution (e.g. A11Y Paragraphs Tabs).
- The `summary_selector` is a client-side jQuery selector gated by the restricted permission; leave
  it empty unless you need per-tab summaries and only expose it to trusted editors.
