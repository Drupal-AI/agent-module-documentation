# Configuration

Unused Modules has nothing to configure — no settings, no permissions of its own.
This page explains how to read its two reporting surfaces (the admin pages and the
Drush command) and, importantly, how to act on them safely.

## Who can see the report

Access is controlled by the core **Administer modules** permission, which
administrators already hold. There is no module-specific permission to grant.

## The admin report

Go to **Configuration → Development → Unused Modules**. The report has two axes:

**Projects vs Modules** (top tabs):

- **Projects** — groups modules into their downloadable Drupal.org project.
- **Modules** — lists individual modules.

**Fully disabled vs Also enabled** (sub-tabs):

- **Fully disabled** — the "safe to delete" view. The landing page,
  `/admin/config/development/unused_modules/projects/disabled`, shows projects
  where **no** module is enabled.
- **Also enabled** — the full picture: every project/module and whether it has any
  enabled modules.

| Page | Path | Shows |
|------|------|-------|
| Projects · Fully disabled | `/admin/config/development/unused_modules/projects/disabled` | Projects with no enabled modules — safe to delete. |
| Projects · All | `/admin/config/development/unused_modules/projects/all` | All projects and whether each has enabled modules. |
| Modules · Fully disabled | `/admin/config/development/unused_modules/modules/disabled` | Disabled modules that live in fully-disabled projects. |
| Modules · All | `/admin/config/development/unused_modules/modules/all` | All non-core modules with enabled / has-modules flags. |

The report is intentionally a heavy page load, because it scans your whole modules
tree.

## The Drush command

The same information is available from the command line — ideal for CI or scripts:

```bash
drush unused:modules projects disabled     # projects safe to delete (the default)
drush um                                    # shorthand for the line above
drush unused:modules projects all           # all projects + whether each has enabled modules
drush unused:modules modules disabled       # disabled modules inside fully-disabled projects
drush unused:modules modules all            # all non-core modules with flags
drush unused:modules projects disabled --format=json   # machine-readable
```

Arguments are `[projects|modules]` then `[disabled|all]` (both default to
`projects` / `disabled`). Aliases: `um`, `unused-modules`. The output columns are
project, module, enabled, has_modules, and path. When there's nothing to report it
cheerfully prints *"Hurray, no orphaned projects!"*.

> One subtlety: `modules disabled` only lists modules whose **project** has no
> enabled modules, so a disabled submodule of an otherwise-active project won't
> appear there — use `modules all` to see it.

## How "safe to delete" is decided

- A **module** counts as unused when it is disabled.
- A **project** is "safe to delete" only when **all** of its modules are disabled.
  For example, `admin_menu` is deletable only if both `admin_menu` and
  `admin_menu_toolbar` are disabled.
- **Core modules are never listed** — don't delete them.
- Grouping into projects uses each module's `.info.yml` `project` key, falling back
  to the Composer package name, then a `custom` bucket.

## Acting on the results safely

The module only reports; the removal is up to you. Follow the module's own advice:

1. **Back up** your code and database first.
2. **Uninstall** the modules (e.g. `drush pmu <module>`) before deleting anything.
3. Only then remove the project directory — and the matching Composer package.
4. Double-check the report again afterward.
