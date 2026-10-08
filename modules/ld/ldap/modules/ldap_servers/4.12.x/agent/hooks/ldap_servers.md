# Hooks — ldap_servers

Declared in `ldap_servers.api.php`. Implement in `yourmodule.module`.

## `hook_ldap_entry_pre_provision_alter(array &$ldap_entries, Server $ldap_server, array $context)`

Alter LDAP entries **before** they are written to the directory during provisioning.
`$ldap_entries` is keyed by lowercase DN with attribute-array values (add/modify format).
`$context['action']` is `add|modify|delete`; `$context['corresponding_drupal_data']` maps DNs
to the related Drupal objects (users/roles), and `$context['corresponding_drupal_data_type']`
tells you their type (`'user'`, `'role'`, …).

## `hook_ldap_entry_post_provision(array &$ldap_entries, Server $ldap_server, array $context)`

React **after** LDAP entries are provisioned. Same signature; actually queried entries (if
available) are in `$context['provisioned_ldap_entries'][<dn>]`.

## `hook_ldap_servers_user_cron(array &$users)`

During cron a batch of LDAP-associated Drupal accounts is passed for processing. Your module
is responsible for actually altering LDAP/Drupal objects — mutating the array alone has no
effect.

## `hook_ldap_servers_user_cron_needed(): bool`

Return `FALSE` if your `hook_ldap_servers_user_cron` implementation has nothing to do this run,
so the batch query can be skipped.
