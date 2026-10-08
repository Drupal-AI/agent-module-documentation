# Configure — per-role required on a field

This module has no settings page. You configure it per field, through the **Required API**
UI that this plugin plugs into.

## Set it up

1. Ensure `required_api` and `required_by_role` are enabled.
2. Edit a field instance (*Structure → Content types → … → Manage fields → edit*, or the
   equivalent for any entity/bundle).
3. In Required API's "required" section, choose the **Required by role** plugin.
4. A `tableselect` of roles appears (the *Authenticated user* role is intentionally
   excluded). Tick the roles for which the field must be required.
5. Save. The field is now required only for users who have at least one ticked role.

## Where it is stored

As `required_api` third-party settings on the field config:

```yaml
third_party_settings:
  required_api:
    required_plugin: required_by_role
    required_plugin_options:   # array of role machine names
      - editor
      - legal_reviewer
```

Config schema key: `required_api.plugin_options.required_by_role` (a sequence of role
strings). `submitFieldConfigForm()` saves the ticked roles as
`array_keys(array_filter($options))`.

## Runtime logic

`isRequired(FieldDefinitionInterface $field, ContentEntityInterface $entity)`:

```php
$user_roles = \Drupal::currentUser()->getRoles();
$field_roles = $field->getThirdPartySetting('required_api', 'required_plugin_options', []);
return (bool) array_intersect($user_roles, $field_roles);  // any overlap → required
```

Required API uses that boolean to set the form element's `#required`. So the field is
**required for the selected roles and optional for everyone else**.

## Important: this is validation, not access

Making a field "not required" for a role does **not** hide it or block editing — the field
is still rendered and writable. Use core field access / field-permissions modules if you
need to actually restrict who can see or edit a field. Required by role only toggles whether
a value must be provided before the form validates.

## Update hooks

- `required_by_role_update_8001` — normalises `required_plugin_options` to a clean indexed
  array for fields using this plugin.
- `required_by_role_update_8002` — repairs fields where the option was wrongly stored as an
  array under `RequiredDefault`; sets them required (`1`) to be safe and logs the affected
  field IDs to review.
