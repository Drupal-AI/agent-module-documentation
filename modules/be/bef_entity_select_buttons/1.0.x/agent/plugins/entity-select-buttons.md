<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "BEF entity select buttons" filter widget

## Install & enable

```bash
composer require drupal/bef_entity_select_buttons
drush en bef_entity_select_buttons -y
```

Hard dependency: **`better_exposed_filters`** (`bef_entity_select_buttons.info.yml`). No submodules,
no permissions, no Drush, no config schema of its own.

## Select the widget on a Views exposed filter

The plugin `EntitySelectButtons` (id **`bef_entity_select_buttons`**, label *"BEF entity select
buttons"*) is a BEF filter-widget (`@BetterExposedFiltersFilterWidget` annotation), so it only shows
up where BEF does:

1. Edit a View → set a filter to **Exposed**.
2. In the View's **Advanced → Exposed form → Settings** (Better Exposed Filters format), find that
   filter and choose widget **"BEF entity select buttons"**.
3. Configure the widget options (below).

It subclasses BEF's `Links` widget, so it works on the same kinds of exposed filters BEF's Links
does — designed for **bundle / entity-reference** filters on content overviews (the module's stated
purpose is bundle selection in overviews).

## Widget settings

`defaultConfiguration()` (in `EntitySelectButtons.php`) returns BEF `Links` defaults plus:

| Key | Default | Form control? | Effect |
|---|---|---|---|
| `display_full_width` | `TRUE` | checkbox *"Show as block element in full width"* | Adds wrapper class `bef-entity-select-buttons--full-width` (element spans full width on its own line). |
| `display_flex` | `FALSE` | checkbox *"Align buttons in flex instead of grid"* | Wrapper class `--flex` when on, else `--grid`. |
| `small_buttons` | `FALSE` | checkbox *"Display small buttons"* | Sets `#button_small`; adds `button--small` to each option/add button. |
| `entity_add_button` | `TRUE` | checkbox *"Add entity type"* | When on, passes `#entity_type` so the preprocess appends per-bundle add-content links. |
| `button_size` | `'default'` | — | Declared but **unused** (no form control, not read anywhere). |
| `button_style` | `'default'` | — | Declared but **unused**. |
| `entity_type_icon` | `TRUE` | — | Declared but **unused**. |
| `restrained_buttons` | `FALSE` | — | Declared but **unused**. |

Only the first four have UI and effect; the other four are dead defaults in this release.

## How the render works

`exposedFormAlter(&$form, $form_state)`:
- Calls `parent::exposedFormAlter()` (BEF Links) first — inheriting all of BEF's exposed-filter
  URL/query handling.
- On `$form[$field_id]` it sets `#theme = 'bef_entity_select_buttons'`, merges wrapper classes
  (`bef-entity-select-buttons`, `--full-width` if enabled, `--flex`/`--grid`), and sets
  `#button_small = small_buttons` and `#entity_type = entity_add_button ? $this->handler->getEntityType() : null`.

Theme + template:
- `hook_theme()` (in `bef_entity_select_buttons.module`) registers `bef_entity_select_buttons`
  with `render element => 'element'`.
- `templates/bef-entity-select-buttons.html.twig` just `{% include "@better_exposed_filters/bef-links.html.twig" %}`
  with an added `bef-entity-select-buttons` class — so the actual list markup is BEF's.

Preprocess `bef_entity_select_buttons_preprocess_bef_entity_select_buttons(&$variables)`:
- Calls `template_preprocess_bef_links($variables)` (BEF) to build the per-option link elements.
- Attaches library `bef_entity_select_buttons/general`.
- For each option child: pushes classes `bef-entity-select-buttons__option-button`, `button`,
  `button--small` (if `#button_small`), and `button--primary` when the option equals the current
  `#value` (selected state).
- Wraps each option `#title` in a `<span>` for styling.
- When `#entity_type` is set, resolves `ContentPathsService::getAddContentUrl($entity_type, $option)`
  and, if a URL comes back, appends it as the element's `#suffix` (an empty-text `Link` with classes
  `button`, `bef-entity-select-buttons__add-entity-button`).

## Add-content link service

`bef_entity_select_buttons.content_paths` (`bef_entity_select_buttons.services.yml`) →
`Service\ContentPathsService`, constructed with `@entity_type.manager`, `@url_generator`,
`@module_handler`.

`getAddContentUrl($entityTypeId, $bundle): ?Url`:
- Loads the entity-type definition. If it `hasLinkTemplate('add-form')`, builds the path by
  substituting the bundle into the `add-form` template (`getEntityAddPath()`); otherwise falls back
  to `node.add` for the given `node_type` (`getNodeAddPath()`, only if `node` is enabled).
- Wraps it as `Url::fromUri("internal:$uri")` and returns it **only when
  `$url->isRouted() && $url->access()`** — so the add button is shown only to users who may create
  that bundle. Returns `null` otherwise (no button rendered).

## JavaScript

`js/bef-entity-select-buttons.js` (library `general`, loaded `async`, deps `core/drupal`,
`core/once`). Behavior `BefEntityButtonSelectRemoveAjax`: on views with BEF AJAX
(`.bef-links-use-ajax`), it clones-and-replaces each `…__add-entity-button` to strip its click
handlers, so clicking the add-content link isn't intercepted as an option selection.

## Styling

CSS component in `css/bef-entity-select-buttons.css` (source `.scss`), keyed on the classes above
(`bef-entity-select-buttons`, `--grid`, `--flex`, `--full-width`, `__option-button`,
`__add-entity-button`). Grid is the default layout; flex is opt-in via `display_flex`.

## What it does NOT do

- No routes, `*.routing.yml`, permissions, or config-schema files.
- No content entities, fields, or field formatters/widgets of its own.
- Adds no exposed-filter *options* — it only restyles the options BEF/Views already produce, so it
  does not change which values are filterable.
