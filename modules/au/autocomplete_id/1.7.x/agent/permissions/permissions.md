<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `autocomplete_id.permissions.yml`:

| Permission | Gates |
|---|---|
| `view entity autocomplete id results` | Whether the user actually **sees** ID-based autocomplete suggestions. Checked by `EntityIdAutocompleteMatcher::access()`. Without it, the field falls back to core label-only matching even when the ID widget/global mode is on. |
| `administer entity autocomplete id` | Access to the settings form `/admin/config/content/autocomplete-id` (route `autocomplete_id.settings`) where the global toggle lives. |

Notes:
- The global decorator additionally requires the `autocomplete_id_global` config flag to be `true`
  **and** the viewing user to hold `view entity autocomplete id results` — both, not either.
- Per-result `view` access is enforced independently of these permissions: the matcher calls
  `$entity->access('view', $currentUser)`, so a user can never surface an entity ID they lack view
  access to, regardless of the two permissions above.
- Grant `view entity autocomplete id results` to whichever editor roles should be able to reference
  by ID; keep `administer entity autocomplete id` to trusted admins.
