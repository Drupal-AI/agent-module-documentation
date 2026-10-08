# Theming the tabs: theme hook + `hook_preprocess_views_view_attachment_tabs()`

This module builds the tab **data structure** but ships no CSS/JS and only semantic base markup. To
make working tabs you either enable a bundled submodule or implement the preprocess hook for your
theme. This is the module's real extension point.

## Theme hook and template

- Hook: `views_view_attachment_tabs`, declared by `views_attachment_tabs_theme()` with
  `'base hook' => 'views_view'` (so it inherits `template_preprocess_views_view` variables).
- Template: `templates/views-view-attachment-tabs.html.twig`. It renders, when `tab_panels` is
  non-empty: an optional `<nav{{ tab_nav_tag_attributes }}>` wrapper (only if `wrap_tab_navigations`),
  a `<ul{{ tab_navigations_attributes }}>` of `<li{{ tab_navigation.wrapper_attributes }}>` buttons,
  and a `<div{{ tab_panels_attributes }}>` of `<section{{ tab_panel.wrapper_attributes }}>` panels.
- Suggestions (`views_attachment_tabs_theme_suggestions_views_view`): a `views_view` render is
  switched to this hook **only** when the display `usesAttachments()` **and** its
  `views_attachment_tabs_extender` is enabled. Suggestions added, most specific last:
  `views_view_attachment_tabs`, `views_view_attachment_tabs__{view_id}`,
  `views_view_attachment_tabs__{view_id}__{current_display}`.

## What the module's own preprocess produces

`views_attachment_tabs_preprocess_views_view_attachment_tabs(&$variables)` assembles, for the main
display plus every enabled attachment (pulling each attachment out of `attachment_before` /
`attachment_after` so it is not also rendered stacked), a `$tabs` array keyed by display id, sorts it
by `weight` (`SortArray::sortByWeightElement`), skips any tab with empty content or title, then sets:

| Variable | Type | Meaning |
|---|---|---|
| `wrap_tab_navigations` | bool | Wrap the `<ul>` in a `<nav>`? Default `FALSE`. |
| `tab_nav_tag_attributes` | `Attribute` | Attributes for that `<nav>` (default `role="navigation"`). |
| `tab_navigations` | array | One entry per tab button (see below). |
| `tab_navigations_attributes` | `Attribute` | Attributes for the `<ul>` (default `role="tablist"`). |
| `tab_panels` | array | One entry per panel, index-aligned with `tab_navigations`. |
| `tab_panels_attributes` | `Attribute` | Attributes for the panels `<div>` (default `role="tabpanels"`). |

Each `tab_navigations[i]` has: `display_id`, `unique_id`
(`Html::getUniqueId('views-view-{view_id}--{display_id}')`), `is_main_view`, `is_first_tab`,
`wrapper_attributes` (`Attribute` for the `<li>`), and `content` — a `#type => html_tag`,
`#tag => button` render array whose `#value` is the tab title and whose `#attributes` include
`role="tab"`, `type="button"`, and
`data-views-attachment-tabs='{"view_id":…,"display_id":…,"is_main_view":"true|false"}'` (JSON hook
for JS). Each `tab_panels[i]` has: `display_id`, `content` (the rendered view/attachment),
`is_main_view`, `is_first_panel`, and `wrapper_attributes` (`Attribute` for the `<section>`,
default `role="tabpanel"`).

## Writing your own preprocess

Signature (documented in `views_attachment_tabs.api.php`):

```php
function hook_preprocess_views_view_attachment_tabs(array &$variables) {
  // Add classes/attributes to the wrappers…
  $variables['tab_navigations_attributes']['class'][] = 'my-tabs';
  $variables['tab_panels_attributes']['class'][] = 'my-panels';

  // …and to each tab button / panel (arrays are index-aligned).
  foreach ($variables['tab_navigations'] as $i => &$nav) {
    $nav['wrapper_attributes']['class'][] = 'my-tab';
    $nav['content']['#attributes']['class'][] = 'my-tab-link';
    // $nav['unique_id'], $nav['is_first_tab'], $nav['is_main_view'] are available.
    $variables['tab_panels'][$i]['wrapper_attributes']['class'][] = 'my-panel';
    if (empty($nav['is_first_tab'])) {
      $variables['tab_panels'][$i]['wrapper_attributes']['hidden'] = TRUE;
    }
  }
  // Attach your own JS/CSS:
  $variables['#attached']['library'][] = 'my_theme/my_tabs';
}
```

Multiple implementations stack; the module's own preprocess runs first, then submodule/theme
implementations layer classes on top. The `.api.php` example shows an Alpine.js/Tailwind variant with
full keyboard (`@keydown.right/left/home/end`) wiring.

## Bundled reference implementations

- **`views_attachment_tabs_bootstrap`** (`views_attachment_tabs_bootstrap_preprocess_views_view_attachment_tabs`):
  adds `nav nav-tabs mb-3` to the tablist and `tab-content` to the panels; per tab sets
  `nav-item`/`nav-link`, an id, `data-toggle`/`data-bs-toggle = tab`,
  `data-target`/`data-bs-target = #panel`, `role`/`aria-controls`, and marks the first tab/panel
  `active`/`show`. Bootstrap 4 & 5 attribute names both emitted; relies on Bootstrap's own JS.
- **`views_attachment_tabs_olivero`** (`views_attachment_tabs_olivero_preprocess_views_view_attachment_tabs`):
  guarded by `_views_attachment_tabs_olivero_theme_is_activated()` (active theme is `olivero` or has
  it as a base theme). Sets `wrap_tab_navigations = TRUE`, marks the nav with
  `data-drupal-nav-primary-tabs`, adds `tabs tabs--primary` classes, ids/`aria-controls`/
  `aria-labelledby`, `hidden` on non-first panels, an `is-active` first tab, and injects an extra
  mobile trigger button. Attaches `views_attachment_tabs_olivero/tabs`
  (`Drupal.behaviors.viewsAttachmentTabsOlivero` in `js/tabs.js`, using `once()` on
  `[data-views-attachment-tabs]`; library depends on `core/drupal`, `core/once`, `olivero/tabs`).

## Accessibility note (verify when integrating)

The base markup carries `role="tablist"`/`role="tab"`/`role="tabpanel"`, but a complete,
accessible tab set also needs `aria-selected`, `aria-controls`/`aria-labelledby`, arrow-key
navigation between tabs, and only the active panel exposed — those are added by the theme layer
(the Olivero JS/Bootstrap handle activation; a custom preprocess must supply them). All tab panels
are rendered into the DOM up front (not lazy-loaded), so inactive-tab content still costs query
time and is findable by in-page search.
