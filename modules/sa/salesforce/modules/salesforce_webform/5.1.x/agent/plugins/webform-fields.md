# Webform field plugins & mapping a webform

## The plugins

Two `@SalesforceMappingField` plugins (plugin type `salesforce_mapping_field`, from
`salesforce_mapping`):

| id | label | Purpose |
|---|---|---|
| `WebformElements` | Webform elements | Exposes a webform's element values as the Drupal source of a field mapping. |
| `WebformEntityElements` | Webform Entity Elements | Same, for entity-reference webform elements. |

They appear as field-plugin choices when building the `field_mappings` of a mapping whose
Drupal entity type is `webform_submission`.

## Map a webform to Salesforce

Create a `salesforce_mapping` for webform submissions:
```php
\Drupal::entityTypeManager()->getStorage('salesforce_mapping')->create([
  'id' => 'contact_form_lead',
  'label' => 'Contact form → Lead',
  'weight' => 0,
  'type' => 'salesforce_mapping',
  'key' => '',
  'salesforce_object_type' => 'Lead',
  'drupal_entity_type' => 'webform_submission',
  'drupal_bundle' => 'contact',                 // the webform machine id
  'sync_triggers' => ['push_create' => TRUE],   // push new submissions
  'field_mappings' => [
    // each row uses the WebformElements plugin to pick a webform element:
    // ['drupal_field_type' => 'WebformElements', 'drupal_field_value' => 'email',
    //  'salesforce_field' => 'Email', 'direction' => 'drupal_sf'],
  ],
])->save();
```

Then build the per-element field mappings in the UI
(`/admin/structure/salesforce/mappings/manage/contact_form_lead/fields`) and enable
`salesforce_push`.

## Read back

```bash
drush cget salesforce.mapping.contact_form_lead
# drupal_entity_type: webform_submission; drupal_bundle: <webform id>; salesforce_object_type: Lead
```

## Notes

- This module only adds the webform source plugins; the mapping entity, triggers and push are
  documented under `salesforce_mapping` / `salesforce_push`.
- `drupal_bundle` is the webform's machine name.
