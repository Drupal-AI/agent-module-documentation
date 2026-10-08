# Configuration

User Protect is configured through **protection rules**. Each rule says *what* is
protected (which fields/operations) and *who* it applies to (one user or a whole
role).

## Manage protection rules

1. Log in as a user with the **Administer user protection rules**
   (`userprotect.administer`) permission.
2. Go to **Configuration → People → User protect**
   (`/admin/config/people/userprotect`). You'll see the list of existing rules.
3. Click **Add protection rule** to create one.

### Creating a rule

A rule has two parts:

**Who it protects (the target):**

- **A single user** — protects one specific account (for example your `admin`
  account).
- **A role** — protects *every* user who has that role at once (for example lock
  all Administrators' email addresses).

**What it protects (the protections):** tick any combination of the seven shipped
protections:

| Protection | Locks |
|------------|-------|
| **Username** | The account's username field. |
| **Email address** | The email field. |
| **Password** | The password field (stops others resetting it). |
| **Status** | The active/blocked status. |
| **Roles** | The roles field (blocks privilege changes; also covers Role Delegation's role-change field). |
| **Edit operation** | The whole edit form (`user/X/edit`). |
| **Cancel operation** | Account cancellation/deletion (`user/X/cancel`). |

When someone other than the exempt accounts edits a protected user, the protected
fields are disabled or hidden on the form, and any blocked operation is denied.

You can also **disable** a rule temporarily (via its status) without deleting it.
Rules are cleaned up automatically if the user or role they target is deleted.

## When a rule does *not* apply (exceptions)

A protection rule is deliberately skipped in these cases:

- The person doing the editing is **user 1** (the super admin) — always exempt.
- The person doing the editing holds the global **Bypass all user protection**
  (`userprotect.bypass_all`) permission.
- The person doing the editing holds that rule's **own bypass permission** (see
  below).
- The target user is **editing their own account** — self-editing is governed by
  separate permissions, not by rules.

## The permissions

Grant these on **People → Permissions**:

| Permission | Grants |
|------------|--------|
| **Administer user protection rules** (`userprotect.administer`) | Create/edit/delete rules and reach the whole User Protect admin UI. Security-sensitive. |
| **Bypass all user protection** (`userprotect.bypass_all`) | Ignore *every* protection rule. Give this only to a trusted super-admin role. Security-sensitive. |
| **Edit own account** (`userprotect.account.edit`) | Let a user edit their own account. |
| **Change own e-mail** (`userprotect.mail.edit`) | Let a user change their own email address. |
| **Change own password** (`userprotect.pass.edit`) | Let a user change their own password. |
| **Bypass user protection for _{rule}_** (`userprotect.{rule}.bypass`) | Generated automatically for each rule you save — holders bypass that one rule. |

The three "own" permissions matter because rules never restrict self-editing — so
if you want users to still be able to change their own email or password, grant
the corresponding permission. (Changing your own username still uses core's
*Change own username*, and cancelling your own account uses core's *Cancel
account*.)

### Per-rule bypass

Every time you save a rule, User Protect creates a dedicated bypass permission for
it, titled "Bypass user protection for _{label}_". Assign it to a role on the
permissions page to exempt that role from just that rule — a clean way to let one
trusted team work around a specific protection without granting the global bypass.

## Settings form

At **Configuration → People → User protect → Settings**
(`/admin/config/people/userprotect/settings`) there is one option:

- **Display applied-protections message** *(on by default)* — when on, an
  administrator (with *Administer users*) editing a protected account sees a
  message listing which protections were applied. Turn it off to keep the edit
  form quiet.

## Deploying

Both the settings and every protection rule are configuration, so they export and
deploy between environments with `drush config:export` / `config:import`.

## For developers

Protections are a plugin type (`user_protection`), so a custom module can add its
own protection (a new field or operation to lock) and it will appear as a
selectable option when building a rule. See the sibling
[`agent/plugins/plugins.md`](../agent/plugins/plugins.md) reference for the plugin
contract.
