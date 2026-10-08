# Drush & migration workflow

## Command

```
drush entity-hierarchy:rebuild-tree <field_name> <entity_type_id>
# alias: entity-hierarchy-rebuild-tree
# e.g.
drush entity-hierarchy:rebuild-tree field_parent node
```

Rebuilds the nested-set table for one hierarchy field from the current entity data
(`EntityHierarchyCommands::hierarchyRebuildTree` → `TreeRebuilder::getRebuildTasks`, run as a
non-progressive Batch). Use it after bulk imports, or after re-enabling writes (below), or if
a tree table ever gets out of sync.

## Migration write-disable flag

Tree writes are deliberately expensive (cheap reads, costly writes). During a large
migration, disable the per-save tree writes with a **State** flag, migrate, then re-enable
and rebuild once:

```
# pause tree writes
drush sset entity_hierarchy_disable_writes 1

# ... run your migration / bulk entity saves ...

# resume writes and rebuild the tree in one pass
drush sset entity_hierarchy_disable_writes 0
drush entity-hierarchy:rebuild-tree field_parent node
```

The flag is read on entity save; while set to `1`, saving entities does not update the
nested-set table, so you must rebuild afterwards to get a correct tree.
