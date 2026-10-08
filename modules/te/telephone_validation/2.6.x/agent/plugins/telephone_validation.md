# The `Telephone` validation constraint

The module ships one Symfony/Drupal validation constraint plugin and auto-attaches it to the
core telephone field type. It does **not** define a new plugin type or manager — it implements
the constraint plugin type provided by Drupal core.

## How it is attached

`hook_field_info_alter()` adds the constraint to the `telephone` field type for every field:

```php
$info['telephone']['constraints']['Telephone'] = [];
```

So the constraint runs on all telephone fields, but only *acts* when a field instance has
third-party settings enabled (see configure doc).

## The plugin

- **Constraint:** `Drupal\telephone_validation\Plugin\Validation\Constraint\TelephoneConstraint`
  - id `Telephone`, label "Telephone".
  - `public string $message = "@number is not a valid phone number.";`
- **Validator:** `TelephoneConstraintValidator` (implements `ContainerInjectionInterface`,
  injects `telephone_validation.validator`).

`validate()` logic:
1. Reads the field value; returns early if it can't (`InvalidArgumentException`).
2. Gets the `FieldDefinition`; returns if it isn't a `ThirdPartySettingsInterface`.
3. Reads `telephone_validation` third-party settings; **if empty, skips validation** (this is
   the per-field opt-in gate).
4. Calls `Validator::isValid($number['value'], format, country)` with the field's `format` and
   `country` third-party settings; on failure adds the `message` violation with `@number`.

To validate telephone data outside the field API, call the `telephone_validation.validator`
service directly (see [api/telephone_validation.md](../api/telephone_validation.md)) rather
than instantiating the constraint yourself.
