# Field-group formatters (plugins)

This module implements field_group's `FieldGroupFormatter` plugin type — it does **not** define a new
plugin type. Two formatters are provided; both declare `supported_contexts = {"form", "view"}`, so
they appear on both **Manage form display** and **Manage display**.

| Formatter id | Class (`src/Plugin/field_group/FieldGroupFormatter/`) | Role | Settings form |
|---|---|---|---|
| `ertta_tabs` | `Tabs.php` | Outer wrapper — renders its child groups as the tab set / accordion. | Yes (9 settings) |
| `ertta_tab` | `Tab.php` | One tab — its group label becomes a tab header, its fields the tab panel. | None (inherits the base label/id form) |

A working structure nests `ertta_tab` groups **inside** an `ertta_tabs` group. Each child tab's
`#title` (its group label, HTML-escaped) is collected into the navigation `<ul>`.

## `ertta_tabs` settings

Set on the parent group in the field_group formatter settings. Defaults come from
`Tabs::defaultContextSettings()`. `preRender()` (`Tabs.php:26`) copies each value onto the wrapper as
`data-<key>` and the init JS passes it straight to `easyResponsiveTabs()`.

| Setting key | Form field | Default | `data-*` attribute | JS option | Meaning |
|---|---|---|---|---|---|
| `type` | select: `default` (Horizontal) / `vertical` / `accordion` | `default` | `data-type` | `type` | Layout at wide width. |
| `width` | textfield | `auto` | `data-width` | `width` | `auto` or a custom width. |
| `fit` | select No/Yes | `TRUE` | `data-fit` (cast to bool) | `fit` | `100%` fit into container. |
| `closed` | select No/Yes | `FALSE` | `data-closed` (cast to bool) | `closed` | Start with panels closed. |
| `active_bg` | textfield | `''` | `data-activetab_bg` | `activetab_bg` | Active tab background colour. |
| `inactive_bg` | textfield | `''` | `data-inactive_bg` | `inactive_bg` | Inactive tab background colour. |
| `active_border_color` | textfield | `''` | `data-active_border_color` | `active_border_color` | Active tab-head border colour. |
| `active_content_border_color` | textfield | `''` | `data-active_content_border_color` | `active_content_border_color` | Active panel border colour. |
| `id` | textfield (validated by `field_group_validate_id`) | `''` | `data-identifier`, `data-tabidentify` | `tabidentify` | Explicit unique group id. Empty ⇒ id is `md5(<dash-joined classes>)`. |

`settingsSummary()` appends `Type: <type>` to the group summary.

Note: `ertta_tab` has no extra settings — `Tab::settingsForm()` returns the base form unchanged and
`Tab::defaultContextSettings()` adds nothing beyond `parent::defaultContextSettings()`.

## What `ertta_tabs::preRender()` produces (`Tabs.php`)

- `#type` / `#theme_wrappers` = `field_group_easy_responsive_tabs`; `#title` = escaped group label
  (`Html::escape`); `#id` = `Html::getId($id)` where `$id` is the `id` setting or `md5()` of the
  classes.
- Attaches libraries `field_group_easy_responsive_tabs/easy-responsive-tabs` and
  `…/easy-responsive-tabs-init`.
- `#is_child` = `TRUE` unless it is a top-level group (`#parents` empty / first parent `""`).
- Wrapper classes (`getClasses()`, `Tabs.php:213`): `field-group-easy-responsive-tabs`,
  `field-group-easy-responsive-tabs-<type>`, `field-group-<format_type>-wrapper`, plus the base
  field_group classes.

## Render / form elements (`src/Element/`)

Registered as `@FormElement` but extend `RenderElement`.

- `field_group_easy_responsive_tabs` (`Tabs.php`): `#process` = `Tabs::processTabs()`, which injects a
  child `#type => details` element (`$element['group']`) reusing `#parents` so core's details
  processing runs, and sets an invisible `Tabs` `#title` for accessibility when none is present.
- `field_group_easy_responsive_tab` (`Tab.php`): plain wrapper, `#theme_wrappers` =
  `field_group_easy_responsive_tab`.

## Theming (`field_group_easy_responsive_tabs.module`, `templates/`)

- `hook_theme` registers `field_group_easy_responsive_tabs` →
  `field-group-easy-responsive-tabs.html.twig` and `field_group_easy_responsive_tab` →
  `field-group-easy-responsive-tab.html.twig`, both with preprocessors in `templates/theme.inc`.
- `template_preprocess_field_group_easy_responsive_tabs()` builds `navigation` from each child whose
  `#type` is `field_group_easy_responsive_tab` (using its `#title`), and exposes
  `navigation_attributes` (`resp-tabs-list <id>`) and `container_attributes` (`resp-tabs-container
  <id>`). The tabs template renders `<ul class="resp-tabs-list …">` + a `resp-tabs-container` holding
  `children`.
- `hook_theme_suggestions_alter` adds suggestions for both hooks by `#wrapper_element`,
  `#entity_type`, `#bundle`, and `#group_name` (and combined `…__<entity_type>__<bundle|name>`
  forms), so themers can override per group/entity/bundle.

## JS init (`assets/js/field_group_easy_responsive_tabs.js`)

`Drupal.behaviors.FieldGroupEasyResponsiveTabsToAccordion` runs `once('field-group-easy-responsive-tabs',
'.field-group-easy-responsive-tabs', context)` and calls `easyResponsiveTabs()` with each option read
from the wrapper's `data-*` attributes (falling back to `null`). The plugin function
`easyResponsiveTabs` comes from the external `/libraries/easy-responsive-tabs/js/easyResponsiveTabs.js`.
