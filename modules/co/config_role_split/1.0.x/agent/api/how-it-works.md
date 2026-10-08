<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: the `role_split` Config Filter

The module registers one `@ConfigFilter` plugin, `role_split`, that operates on the
`config.storage.sync` storage. A **deriver** (`RoleSplitDeriver`) creates one filter instance
per `role_split` config entity, copying the entity's `roles`, `mode`, `weight`, and `status`
into the plugin definition. So each split you configure becomes an active Config Filter (when
`status` is TRUE), applied in `weight` order during config import/export.

It only touches config named `user.role.<id>` **and** only when that role id appears in the
split's `roles` map (`isManagedRole()`); everything else passes through untouched. For a managed
role it rewrites the `permissions` array, then recomputes the role's `dependencies` to match the
permissions that remain (`adjustDependencies()`).

## Read (import) vs Write (export)

`filterRead()` runs when config is read from sync (i.e. on **import**);
`filterWrite()` runs when config is written to sync (i.e. on **export**). Behaviour by `mode`:

| mode | On export (`filterWrite`) | On import (`filterRead`) |
|---|---|---|
| `split` | **remove** the managed permissions from the exported role (they live only in the split). | **merge** the managed permissions back onto the role. |
| `fork` | remove only managed permissions that are **not already** present in the sync file (additive; won't strip ones already exported). | merge the managed permissions onto the role. |
| `exclude` | **add** managed permissions back to the export **if** the site already has them. | **remove** the managed permissions so they never reach active config. |

Net effect:
- **split** = the permission is maintained only in the split entity, absent from shared config,
  re-applied on every import.
- **fork** = like split but non-destructive to permissions already in the sync directory.
- **exclude** = a blocklist: these permissions must never be imported into active config.

## Deletion safety

For `fork` and `exclude` modes the filter refuses to delete a role during sync
(`filterDelete()`/`filterDeleteAll()` return FALSE) to avoid removing a role that another
filter still manages. `split` mode allows normal deletion.

## Practical notes for an agent

- To *see* the effect, run `drush config:export` and diff the resulting `user.role.<id>.yml`
  against active permissions — do **not** expect any change to the live site itself.
- The filter reads its `roles`/`mode` from the stored `config_role_split.role_split.<id>`
  config; `weight`/`status` may be overridden in `settings.php` (cache clear required).
- Permission dependencies are rewritten automatically, so removing a permission also drops the
  now-unneeded `config`/`module` dependency from the exported role.
