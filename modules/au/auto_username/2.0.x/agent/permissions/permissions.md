# Auto Username — permissions

From `auto_username.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer auto username` | **TRUE** | Access the settings form at `/admin/config/people/accounts/patterns` (route `auto_username.admin_config`). |
| `bypass auto_username` | (none) | Users holding this are **skipped** by name generation on insert/update — their `name` is never overwritten. Grant to admins/system accounts whose usernames must stay fixed. |
| `use PHP for username patterns` | **TRUE** | Intended to gate PHP evaluation of the pattern. Effective PHP eval also requires `aun_php` = TRUE and the contrib `php` module enabled (`autoUsernameEval()` only runs `php_eval()` when `php` exists). |

Notes:
- `bypass auto_username` is the one non-restricted permission. It only *exempts* a user from renaming
  (a safe, self-limiting capability), so granting it more widely does not expand attack surface.
- The bulk Action `auto_username_rename_action` is not gated by a module permission; its access derives
  from the target user's edit/update access (see `configure/settings.md`).
