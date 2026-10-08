# Theming — libraries, Backbone widget & formatter output

## Libraries (`shs.libraries.yml`)

- **`shs/shs.form`** — attached by the widget. Loads `css/shs.form.css`, `js/shs.js`, and the
  Backbone models/views. Depends on `core/jquery`, `core/drupal`, `core/drupalSettings`,
  `core/internal.backbone`, `core/once`.
- **`shs/shs.formatter`** — loads `css/shs.formatter.css`; attached by the read formatter.

## How the widget renders (client side)

`js/shs.js` defines `Drupal.behaviors.shs`. On attach it finds each `.shs-enabled` element (the
textfield the widget produced), reads its config from `drupalSettings.shs[data-shs-selector]`,
and instantiates a Backbone **app model + app view** that renders the cascading `<select>`
boxes and fetches each level from the `shs-term-data` endpoint. Classes are resolved through
`Drupal.shs.getClass()` / `Drupal.shs.classes`, so any class can be overridden per field via the
`hook_shs_*_class_definitions_alter()` hooks (see api/shs.md).

Default JS class map (`shs_get_class_definitions()`):

| Kind | Keys → default class |
|---|---|
| models | `app` `Drupal.shs.AppModel`, `container` …ContainerModel, `widget` …WidgetModel, `widgetItem` …WidgetItemModel, `widgetItemOption` …WidgetItemOptionModel |
| views | `app` `Drupal.shs.AppView`, `addNew` …AddNewView, `container` …ContainerView, `widget` …WidgetView, `widgetItem` …WidgetItemView |

Source lives in `js/models/*.js` and `js/views/*.js`. `AddNewView.js` handles the multi-value
"Add another item" row; `css/shs.form.css` and `images/arrow.png` style the level selects.

To restyle: override the CSS in your theme, or replace a view class (e.g. `WidgetItemView`) with
your own via a class-definitions alter hook.

## Formatter output (`entity_reference_shs`)

`EntityReferenceShsFormatter::viewElements()` renders each selected term as its ancestry
(root → … → term) using `#theme => 'item_list'` with classes `shs clearfix` (plus `shs-linked`
when the `link` setting is on). It attaches `shs/shs.formatter`. Because it is a themed
`item_list`, override with the standard `item-list.html.twig` / `item-list--…` suggestions or
target the `.shs` wrapper class in CSS.

## No custom theme hooks / templates

SHS ships **no** `hook_theme()` templates of its own — it reuses core's `item_list` for display
and builds the form widget entirely in JS. Theming is therefore done through the two CSS files,
the overridable Backbone classes, and standard `item_list` overrides.
