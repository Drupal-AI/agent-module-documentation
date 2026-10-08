Real Name replaces the display name Drupal shows for a user with a name built from a configurable Token pattern over the user's fields (e.g. `[user:field_first] [user:field_last]`), so users are shown by a human-friendly name instead of their login username.

---

Real Name defines a single site-wide pattern stored in `realname.settings:pattern`. Whenever Drupal formats a username (via `hook_user_format_name_alter()`), the module runs the pattern through the Token system (plus inline Twig), strips HTML, collapses double spaces, and truncates to 255 characters to produce the user's "real name". Generated names are cached in a dedicated `{realname}` database table (keyed by uid) to avoid recomputing on every request, and are regenerated on user update, cleared on user delete. The pattern may reference any `user` token — profile fields, mail, uid, or the `[user:account-name]` login name as a fallback — but not `[user:name]` (which would recurse). A settings form at `/admin/config/people/realname` edits the pattern with a Token browser; changing it invalidates cached names so they rebuild on demand. The module also ships a `realname_update_realname_action` VBO/action to bulk-regenerate names, exposes the real name as a hidden `realname` user display component, and provides `hook_realname_pattern_alter()`, `hook_realname_alter()`, and `hook_realname_update()` for per-user customization.

---

- Show users' full names ("Jane Smith") throughout the site instead of their login name.
- Build a display name from first-name and last-name profile fields via a token pattern.
- Fall back to the login name with the `[user:account-name]` pattern when profile fields are empty.
- Display an email-based identity (`[user:mail]`) for internal or intranet sites.
- Add a suffix or prefix to every user name, e.g. `[user:field_first] [user:field_last] (Member)`.
- Keep author bylines on nodes and comments showing the real name automatically.
- Show real names in user reference autocomplete and administrative user lists.
- Present a consistent display name in emails and notifications that call `format_username()`.
- Localize or template a name with inline Twig inside the pattern.
- Bulk-regenerate all users' real names after changing the pattern using the provided action.
- Regenerate a single user's name programmatically after importing profile data.
- Migrate legacy real-name data using the `realname_replace_token` migrate process plugin.
- Expose the "Real name" field as a component on the user display view mode.
- Alter the pattern per-user (e.g. different format for staff vs. members) via `hook_realname_pattern_alter()`.
- Post-process a generated name (trim titles, normalize case) via `hook_realname_alter()`.
- React to name changes (sync to a CRM, invalidate a cache) via `hook_realname_update()`.
- Cache computed names in the `{realname}` table so heavy user lists stay fast.
- Gate who may edit the pattern with the `administer realname` permission.
- Provide a friendlier identity on community sites where usernames are cryptic handles.
- Standardize "Last, First" ordering for directories using a token pattern.
- Combine an honorific field with name fields for formal display.
- Drive the displayed name entirely from config so it can be deployed across environments.
- Rebuild names on demand simply by clearing the cached `{realname}` rows.
- Read the current site-wide name pattern from config for reporting or auditing.
