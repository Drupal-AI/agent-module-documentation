Salesforce Mapping UI adds the admin interface for building and managing Salesforce mappings and mapped objects: list, add, edit, field-map, enable/disable and delete `salesforce_mapping` entities through forms.

---

The module provides the routes, list builders and forms that let a site builder manage the `salesforce_mapping` config entities defined by `salesforce_mapping` without writing config. It exposes a mappings collection at `/admin/structure/salesforce/mappings` (`entity.salesforce_mapping.list`), add/edit forms (`.../add`, `.../manage/{mapping}`), a dedicated **field-mapping** form (`.../manage/{mapping}/fields`) for choosing SalesforceMappingField plugins per row, enable/disable/delete forms, and a mapped-objects admin at `/admin/content/salesforce` (`entity.salesforce_mapped_object.list`). Access is gated by the `salesforce_mapping` module's permissions — `administer salesforce mapping` for the mapping forms and `administer salesforce mapped objects` for mapped-object management (the top-level list also checks `administer salesforce`). It has no config, plugins, or Drush of its own; it is the UI layer on top of `salesforce_mapping`.

---

- Create a Drupal↔Salesforce mapping through the admin UI.
- Edit an existing mapping's object type, triggers, and options.
- Build per-field mappings visually (choose field plugins per row).
- Enable or disable a mapping without deleting it.
- Delete a mapping via a confirm form.
- Browse all configured mappings in one list.
- View and manage mapped objects (Drupal↔Salesforce record links).
- Grant a role access to manage mappings (administer salesforce mapping).
- Grant a role access to manage mapped objects.
- Give site builders a code-free way to configure Salesforce sync.
- Add field mappings for push/pull directions in the UI.
- Set the upsert key and sync triggers from the form.
- Review mapped objects for troubleshooting sync.
- Navigate mappings from the Structure admin menu.
- Restrict mapping administration to trusted roles.
- Configure a mapping before enabling push/pull.
- Manage multiple mappings for different entity types.
- Provide the front-end for the salesforce_mapping config entities.
- Support editing mappings created in code or config.
- Reach the field-mapping form to attach SalesforceMappingField plugins.
