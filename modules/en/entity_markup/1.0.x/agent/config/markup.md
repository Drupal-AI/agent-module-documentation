<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entity, edit form, and render path

## Config entity `entity_view_markup`

`src/Entity/EntityViewMarkup.php` — `EntityViewMarkup extends ConfigEntityBase` implements
`EntityViewMarkupInterface`. Annotation `@ConfigEntityType(id="entity_view_markup")`, access handler
core `EntityViewDisplayAccessControlHandler`, `config_export = { id, targetEntityType, bundle, mode,
field_markup }`. `id()` returns `targetEntityType . '.' . bundle . '.' . mode`, so config objects are
named `entity_markup.entity_view_markup.<entity_type>.<bundle>.<mode>` (mode = a view mode machine
name such as `default` or `teaser`). Getters: `getTargetEntityTypeId()`, `getMode()`,
`getTargetBundle()`.

Property `field_markup` is an array keyed by **field machine name**; each entry may contain:
`display_label`, `label_tag`, `field_tag`, `field_items_tag`, `field_item_tag`, `field_classes`,
`field_item_classes`.

### Schema — `config/schema/entity_markup.schema.yml`

- `entity_markup.entity_view_markup.*.*.*` → `type: config_entity` with mapping `targetEntityType`,
  `bundle`, `mode` (all strings) and `field_markup` (`type: sequence` of `field_markup.*`).
- `field_markup.*` → mapping with `id`, `display_label`, `label_tag`, `field_tag`, `field_items_tag`,
  `field_item_tag`, `field_classes` (all `type: string`). (Note: `field_item_classes` is written by the
  form/preprocess but is **not** declared in the schema.)

No `config/install/` defaults ship; entries are created only when a display is saved (see below).

## Edit form `EntityMarkupEditForm`

`src/Form/EntityMarkupEditForm.php` extends `FormBase` (marked `@internal`). Constructed with
`entity_type.manager`, `entity_field.manager`, `current_route_match`. In the constructor it loads (or
creates in memory) the matching core `entity_view_display` for `entity_type_id.bundle.view_mode_name`
from the route parameters — used only to read component/region and label settings.

- `getFormId()` returns a route-specific id: `entity_markup_<entity_type_id>_<bundle>_<view_mode_name>`.
- `buildForm()` loads the `EntityViewMarkup` config for the route (or creates a fresh in-memory one),
  then builds a `#type => table`. It lists field definitions filtered by
  `array_filter(...)`: a field is shown if it is `title`, or it `isDisplayConfigurable('view')` (and is
  not `layout_builder__layout`/`langcode`/a `metatag` type) **and** is either in a visible (non-hidden)
  display region or the display has Layout Builder enabled (`getThirdPartySetting('layout_builder',
  'enabled')`).
- Per-field columns/builders: `buildLabelText()` (textfield for `display_label`, hidden when the
  component label is "hidden"), `buildLabelMarkupDropdown()` (`label_tag`: Default/figure/p/span/h1–h6),
  `buildFieldMarkupDropdown()` (`field_tag`: Default/Remove/figure/p/ul), `buildFieldItemsMarkupDropdown()`
  (`field_items_tag`, shown only when field cardinality != 1), `buildFieldItemMarkupDropdown()`
  (`field_item_tag`: Default/Remove/figure/p/span/li/h1–h6), `buildAdditionalClasses()` /
  `buildAdditionalItemClasses()` (textfields for `field_classes` / `field_item_classes`; use the field's
  `entity_markup` third-party settings as placeholder if present). All tag selects offer a fixed option
  list; `remove` drops the wrapper.
- Hidden fields carry `entity_type_id`, `bundle`, `view_mode_name`.
- `submitForm()` reloads/creates the config, sets `targetEntityType`/`bundle`/`mode`, and builds
  `field_markup` from non-empty submitted values. If any markup was set it `save()`s; if the result is
  empty it `delete()`s the config entity (so an all-default display stores nothing). Adds a
  "Your settings have been saved." status message.

## Render / apply path

`entity_markup.module`:

- `entity_markup_theme()` registers field templates `field__entity_markup` (base hook `field`) plus
  variants `__text`, `__text_long`, `__text_with_summary`, `__node__title` (each with the matching base
  hook), from `templates/`. Extra variables: `field_items_tag`, `field_item_tag`, `field_tag`,
  `label_tag`.
- `entity_markup_theme_suggestions_field_alter()` splices `field__entity_markup` (and the typed
  variants) into the field theme-suggestion list ahead of the stable/classy defaults, so these templates
  win.
- `entity_markup_preprocess_field()` sets each tag variable to a default `['#plain_text' => 'div']`,
  then loads `EntityViewMarkup::load(<type>.<bundle>.<view_mode>)`, falling back to `...default`. For the
  current `#field_name` it applies the stored `field_tag`/`field_items_tag`/`field_item_tag`/`label_tag`
  (a value of `remove` unsets the variable so the template omits that wrapper), appends `field_classes`
  to `attributes.class` and `field_item_classes` to each item's classes (space-split), and overrides the
  label with `display_label`.
- Templates (`templates/field--entity-markup*.html.twig`) emit the wrappers conditionally, e.g.
  `<{{ field_tag }}>…</{{ field_tag }}>` and per-item `<{{ field_item_tag }}>`, only when the tag
  variable is set. `field--entity-markup--text*.html.twig` extend the base and add the core
  `clearfix text-formatted` classes; `field--entity-markup--node--title.html.twig` just extends the base.

## Operate

1. `drush en entity_markup` (or install via UI). Requires core `field`.
2. Visit a bundle's Field UI area (e.g. `admin/structure/types/manage/<bundle>/…`); a **Manage markup**
   tab appears with a sub-tab per view mode (see [../routing/tabs.md](../routing/tabs.md)).
3. Set tags/labels/classes per field and Save. Export the resulting
   `entity_markup.entity_view_markup.*` config as usual.

Caveat: the form description warns that fields whose display is overridden by another formatter may
ignore these settings unless that output extends one of the module's base entity-markup Twig templates.
