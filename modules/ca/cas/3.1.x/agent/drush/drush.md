# Drush commands

Defined in `src/Drush/Commands/CasCommands.php`.

| Command | Args | Purpose |
|---|---|---|
| `cas:set-cas-username` | `<drupalUsername> <casUsername>` | Link an existing Drupal account to a CAS username (creates the externalauth mapping so that user authenticates via CAS). |

```
drush cas:set-cas-username jsmith jsmith@EXAMPLE.EDU
```

For provisioning many accounts interactively instead, use the bulk "add CAS users" admin
form (route `cas.bulk_add_cas_users`).
