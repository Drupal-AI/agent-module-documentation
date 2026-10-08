# Salesforce Webform — agent index

Adds Salesforce-Mapping field plugins that expose a **webform's elements** as mappable
sources, so Webform submissions can push into Salesforce. No config/permissions/Drush of its
own. Depends on `salesforce_mapping`, `webform`.

- **The webform field plugins & mapping a webform to Salesforce** →
  [plugins/webform-fields.md](plugins/webform-fields.md)

Key facts:
- Field plugins (`salesforce_mapping_field` type): `WebformElements` ("Webform elements") and
  `WebformEntityElements` ("Webform Entity Elements").
- You map a webform by creating a `salesforce_mapping` with
  `drupal_entity_type` = `webform_submission`, `drupal_bundle` = the webform id, and a
  `salesforce_object_type` (e.g. `Lead`); `salesforce_push` sends submissions.
- The mapping entity model + field-mapping form live in `salesforce_mapping` /
  `salesforce_mapping_ui`.
