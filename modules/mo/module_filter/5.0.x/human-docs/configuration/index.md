# Configuration — settings

Module Filter works out of the box, but a short settings page lets you decide how
much it changes the Extend page and whether it also enhances the permissions page.
You can safely leave the defaults in place; the options below are worth knowing if
you want to adjust the experience.

## Open the settings page

1. Go to **Configuration → User interface → Module filter**
   (`/admin/config/user-interface/module-filter`).

![The Module filter settings page](../images/settings.png)

The page is split into two boxes: **Extend** (how the modules page behaves) and
**Filters** (which other admin pages get a filter box).

## Extend

These settings apply to the **Extend** page (`/admin/modules`).

- **Enhance the Extend page with tabs** — on by default. When ticked, Module Filter
  applies its full set of Extend-page enhancements, including turning the long list
  of package fieldsets into a **tabbed layout** so you can move between packages
  quickly. Untick it to fall back to a plainer, flat modules list.
- **Always show the description details** — off by default. Module descriptions are
  normally collapsed; tick this to keep every module's description expanded so you
  can read them all without clicking.
- **Show module path in modules list** — off by default. When ticked, each module's
  relative path is shown in its row, which is handy for debugging or confirming
  exactly which copy of a module is installed.

## Filters

This box controls which other admin pages get a filter box.

- **Permissions** — on by default. When ticked, Module Filter adds a filter box to
  the **Permissions** page (`/admin/people/permissions`), so you can narrow a very
  long permissions table down to the module you care about. Untick it to leave the
  permissions page untouched.

## Save

Click **Save configuration** to apply your choices.

## Seeing the result

Head back to the **Extend** page (`/admin/modules`). The enhancement is visible as
a **search field at the top of the module list** — type part of a module's name and
non-matching modules disappear immediately. With **tabs** enabled, packages are
shown as vertical tabs so you can browse them one at a time or list every module
alphabetically. Module Filter also adds a status filter to the **update-status
report** so you can focus on projects that need attention.
