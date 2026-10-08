# Writing SAML values to fields on login

The module implements one hook from `simplesamlphp_auth`, in `simplesamlphp_custom_attributes.module`:

```php
function simplesamlphp_custom_attributes_simplesamlphp_auth_user_attributes(
  UserInterface $account, array $attributes
)
```

`simplesamlphp_auth` invokes `hook_simplesamlphp_auth_user_attributes($account, $attributes)` during
SAML login (see the base module's `simplesamlphp_auth.api.php`). `$attributes` is the raw attribute
array from the IdP assertion, keyed by SAML attribute name; each value is itself an array of values.
Implementations may mutate `$account` and must return the altered account (or `FALSE` if unchanged).
`simplesamlphp_auth` then persists the account.

## Logic

1. Load `mappings` from config `simplesamlphp_custom_attributes.mappings`.
2. Load user field definitions via `entity_field.manager` → `getFieldDefinitions('user', 'user')`.
3. For each mapping, act only when **all** hold:
   - `isset($attributes[$mapping['attribute_name']])` — the IdP actually returned that attribute, and
   - `$account->hasField($mapping['field_name'])`, and
   - the field name exists in the loaded field definitions.
4. Determine the field's type and storage cardinality, then write:

| Condition | Write performed |
|---|---|
| field type `entity_reference` **and** attribute value is numeric | wrap as `['target_id' => $attribute]` before writing |
| cardinality `!= 1` **and** type `entity_reference` | `$account->get(field)->appendItem($attribute)` (append) |
| otherwise | `$account->set(field, $attribute)` (replace) |

5. Return `$account` if at least one mapping matched (`$changed`), else `FALSE`.

Notes:
- The written value is the raw `$attributes[...]` entry (an array of assertion values); Drupal's field
  API takes the applicable delta(s). Non-`entity_reference`, non-numeric values are set verbatim.
- Only `entity_reference` gets the append path; every other multi-value field type is written with
  `set()`, which replaces existing values.
- Unlike the add/edit form (which hides core-user fields and offers a `Custom` placeholder), this hook
  does not filter by field provider — it writes to whatever `field_name` a mapping names, provided the
  field exists on the account. A `field_name` of `custom` matches no real field, so it is a no-op.

## Where this sits

- Mappings are created/edited in the UI or config — see [../configure/mappings.md](../configure/mappings.md).
- The hook contract and the login flow that calls it live in `simplesamlphp_auth`.
