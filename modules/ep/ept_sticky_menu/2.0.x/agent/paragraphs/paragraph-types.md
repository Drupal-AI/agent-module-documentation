<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph types, fields & displays

All defined as config in `config/install/`. Enabling the module installs three
`paragraphs_type` bundles and their fields, form displays and view displays.

## Bundles (`paragraphs.paragraphs_type.*`)

- **`ept_sticky_menu`** — label "EPT Sticky Menu", description "Extra Paragraph Type (EPT):
  Sticky Menu". The top-level menu container.
- **`ept_sticky_menu_links`** — label "EPT Sticky Menu Links". A second-level dropdown group
  (parent link + children).
- **`ept_sticky_menu_link`** — label "EPT Sticky Menu Link". A single menu link.

No behavior plugins on any bundle.

## Fields

Container `ept_sticky_menu`:
- `field_ept_settings` (type `ept_settings`, from ept_core) — sticky + design settings; edited with
  the `ept_settings_sticky_menu` widget (see [../config/widgets.md](../config/widgets.md)).
- `field_ept_sticky_menu_links` (label "Menu Links", `entity_reference_revisions` → paragraph,
  cardinality **-1**). Target bundles: `ept_sticky_menu_link` and `ept_sticky_menu_links`
  (so a menu holds flat links and/or dropdown groups).

Dropdown group `ept_sticky_menu_links`:
- `field_ept_sticky_menu_parent` (label "Parent Link", `entity_reference_revisions` → paragraph,
  cardinality **1**, target `ept_sticky_menu_link`) — the top-level clickable item.
- `field_ept_sticky_menu_links` (label "Children Links", `entity_reference_revisions` → paragraph,
  cardinality **-1**, target `ept_sticky_menu_link`) — the dropdown items.
- (This bundle has **no** `field_ept_settings`.)

Single link `ept_sticky_menu_link`:
- `field_ept_sticky_menu_link` (label "Link", core **`link`** field, cardinality 1; storage
  `field.storage.paragraph.field_ept_sticky_menu_link.yml`). Field settings `title: 2` (link text
  required) and `link_type: 17` (internal + external).
- `field_ept_settings` (type `ept_settings`) — edited with the `ept_settings_sticky_menu_link`
  widget (open-in-new-tab, link classes, rel, scroll-to-id).

Field storages: `field_ept_sticky_menu_links` and `field_ept_sticky_menu_parent`
(`entity_reference_revisions`, target_type paragraph); `field_ept_sticky_menu_link` (`link`).
The `field_ept_settings` storage itself is provided by **ept_core**.

## How a link resolves (preprocess)

`EptStickyMenuHooks::preprocessParagraph()` (fires only for `ept_sticky_menu_link` bundle):
- reads the first `field_ept_sticky_menu_link` item → `link_url = $item->getUrl()->toString()`,
  `link_text = $item->title`;
- if the link's `ept_settings['scroll_to_id']` is set, **overrides** `link_url` with
  `'#' . trim(scroll_to_id, '# ')` (forces an on-page anchor);
- exposes `ept_link_settings` = `open_in_new_tab`, `link_classes`, `rel`, `scroll_to_id` to the
  link template.

## Displays

`core.entity_form_display.*` / `core.entity_view_display.*` for each bundle set the widgets and
formatters (the two EPT settings widgets above; link field uses the standard link widget/formatter;
the reference-revisions fields use the paragraphs entity-reference-revisions widget/formatter).
The container and dropdown templates print `content|without('field_ept_settings','field_ept_title')`.
