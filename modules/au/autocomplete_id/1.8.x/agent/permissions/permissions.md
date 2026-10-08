<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `autocomplete_id.permissions.yml`:

| Permission | Gates |
|---|---|
| `view entity autocomplete id results` | Whether the user actually **sees** ID-based autocomplete suggestions. Checked by both `EntityIdAutocompleteMatcher::access()` and the decorator. Without it, the field falls back to core label-only matching even when the ID widget/global mode is on. |
| `administer entity autocomplete id` | Access to the settings form `/admin/config/content/autocomplete-id` (route `autocomplete_id.settings`) where the global toggle lives. |

Notes:
- **The global flag also selects which matcher answers (1.8).** The per-field matcher requires the
  view permission **and** `autocomplete_id_global` = false; the global decorator requires the view
  permission **and** `autocomplete_id_global` = true. So both need the permission, but they are
  inverse on the flag (never both active for one request).
- Per-result `view` access is enforced independently of these permissions: the matcher calls
  `$entity->access('view', $currentUser)`, so a user can never surface an entity ID they lack view
  access to, regardless of the two permissions above.
- Grant `view entity autocomplete id results` to whichever editor roles should be able to reference
  by ID; keep `administer entity autocomplete id` to trusted admins.
