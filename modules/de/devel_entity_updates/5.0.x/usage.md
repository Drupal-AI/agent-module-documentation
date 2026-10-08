Devel Entity Updates restores the removed `drush entity:updates` / `entup` behavior so developers can apply pending entity type and field storage definition schema changes on the fly while iterating on a custom entity type. It is a development-only tool and must not be enabled or relied upon in production.

---

Drupal core removed automatic entity-definition updates (the old `drush entity-updates` command and `drush updb --entity-updates`) because applying arbitrary entity schema changes is not predictable or reliable for real deployments — released changes must go through explicit `hook_update_N()` / `hook_post_update_NAME()` DB update functions (see the change record at drupal.org/node/3082442). Devel Entity Updates brings that convenience back for the narrow case of active local development, where you are repeatedly adding, removing, or altering entity type and field definitions in code and want the storage schema to catch up without hand-writing update hooks each time. It registers a Drush command (`devel-entity-updates`, aliases `dentup`, `entup`, `entity-updates`) that prints a summary of pending changes, asks for confirmation, then applies them and rebuilds caches. Under the hood it provides a `DevelEntityDefinitionUpdateManager` that wraps core's `entity.definition_update_manager`: it reads the complete change list and drives the entity type listener and field storage definition listener to create, update, or delete schema for entity types and fields. It deliberately refuses changes that would require a data migration (throwing an `InvalidArgumentException`), and it also hooks Drush's `replace-command` for `entity:updates` so the legacy command name keeps working. The module depends on Devel and targets Drupal 10.1+/11 with Drush 12 or 13. It is explicitly not a fix for the "Mismatched entity and/or field definitions" error on production sites.

---

- Apply pending entity schema changes during local development by running `drush entup`.
- Restore the `drush entity:updates` command that Drupal core removed.
- Add a new base field to a custom entity type and materialize its storage without writing an update hook.
- Remove a field storage definition from a developing entity type and drop its schema.
- Change an entity type from non-revisionable to revisionable while iterating on it locally.
- Preview the list of pending entity/field definition changes before applying them (the command prints a change summary).
- Confirm before applying updates via the interactive prompt, or abort with a UserAbortException.
- Apply updates and automatically rebuild caches in one step.
- Skip the automatic cache rebuild with `--cache-clear=0` when you will clear caches yourself.
- Use the short aliases `dentup`, `entup`, or `entity-updates` as a drop-in for the old core command.
- Keep legacy tooling working: the module replaces the `entity:updates` command so existing scripts calling it still function.
- Iterate quickly on a new custom content or config-related entity type before its first official release.
- Invoke the `DevelEntityDefinitionUpdateManager::applyUpdates()` API from your own dev tooling to apply changes programmatically.
- Resolve the update manager via the class resolver (`getInstanceFromDefinition()`) to reuse its create/update/delete logic.
- Detect when an entity schema change requires a data migration (the manager throws rather than silently proceeding).
- Avoid hand-writing `hook_update_N()` schema code repeatedly during an active coding session.
- Set up a fast local dev loop: edit entity definitions in code, run `entup`, refresh.
- Explicitly avoid using it on production — it is a Devel-dependent, development-only helper.
- Understand why NOT to use it to "fix" a Mismatched entity and/or field definitions error on a live site.
- Pair with Devel's other developer tools for entity-type development workflows.
