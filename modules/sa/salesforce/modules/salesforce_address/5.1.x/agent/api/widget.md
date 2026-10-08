# The Salesforce-ready address widget

## Widget `salesforce_ready_address`

- Class: `AddressDefaultWidgetStreetAsTextArea`, label "Salesforce-ready Address".
- Field type: `address` (contrib Address module).
- Behavior: same as the default address widget but the **street** is a single `textarea`
  instead of separate address-line fields — matching Salesforce's single multi-line street.

## Apply it

Select it on the entity's Manage form display for an address field, or in config/code:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('user.user.default');                         // any entity with an address field
$fd->setComponent('field_address', [
  'type' => 'salesforce_ready_address',
])->save();
```

Read it back:
```bash
drush cget core.entity_form_display.user.user.default content.field_address.type
# -> salesforce_ready_address
```

## Notes

- Only affects the **editing widget**; the stored address value is standard `address` data.
- No settings of its own beyond the standard address widget settings.
- Typically paired with a `salesforce_mapping` that maps the street to a Salesforce address
  field (e.g. `MailingStreet`).
