# QA Accounts Drush commands

Defined in `src/Commands/QaAccountsCommands.php` (Drush 9+ service, `drush.services.yml`). A legacy
`qa_accounts.drush.inc` registers the same operations under old-style command names for Drush 8. Both
delegate to the `qa_accounts.create_delete` service (see [../api/service.md](../api/service.md)).

| Command | Aliases | Does |
|---|---|---|
| `qa_accounts:create` | `test-users-create`, `create-test-users`, `qac` | Create a `qa_<role>` account for every role except `anonymous`. |
| `qa_accounts:delete` | `test-users-delete`, `delete-test-users`, `qad` | Delete all `qa_<role>` accounts. |

```bash
# Create the full QA account set (idempotent — skips existing usernames).
drush qa_accounts:create

# Remove them all again.
drush qa_accounts:delete
```

No arguments or options. Output/skips are written to the `qa_accounts` logger channel (watchdog).
