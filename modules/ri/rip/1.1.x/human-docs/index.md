# Remove Invalid Permissions (RIP) — manual setup guide

**Remove Invalid Permissions** (`rip`) is a one-shot maintenance tool. When you uninstall a
module or a permission is renamed, the old permission string can linger inside your roles'
configuration (`user.role.*`). Those orphaned permissions cause schema/upgrade errors, show
up as noise in `drush cex` diffs, and can block a clean Drupal major-version upgrade. RIP
scans every user role, compares its stored permissions against the full set that installed
modules still define, and revokes any that no longer exist.

It gives you two ways to run the cleanup. A **Drush command** (`drush rip`) walks the roles
and prompts you to confirm each stale permission before removing it — good for a careful,
reviewed clean-up. An **admin form** at `/admin/people/rip` (a "RIP" tab on the People page)
runs the whole thing as a batch across all roles at once, with no per-item prompt, and reports
how many permissions it removed from how many roles.

There is no configuration and no settings to tune — you just trigger it. It defines no
permissions of its own; the admin form is gated by core's *Administer permissions*. Once your
roles are clean, export configuration so other environments inherit the fix, and you can
uninstall RIP entirely — it is designed to be a temporary tool you reach for around uninstalls
and upgrades. It works all the way back to Drupal 8 and up through Drupal 11.

This guide is written for a **human** using the admin UI or Drush. If you want terse,
token‑cheap references for an AI coding agent — including the programmatic batch service —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is nothing to configure — pick whichever entry point suits you.

### Option A — Drush (interactive, reviewed)

```bash
ddev drush remove-invalid-permissions   # canonical name
ddev drush rip                          # short alias
```

RIP loads every role, works out which of its permissions are no longer defined by any
installed module, and **prompts you for each one** (`Remove <permission> for <role>? (y/n)`).
Only the ones you confirm are revoked, and each role is saved after its review. Because it
prompts per permission, it is only partly suited to unattended CI in this version.

### Option B — admin batch form (all roles at once)

1. Log in as a user with core's **Administer permissions** permission.
2. Go to **People → RIP** (`/admin/people/rip`).
3. Click **Submit**. RIP runs a batch across every role, revoking all invalid permissions
   without prompting, and reports something like *"N invalid permissions from M roles
   successfully removed."*

### After cleanup

Export your configuration so the fix propagates to other environments:

```bash
ddev drush cex
```

RIP is a one-shot tool — once your roles are clean you can uninstall it:

```bash
ddev drush pmu rip -y
```
