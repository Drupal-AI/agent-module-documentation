# Constant Contact: signup blocks, field type, webform handler

Ways to collect signups once lists are enabled. All ultimately call the `ik_constant_contact`
service (see [../api/service.md](../api/service.md)).

## Signup blocks

- **`ConstantContactBlock`** (id `ik_constant_contact`, `admin_label` "Constant Contact Signup
  Form") is **derived per enabled list** via `ConstantContactBlockDerivative` — one block per
  enabled list. Its block config form lets you toggle/require each CC field (first_name, last_name,
  company_name, job_title, street_address subfields, phone_number, birthday, anniversary) and any
  account **custom fields** (by `custom_field_id`), plus a rich-text `body` (`text_format`) and a
  `success_message`. Block config schema: `block.settings.ik_constant_contact`.
- **`ConstantContactMultiBlock`** (id `ik_constant_contact_multi`) renders one form covering
  multiple enabled lists. Schema `block.settings.ik_constant_contact_multi`.
- The front-end form is `Form\ConstantContactBlockForm` (`FormBase`), built from the block's
  `listConfig`; on submit it calls the service to create/update the contact. The block `body`
  value is admin-authored rich text (`text_format`) rendered as markup.

## `constant_contact_lists` field type (subscribe on save)

- Field type `constant_contact_lists` (category "Constant Contact"), widgets
  `constant_contact_lists_default` (extends `OptionsSelectWidget`) and
  `constant_contact_lists_checkbox` (extends `OptionsButtonsWidget`), formatter
  `constant_contact_lists_formatter`. `ik_constant_contact_form_alter` fills the widget `#options`
  with enabled lists.
- Storage settings (`ConstantContactListItem::defaultStorageSettings`): `subscribe_on_save`
  (bool), `unsubscribe_on_delete` (bool), and `field_mapping` — a map of CC field →
  entity field name (`email_address` is required when subscribe-on-save is on).
- Runtime: `hook_entity_insert/update/delete` → `_ik_constant_contact_entity_subscribe_on_save()`.
  When `subscribe_on_save` is set and the field has a value, it reads the mapped entity fields
  (handling string, datetime birthday/anniversary, and address fields), builds `$data`, and calls
  `submitContactForm($data, $lists)` on insert/update or `unsubscribeContact($data, $lists)` on
  delete (delete only if `unsubscribe_on_delete`). Form validation
  (`_ik_constant_contact_subscribe_on_save_validate`) enforces the mapped email field is filled.

## Webform handler

- `WebformConstantContactHandler` (`@WebformHandler` id `constant_contact`, unlimited cardinality).
  Config: `list` (target enabled list, or a token/Other value), `email` (which email element),
  `mergevars` (YAML mapping of CC field → value, tokens allowed, e.g.
  `first_name: "[webform_submission:values:first_name]"`). Handler schema
  `webform.handler.ik_constant_contact`.
- `ik_constant_contact_webform_options_constant_contact_lists_alter` populates the shipped
  `constant_contact_lists` webform options with enabled lists (config in `config/optional`).
- On submission it resolves tokens/mergevars and calls the service to add the contact to the list.
  `hook_ik_constant_contact_lists_mergevars_alter` lets modules adjust mergevars.

## Notes

- Enabled lists (`ik_constant_contact.enabled_lists`) gate everything here; a list not enabled is
  rejected by the service and endpoint.
- Custom fields are referenced by their Constant Contact UUID (see the Custom Fields admin tab).
