<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dialog rendered entity — the formatter

Class `EntityReferenceEntityDialogFormatter` in
`src/Plugin/Field/FieldFormatter/EntityReferenceEntityDialogFormatter.php`.

- Plugin id **`entity_reference_dialog_entity_view`**, label *"Dialog rendered entity"*.
- `field_types = { "entity_reference" }` — targets entity reference fields only.
- Extends core `Drupal\Core\Field\Plugin\Field\FieldFormatter\EntityReferenceEntityFormatter`
  (so it inherits the `view_mode` / `link` base settings) and implements
  `ContainerFactoryPluginInterface`.

## Enable / select

Install `entity_dialog_formatter`, then on an entity reference field's **Manage display**
(`/admin/structure/…/display`) pick format **"Dialog rendered entity"**. Configure via the gear
icon. No standalone settings page (`configure` is null). Grant the **`render entity dialog`**
permission (and normal view access to the target entities) to roles that will open dialogs — see
[../routes/dialog-renderer.md](../routes/dialog-renderer.md).

## Settings — `defaultSettings()`

Adds these on top of the parent's (`view_mode`, `link`):

- `view_mode_destination` (`'default'`) — view mode used to render the entity **inside** the dialog.
- `list_theme` (`'entity_dialog_formatter_list'`) — theme hook used by the controller to render the
  dialog body; passed as the `{theme}` route param.
- `link_class` (`'use-ajax'`) — space-separated classes put on the generated link; `use-ajax` is
  what triggers core's AJAX dialog.
- `dialog_width` (`'800'`), `dialog_height` (`''`) — added to `data-dialog-options` JSON when
  non-empty.
- `dialog_type` (`'modal'`) — value of `data-dialog-type` (e.g. `modal`, `dialog`, or an
  off-canvas type).
- `dialog_title` (`''`) — fixed dialog title; empty means auto (see `getDialogTitle()`).
- `display_all_dialog` (TRUE) — if TRUE, every link opens **all** referenced entities in the dialog;
  if FALSE, each link opens only its own entity.

`settingsForm()` exposes all of the above (`view_mode_destination`, `list_theme`, `link_class`,
`dialog_type` required; widths/height/title optional). `settingsSummary()` prints each value.

## `viewElements($items, $langcode)`

1. Reads the settings above plus the inherited `view_mode`.
2. Builds `$dialog_options` (`width`/`height` only when set).
3. `$entities = $this->getEntitiesToView($items, $langcode)` — core method that **filters by view
   access**; collects their ids into `$entities_id`.
4. For each entity: renders it with the entity view builder in `view_mode`, runs the markup through
   `filterLinksFromHtml()` (a `preg_replace` that removes any `<a>…</a>` so the inner content has no
   nested links), and produces a render element:
   - `#type => 'link'`, `#title => Markup::create($filtered_output)` (the rendered entity markup),
   - `#url => Url::fromRoute('entity_dialog_formatter.dialog_renderer', [...])` with params
     `type` = entity type id, `view_mode` = `view_mode_destination`,
     `id` = `Json::encode(...)` (all ids when `display_all_dialog`, else just this entity's id),
     `theme` = `list_theme`, `title` = `getDialogTitle()`,
   - `#attributes` = `class` (exploded `link_class`), `data-dialog-type`, `data-dialog-options`
     (JSON),
   - `#attached` library `core/drupal.dialog.ajax`.

## Helpers

- `filterLinksFromHtml($string)` — `preg_replace('@<(a)\b.*?>.*?</\1>@si', '', $string)`; strips
  anchor tags from the rendered entity so the on-page item is a single clean AJAX link.
- `getDialogTitle($entities, $entity)` — returns the `dialog_title` setting if set; otherwise the
  entity label (single entity or `display_all_dialog` off) or the field label (multiple + display
  all). Slashes are replaced with `-` (the route `{title}` is a single path segment).

Source is ~250 lines; this page summarizes it.
