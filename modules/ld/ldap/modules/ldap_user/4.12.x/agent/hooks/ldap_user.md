# Hooks — ldap_user

Declared in `ldap_user.api.php`.

## `hook_ldap_user_attributes_alter(array &$available_user_attrs, array &$params)`

Alter the list of Drupal user targets (fields/properties) offered on the provisioning mapping
form (`/admin/config/people/ldap/user`). Add entries keyed as
`[<field_type>.<field_name>]` with metadata: `name` (UI label), `source` (LDAP attribute),
`configurable`, `configurable_to_ldap`, `user_tokens`, `convert` (binary→string),
`direction` (`LdapUserAttributesInterface::PROVISION_TO_DRUPAL` / `PROVISION_TO_LDAP`),
`config_module`, `prov_module`, `prov_events`. Merge with existing values; leave
`direction`/`convert`/`user_tokens` unset for options the UI should make configurable.

## `hook_ldap_user_edit_user_alter(UserInterface $account, Entry $entry, array $context)`

Alter the Drupal `$account` during synchronization, using the Symfony LDAP `$entry`.
`$context` carries the `ldap_server` and provisioning events. Typical use — copy an extra
attribute into a custom field:

```php
function mymodule_ldap_user_edit_user_alter(UserInterface $account, Entry $entry, array $context) {
  $tokenProcessor = \Drupal::service('ldap.token_processor');
  $value = $tokenProcessor->ldapEntryReplacementsForDrupalAccount($entry, '[sn]');
  $account->set('field_surname', $value);
}
```

Called from `DrupalUserProcessor::applyAttributesToAccount()` /
`applyAttributesToAccountOnCreate()`.
