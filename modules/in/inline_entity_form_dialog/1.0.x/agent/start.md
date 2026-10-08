<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline Entity Form Dialog (inline_entity_form_dialog) — agent index

**Provides an entity_reference field widget that opens referenced entity add/edit forms in a Drupal modal dialog instead of embedding them inline, avoiding nested form state.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11 || ^12 (PHP ^8.2)
- **Dependencies:** drupal:system, drupal:field (no contrib deps; does NOT require inline_entity_form)

## Routes
- `inline_entity_form_dialog.add` — `/inline-entity-form-dialog/{entity_type_id}/{bundle}/add` — permission `access administration pages`
- `inline_entity_form_dialog.edit` — `/inline-entity-form-dialog/{entity_type_id}/{entity_id}/edit` — permission `access administration pages`

## Key classes / services
- `Controller\InlineEntityFormDialogController::addForm/editForm` — build the entity form and return an OpenModal/OpenDialog AJAX command.
- `Ajax\UpdateEntityReferenceCommand` — appends the saved item row and updates the hidden JSON id input.
- `inline_entity_form_dialog.hooks` (`#[Hook]`) — form_alter that turns the dialog form's submit into an AJAX submit.

**Security:** dialog routes are gated only by `access administration pages`; the controller renders arbitrary `{entity_type_id}/{bundle}/{entity_id}` forms via the entity form builder without an added create/update access check on the target entity — grant the permission only to trusted editors. No anonymous access.

See [configure/widget.md](configure/widget.md)
