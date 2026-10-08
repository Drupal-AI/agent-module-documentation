# Configure attribute → field mappings

The module stores a flat list of maps in the config object `simplesamlphp_custom_attributes.mappings`
under key `mappings`. Each entry is `{ attribute_name, field_name }`. There is no single settings form —
mappings are managed as individual add/edit/delete operations from a listing table.

## UI

- **List:** `admin/config/people/simplesamlphp-custom-attributes` (route `simplesamlphp_custom_attributes.list`,
  menu title "SimpleSAMLphp Auth Attribute Mapping", under People / `user.admin_index`). Rendered by
  `SimplesamlphpCustomAttributesController::ssoMappings` — a table of SAML Attribute / User Field / Operations
  (edit, delete dropbutton). This is also the module's `configure` link.
- **Add:** action link "Add Mapping" → `.../add` (route `.add`, form `SimplesamlphpCustomAttributesEditForm`).
- **Edit:** `.../{mapping}/edit` (route `.edit`, same form). `{mapping}` is the numeric array index of the entry.
- **Delete:** `.../{mapping}/delete` (route `.delete`, `SimplesamlphpCustomAttributesDeleteForm`, a confirm form).

All four routes require the permission `administer simplesamlphp authentication` (defined by `simplesamlphp_auth`;
this module defines none). Forms are standard Drupal `FormBase`/`ConfirmFormBase`, so CSRF tokens apply.

### Add/edit form fields

| Form key | Type | Notes |
|---|---|---|
| `attribute_name` | textfield, required | The SAML attribute name to read from the login assertion. Use the SimpleSAMLphp friendly name (e.g. `givenName`, `sn`) if configured, else the OID (`urn:oid:...`). |
| `field_name` | select, required | Target user field. Options = every user field whose storage provider is **not** `user`, keyed by machine name and labeled by field label, plus a `custom` option labeled "Custom". |
| `mapping_id` | hidden | Numeric index when editing; empty when adding. |

The provider filter (`$field->getFieldStorageDefinition()->getProvider() != 'user'`) means core user base fields
(`name`, `mail`, `roles`, `status`, `pass`, `timezone`, …) are **not** offered — only Field-API-added fields or
base fields contributed by other modules. The `custom` choice is a placeholder: at login the runtime hook finds no
field literally named `custom`, so a `custom` mapping stores nothing (it just appears in the list as a note).

`validateForm()` blocks adding a duplicate (same `attribute_name` **and** `field_name`) when creating a new mapping.
`submitForm()` appends (new) or overwrites at `mapping_id` (edit), then `->save()` and redirects to the list.

## Config object & schema

`config/schema/simplesamlphp_custom_attributes.schema.yml`:

```yaml
simplesamlphp_custom_attributes.mappings:
  type: config_object
  mapping:
    mappings:            # sequence
      sequence:
        type: mapping
        mapping:
          attribute_name: { type: string }   # SAML provider attribute
          field_name:     { type: string }   # Drupal user field machine name
```

Default install config (`config/install/simplesamlphp_custom_attributes.mappings.yml`): `mappings: {}`.
Config translation is enabled for this object (`simplesamlphp_custom_attributes.config_translation.yml`).

## Set mappings via Drush / PHP

Drush:

```bash
drush config:set simplesamlphp_custom_attributes.mappings mappings.0.attribute_name 'givenName'
drush config:set simplesamlphp_custom_attributes.mappings mappings.0.field_name 'field_given_name'
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('simplesamlphp_custom_attributes.mappings')
  ->set('mappings', [
    ['attribute_name' => 'urn:oid:2.16.840.1.113730.3.1.241', 'field_name' => 'field_full_name'],
    ['attribute_name' => 'department', 'field_name' => 'field_department'],
  ])
  ->save();
```

The runtime write step (which field types are handled, cardinality behavior) is documented in
[../hooks/attribute_mapping.md](../hooks/attribute_mapping.md).
