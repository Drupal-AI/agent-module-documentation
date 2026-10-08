Salesforce Webform lets you map Webform submissions to Salesforce: it adds Salesforce-Mapping field plugins that expose a webform's elements as mappable sources, so form submissions can push into Salesforce (e.g. contact/lead capture).

---

The module provides two `SalesforceMappingField` plugins — `WebformElements` ("Webform elements") and `WebformEntityElements` ("Webform Entity Elements") — that make a webform's individual elements available as the Drupal side of a field mapping. With them you create a `salesforce_mapping` whose `drupal_entity_type` is `webform_submission` (bundle = the webform id) and map each webform element to a Salesforce field; `salesforce_push` then sends new submissions to Salesforce. This turns any webform into a Salesforce integration point (lead/contact capture, case creation, etc.) without custom code. It adds no config, permissions, or Drush of its own — it extends `salesforce_mapping`'s field-plugin system and depends on `salesforce_mapping` and `webform`.

---

- Push webform submissions into Salesforce (e.g. create Leads).
- Map individual webform elements to Salesforce fields.
- Build a "Contact us" form that creates a Salesforce Contact.
- Capture marketing leads from a webform into Salesforce.
- Map a webform's email/name/phone elements to Salesforce fields.
- Create a Salesforce Case from a support webform.
- Use WebformElements to expose element values as mapping sources.
- Use WebformEntityElements for entity-reference webform elements.
- Sync submissions on create via push triggers.
- Avoid custom code for form-to-Salesforce integrations.
- Map a webform (bundle) to any Salesforce object.
- Combine with mapped objects to track submitted records.
- Reuse the standard mapping UI to build the field map.
- Support multiple webforms mapped to different objects.
- Feed event registrations into Salesforce.
- Send newsletter signups to Salesforce.
- Map hidden/computed webform elements to Salesforce.
- Push only selected elements by mapping just those.
- Integrate webform-based intake with a CRM.
- Provide the webform source plugins that mapping needs.
