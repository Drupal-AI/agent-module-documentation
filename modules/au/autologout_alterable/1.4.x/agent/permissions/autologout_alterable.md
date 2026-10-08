# Autologout Alterable — permissions

From `autologout_alterable.permissions.yml` (none are flagged `restrict access: true`):

| Permission | Gates |
|---|---|
| `administer autologout_alterable` | Access the settings form (`autologout_alterable.settings_form`); edit any user's logout threshold on the user form. |
| `change own autologout_alterable threshold` | Set one's **own** per-user logout threshold on the user edit form (only when `use_individual_logout_threshold` is enabled). Effect is scoped to the acting user's own account and bounded by `max_session_timeout`. |
| `autologout_alterable infinite session timeout` | The holder is **never auto-logged-out by this module** due to inactivity (title "Infinite session timeout"). Other modules may still alter/expire the session; only effective in combination with `use_infinite_session_for_privileged`. |

Notes:
- `change own …` is deliberately self-scoped: `AutologoutHooks::formUserFormAlter` /
  `userProfileSubmit` check both the permission AND `currentUser->id() == $user_id` before allowing edit
  of the field (admins use `administer autologout_alterable` to edit others). So it does not let a user
  change another account's threshold.
- `autologout_alterable infinite session timeout` only suppresses *this module's* inactivity logout; it
  is not a general privilege escalation and its own description states other modules may still log the
  user out. Grant it to roles (e.g. long-running admin/service accounts) that legitimately need
  no idle timeout, keeping in mind those sessions then rely on other controls to end.
