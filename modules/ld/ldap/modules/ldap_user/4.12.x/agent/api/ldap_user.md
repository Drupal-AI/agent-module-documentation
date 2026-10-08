# Programmatic API — provisioning, processors & events

Services defined in `ldap_user.services.yml`.

## Provision/associate Drupal accounts — `ldap.drupal_user_processor`

`Drupal\ldap_user\Processor\DrupalUserProcessor`. Core methods:

```php
/** @var \Drupal\ldap_user\Processor\DrupalUserProcessor $p */
$p = \Drupal::service('ldap.drupal_user_processor');

$p->ldapAssociateDrupalAccount('jdoe');          // link an existing Drupal user to LDAP (by PUID)
$p->createDrupalUserFromLdapEntry($user_data);   // provision a new account from LDAP data
$p->drupalUserUpdate($account);                  // refresh fields from LDAP
$p->drupalUserLogsIn($account);                  // apply the on-login sync
$p->ldapExcludeDrupalAccount('jdoe');            // mark an account excluded from LDAP processing
$p->excludeUser($account);                       // bool: is this account excluded?
$account = $p->getUserAccount();                 // the processed User
```

## Other processors

- `ldap_user.field_provider` (`FieldProvider`) — enumerates mappable Drupal user targets used
  by the mapping forms; extend via `hook_ldap_user_attributes_alter()`.
- `ldap.orphan_processor` (`OrphanProcessor`) — finds accounts whose LDAP entry no longer
  exists and applies the orphan behaviour (email / disable / delete) on cron.
- `ldap.group_user_update_processor` (`GroupUserUpdateProcessor`) — bulk-refreshes users from a
  stored LDAP query (`ldap.query`) on cron; also integrates with `authorization.manager`.

## Reverse provisioning (event subscribers)

- `ldap_user.ldap_provision` (`LdapEntryProvisionSubscriber`) — writes/updates the LDAP entry
  when a Drupal account changes.
- `ldap_user.ldap_delete` (`LdapEntryDeletionSubscriber`) — deletes the LDAP entry on account
  removal.

## Events you can subscribe to

`Drupal\ldap_user\Event\*`: `LdapUserLoginEvent`, `LdapNewUserCreatedEvent`,
`LdapUserUpdatedEvent`, `LdapUserDeletedEvent`. Subscribe with a normal
`EventSubscriberInterface` service to react to LDAP-driven account lifecycle changes.

## Protecting fields

`LdapProtectedUserFieldConstraint` (Validation constraint) guards sensitive user fields from
being overwritten by sync.
