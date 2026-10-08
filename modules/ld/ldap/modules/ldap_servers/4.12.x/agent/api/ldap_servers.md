# Programmatic API — LDAP connection & directory services

All services are defined in `ldap_servers.services.yml`.

## Connect & bind — `ldap.bridge` (`LdapBridge`)

Wraps `symfony/ldap`. Select a server and bind, then get the raw Symfony `Ldap` client:

```php
/** @var \Drupal\ldap_servers\LdapBridge $bridge */
$bridge = \Drupal::service('ldap.bridge');
$bridge->setServerById('my_server');            // or ->setServer(Server $server)
if ($bridge->bind()) {
  $ldap = $bridge->get();                        // \Symfony\Component\Ldap\LdapInterface
  $results = $ldap->query('ou=people,dc=example,dc=org', '(uid=jdoe)')
    ->execute()->toArray();                      // Symfony\Component\Ldap\Entry[]
}
```

## Read/write user entries — `ldap.user_manager` (`LdapUserManager`)

Extends `LdapBaseManager`. Set the active server first (`setServerById()` / `setServer()`),
then:

- `queryLdapForUsername($base_dn, $drupal_username)` / `queryAllBaseDnLdapForUsername($username)` — find a user entry.
- `matchUsernameToexistingLdapEntry($drupal_username)` — resolve the DN for a name.
- `getUserAccountFromPuid(string $puid): ?UserInterface` — map a persistent unique id back to a Drupal user.
- `getUserDataByIdentifier($identifier)` / `getUserDataByAccount(UserInterface $account)`.
- Inherited write ops: `createLdapEntry(Entry $entry)`, `modifyLdapEntry(Entry $entry)`, `deleteLdapEntry(string $dn)`, `checkDnExists($dn)`, `searchAllBaseDns($filter, $attributes)`.

## Group membership — `ldap.group_manager` (`LdapGroupManager`)

Also set the server first. Highlights:

- `groupMembershipsFromUser(string $username): array` — all groups a user belongs to.
- `groupUserMembershipsFromEntry(Entry $entry)` / `groupUserMembershipsFromDn($username)`.
- `groupIsMember(string $group_dn, string $username): bool`.
- `groupAllMembers($group_dn)` / `groupMembers($group_dn)` / `groupMembersRecursive(...)` (nested groups).
- Write ops: `groupAddGroup()`, `groupRemoveGroup()`, `groupAddMember($group_dn, $user)`, `groupRemoveMember()`.
- `groupGroupEntryMembershipsConfigured(): bool` — is group lookup usable on this server?

## Helpers

- `ldap.token_processor` (`Processor\TokenProcessor`) — replace attribute tokens such as
  `[cn]`, `[mail]`, `[dn]` from a Symfony `Entry`
  (`ldapEntryReplacementsForDrupalAccount($entry, '[sn]')`).
- `ldap.detail_log` (`Logger\LdapDetailLog`) — verbose logging, no-op unless
  `ldap_servers.settings:watchdog_detail` is on.

Interfaces worth knowing: `ServerInterface`, `LdapBridgeInterface`,
`LdapUserAttributesInterface` (provisioning direction/event constants).
