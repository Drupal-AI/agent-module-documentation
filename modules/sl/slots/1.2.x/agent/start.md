<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slots (slots) — agent index

**Reusable content placeholders that render condition-matched content blocks into layouts, regions, Views, Paragraphs or Twig without exporting the content to config.**

- **Version:** 1.2.x (1.2.1)
- **Core:** ^10 || ^11
- **Dependencies:** block_plugin_view_builder, conditions:conditions_field, dynamic_entity_reference
- **Submodules:** slots_paragraphs, slots_views, slots_twig, slots_test

## Routes / entity
- `Slot` content entity — admin UI at `/admin/content/slots/*`, `admin_permission = administer slots` (route provider `SlotHtmlRouteProvider`). Base module `slots.routing.yml` is otherwise empty.

## Permissions
`administer slots` (restricted), `access slot library`, `view slot identifiers`, `create slots`

## Services
`slots.service` (`SlotsService` — condition eval + block rendering), `slots.context_provider`, `slots.controller_alter` (`ControllerAlterSubscriber` adds "Add slot" to Layout Builder), `slots.conditions_field.service`.

**Security:** slot management is gated by `administer slots` (restrict access); overview/identifier/create gated by their own permissions. No anonymous mutating endpoints — front-end is read-only condition evaluation. `SlotsService` uses `accessCheck(FALSE)` only for internal slot-identifier lookups (config-like ids), not for rendering user content. No security findings.

See [configure/setup.md](configure/setup.md)
