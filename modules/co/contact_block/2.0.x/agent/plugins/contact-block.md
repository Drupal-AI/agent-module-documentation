# The Contact block plugin

`@Block(id = "contact_block")` — `Drupal\contact_block\Plugin\Block\ContactBlock`
(extends `BlockBase`). This is a plugin the module *provides*; it does not define a new
plugin type.

## Build
`build()` loads the configured `contact_form`, creates an unsaved `contact_message` entity
for it, and renders its form via `entity.form_builder` using the configured `form_display`
mode. It adds the `user.permissions` cache context, a cacheable dependency on the form, and
contextual links.

## Access (`blockAccess`)
- Form deleted → **forbidden**.
- Personal form (`$message->isPersonal()`): requires a `user` route parameter; if absent →
  forbidden; otherwise delegates to `access_check.contact_personal` for that user.
- Any other form → `$contact_form->access('view', $account)` (same as the
  `entity.contact_form.canonical` route permission).

## Form modes as displays
`contact_block_entity_type_alter()` registers every `contact_message` form mode as a usable
form class, so all form displays you create for `contact_message` become selectable in the
block's **Form display** setting.

No public service/API — configure via the block form ([configure/block.md](../configure/block.md)).
