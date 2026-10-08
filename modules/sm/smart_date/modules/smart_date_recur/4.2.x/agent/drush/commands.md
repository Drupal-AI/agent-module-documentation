# Drush commands

From `src/Drush/Commands/SmartDateRecurCommands.php`:

- `smart_date_recur:prune-invalid-rules` (alias `prune-sd-rules`) — find and delete
  `smart_date_rule` entities that no longer point at a valid host entity/field, cleaning up
  orphaned recurrence rules.

Run: `drush smart_date_recur:prune-invalid-rules`.
