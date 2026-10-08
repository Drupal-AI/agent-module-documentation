<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Guard MCP — the tools

Two Tool API plugins in `src/Plugin/tool/Tool/`, both extending `FieldGuardToolBase` and both
declared `operation: ToolOperation::Read`. They report on Field Guard's state; they never change
it, load an entity, or return a field value.

## Install & enable

`drush en field_guard_mcp`. Requires `field_guard`, `tool` (`>=1.0.0-beta8`) and `mcp_sentinel`
(`>=2.22.0`). Enabling registers the plugins but publishes nothing — enable each tool in your
site's MCP tool bridge configuration. Grant `use field guard mcp tools` (a restricted permission)
to the role your MCP credential uses; the map names which permissions unlock which fields, so
treat it as sensitive.

## `field_guard_list_guarded` — `ListGuardedTool`

Lists the fields Field Guard protects on an entity type.

- **Inputs:** `entity_type` (required, machine-name regex `/^[a-z][a-z0-9_]{0,127}$/D`), `bundle`
  (optional; omit for every bundle in the map).
- **Returns:** `{ entity_type, total, truncated, fields[] }`. Each field:
  `{ bundle, field, operations, view_exempt_own_subject }`, where `operations` is a map of only
  the guarded operations (`view`/`edit`) → permission name (`array_filter` drops NULL ones), and
  `view_exempt_own_subject` is true only when the `view` operation is guarded and the flag is set.
- **Source:** iterates `ProtectedFieldMap::guardedFields($entityType, $bundle)`; skips any bundle
  or field key that is not a machine name; caps output at `MAX_FIELDS = 500` and sets `truncated`
  when `total` exceeds what is returned.

## `field_guard_check_access` — `CheckAccessTool`

Reports the guard's verdict on named fields for the **account making the call, and no other**.

- **Inputs:** `entity_type` (required), `bundle` (required), `fields` (required list, 1–50,
  machine-name each), `operation` (required, `view` or `edit`).
- **Returns:** `{ entity_type, bundle, operation, fields[] }`. Each field:
  `{ field, guarded, allowed, permission, own_subject_exempt }`.
  - `guarded` = the field has a permission for this operation.
  - `allowed` = `ExplicitPermissionChecker::hasExplicitPermission($currentUser, $permission)` when
    guarded, else **`null`** (an unguarded field has no verdict — never `true`).
  - `permission` = the required permission name (or NULL).
  - `own_subject_exempt` = guarded, `view`, and the field carries the own-subject flag. The tool
    does **not** resolve who the subject of any record is.
- **Meaning:** this is Field Guard's verdict, not Drupal's full field-access result. `allowed: true`
  means Field Guard does not deny; entity access, other modules and field permissions still apply.
  Because it calls the same explicit-permission rule as the hook, uid 1 and an `is_admin` role read
  as denied unless a non-admin role holds the permission. Filtering/sorting a guarded field is
  refused for every account and the tool does not change that.

## Shared base — `FieldGuardToolBase`

Extends `McpGovernedToolBase` and uses `McpEntityToolTrait`. Enforces the module's guarantees:

- **Access:** `checkGovernedAccess()` / `checkGovernedDiscoveryAccess()` →
  `AccessResult::allowedIfHasPermission($account, 'use field guard mcp tools')` (max-age 0). A tool
  is listed only for an account that can run it.
- **Execution (`doExecute()`):** rechecks access for PHP callers (`ToolBase::execute()` does not
  call `access()`), resolves the MCP Sentinel profile (refuse if none), applies the profile's rate
  limit, runs `run()`, then refuses if the JSON result exceeds `resultLimit()` — the smaller of
  `MAX_RESULT_BYTES = 131072` and the exfiltration guard's `effectiveResponseSizeCap()` when
  present.
- **Refusals & logging:** every failure returns one fixed message
  (`"Field Guard operation refused. Check permissions, inputs and limits."`); a caught `\Throwable`
  is logged as class + basename(file) + line only — caller input, exception text and field values
  never reach a result or the log.
- **Validation:** `machineName()` enforces `/^[a-z][a-z0-9_]{0,127}$/D` on entity type, bundle and
  field names; `CheckAccessTool` additionally de-duplicates field names and caps at 50.

## Not available, by design

No tool writes the protected map or role permissions, reads a guarded value, checks access for
another user, or resolves own-subject ownership for an arbitrary entity — each would be a bypass
or an oracle. See the parent module's services in
[../../../../../1.3.x/agent/api/services.md](../../../../../1.3.x/agent/api/services.md).
