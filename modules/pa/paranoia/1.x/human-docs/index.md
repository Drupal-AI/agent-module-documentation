# Paranoia — manual setup guide

**Paranoia** (`paranoia`) is a site-hardening module for sysadmins who do not want *anyone*
with CMS admin access to be able to run arbitrary PHP or escalate their own privileges. It is
aimed at multi-admin production sites where "administer permissions" shouldn't be a path to
executing code. The philosophy is defense-in-depth: it removes the tools and permissions that
turn an admin account into a code-execution or takeover vector.

Concretely, Paranoia does several things automatically once enabled. It **uninstalls the core
PHP module** (and `skinr_ui`) and **hides them** — along with Paranoia itself — from the module
install/uninstall pages so they can't simply be turned back on from the UI. It **strips the
"admin" (superuser-equivalent) flag** from every role and blocks any later attempt to mark a
role as admin, logging a security alert when someone tries. It rewrites the permissions form to
**remove a banned list of PHP/eval permissions**, force every `restrict access: true`
permission to stay off for Anonymous and Authenticated, and revoke those risky permissions from
all roles. It **protects the user/1 superuser account** (only user/1 can edit its own name,
email and password) and hides the admin-role selector on the account settings form. Finally it
**disables specified "risky" forms and routes** — such as Devel's "Execute PHP" — to block
one-off code execution and `unserialize()`-style RCE.

Be honest with yourself about the trade-off: this is a deliberately restrictive, opinionated
lockdown. By design it **cannot be uninstalled from the UI**, and re-enabling PHP or promoting
a role to admin is intentionally made difficult. The list of modules, permissions, routes and
forms it neutralizes is extensible via `hook_paranoia_*` hooks, so other modules (and you) can
register their own risky items.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   how to remove it (Drush only).

## How to use it

Paranoia has **no settings form** — enabling the module *is* the setup. The hardening applies
on install and is then enforced continuously through hooks. Here is what happens and what to
expect:

**Applied on install**

- The banned modules (default: `php` and `skinr_ui`) are uninstalled.
- The banned PHP/eval permissions are revoked from every role.
- The "admin" flag is cleared on all roles.

**Enforced continuously**

| What | Effect |
|---|---|
| Hidden modules | `paranoia`, `php` and `skinr_ui` no longer appear on the modules or uninstall pages. |
| Re-disable banned modules | If a banned module is enabled via the modules form, it is uninstalled again on submit. |
| Block admin-role grant | Any attempt to make a role "admin" is forced back off and logged as an alert on the `paranoia` channel. |
| Hide admin-role selector | The admin-role element is removed from the account settings form. |
| Protect user/1 | The name, email, password and current-password fields are hidden unless the current user *is* user/1. |
| Lock down permissions form | Banned permissions are removed from the form; every `restrict access: true` permission is disabled and unchecked for Anonymous/Authenticated; banned permissions are revoked from all roles on submit. |
| Re-check on module install | Risky permissions are stripped again whenever a module is installed. |
| Disable risky forms | Forms registered as risky (default: Devel's `devel_execute_php`) get access denied plus an always-fail validator. |
| Block routes | Routes registered as risky (default: `devel.execute_php`) are made inaccessible. |

**Default banned permissions** include *use PHP for settings* and *use text format php_code*
(core), *execute php code* (Devel), *use PHP for tracking visibility* (Google Analytics),
*administer bueditor*, and the PHP-pattern permissions from Auto Username and Auto Entity
Label.

**Status report.** Paranoia adds a check to **Reports → Status report** that raises an error if
the PHP module has been force-enabled directly in the database (bypassing Paranoia) — a useful
tamper signal.

**Configuration value.** The module ships one config value, `delete_blocked_users`, in
`paranoia.settings`. There is no UI to change it — it is a documented toggle only, adjustable
via config import or Drush if needed.

## Removing Paranoia

Paranoia intentionally does **not** appear on the uninstall form. Remove it from the command
line instead:

```bash
drush pm:uninstall paranoia
```

Alternatively, delete the module directory and clear the config cache. See
[Installation](installation/index.md) for more.
