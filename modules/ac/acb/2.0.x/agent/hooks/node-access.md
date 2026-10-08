<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ACB node-access hooks & grant-cascade mechanism

Everything in `acb` lives in hook implementations in `acb.module` and `acb.install`.
There is **no** routing, config, permission, service, plugin, template, or JS. This file
documents the exact hooks and the algorithm so an agent can reason about behaviour or debug
access outcomes.

## Discovery: which modules are "bridged"
`acb_get_modules($self = FALSE)` returns the sorted, de-duplicated list of modules that
implement `hook_node_grants` **or** `hook_node_access_records`, minus `acl` (it "doesn't
control anything on its own") and optionally minus `acb`. That set is the population ACB
intersects.

`acb_is_module_realm($realm, $module)` decides whether a grant realm belongs to a module:
- `domain_access` is normalized to the realm prefix `domain`.
- realm `term_access` maps to module `taxonomy_access`.
- otherwise: `strpos($realm, $module) === 0` (realm string starts with the module name).

## `hook_node_access_records_alter(&$grants, $node)`
Rewrites the **records stored for a node** (what the node offers).
1. Split `$grants` into per-module buckets using `acb_is_module_realm()`. Realms `all` and
   `acl` are attributed via the grant's `module`/`#module` key, defaulting to
   `content_access`.
2. Drop modules that set no records (`array_filter`).
3. **If ≤ 1 module controls the node, return unchanged** — legacy single-module behaviour is
   preserved.
4. Expand any `realm == 'all'` grant into per-role (`anonymous`/`authenticated`) grants keyed
   `<module>_rid`.
5. Replace `$grants` with `_acb_cascade_grants($split, TRUE)` — a cross-product across the
   controlling modules. For each combination, `grant_view/update/delete` are the **product**
   of the members' flags (so a `0`/deny from any member zeroes the combination). Records with
   all-zero flags are dropped to save rows; kept records use realm `acb&<realm+gid>&…`,
   `gid = 0`, `priority = 100`.

Net effect: the node only advertises access for a role/dimension combination when **all**
controlling modules advertise it — logical AND.

## `hook_node_grants_alter(&$grants, $account, $op)`
Rewrites the **grants a user carries** (what the user presents), so users match the combined
`acb&…` realms above.
1. If `acl` is enabled, load `acl` table rows (`acl_id`, `module`) to know which ACL ids came
   from which module.
2. If `domain_access` is enabled and `$op` is `update`/`delete`, add the user's accessible
   domain IDs into a forked copy of the grants (`domain_id` realm) — the comment notes this is
   because ACB's AND logic otherwise requires "Edit/Delete any domain content" perms.
3. For each bridged module, collect the user's `{realm, gid}` pairs belonging to that module
   (ACL entries filtered to that module's ids).
4. `$grants = array_merge($grants, _acb_cascade_grants(array_filter($split)))` — existing
   grants are **kept** and the cascaded `acb&…` grants are appended, so single-module nodes
   still work while multi-module nodes match the combined realms.

## `_acb_cascade_grants($grants, $access_records, …)`
Recursive cross-product over the per-module grant buckets.
- **Access-records mode** (`$access_records = TRUE`): one output record per full combination;
  `view/update/delete` are the running products (AND).
- **User-grants mode** (`FALSE`): recurses twice per element (realm present / realm absent),
  emitting a grant for every subset combination so a user matches any combined realm they
  satisfy.

## Lifecycle hooks (`acb.install`)
- `acb_install()` → `module_set_weight('acb', 500)` so ACB's alters run **after** every other
  module's grants/records are in place.
- `acb_enable()` / `acb_disable()` → `node_access_needs_rebuild(TRUE)`.
- `acb_modules_installed($modules)` (in `.module`) → rebuild flag when a newly installed
  module is one of the bridged access modules.

## Debugging tips
- Symptom "content unexpectedly hidden after enabling ACB" is expected: AND means every
  controlling module must grant. Check each module's own settings for the role/state.
- Behaviour only changes for nodes controlled by **2+** modules; single-module nodes are
  passed through verbatim.
- After any change, run `drush php-eval 'node_access_rebuild();'` (or the Rebuild permissions
  admin action) and verify the anonymous role explicitly.
