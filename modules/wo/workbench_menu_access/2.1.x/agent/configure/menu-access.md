# Configure menu delegation

Two forms, both requiring `administer workbench menu access`. Prerequisite: at least one
Workbench Access **access scheme** entity must already exist (created via the `workbench_access`
module at `/admin/config/workflow/workbench_access`).

## 1. Pick the active scheme (site-wide)

Route `workbench_menu_access.admin` → `/admin/config/workflow/workbench_access/menu_settings`
(`WorkbenchMenuAccessSettingsForm`). A single `access_scheme` select; option `0` = "Do not
restrict menu access". Stored in config object:

```yaml
# workbench_menu_access.settings
access_scheme: editorial_sections   # the access_scheme entity id, or 0/unset = unrestricted
```

Drush equivalent:

```bash
ddev drush config:set workbench_menu_access.settings access_scheme editorial_sections -y
```

If no scheme entities exist the form shows "You must create an access scheme to continue."

## 2. Assign sections to a menu (per menu)

Route `workbench_menu_access.form` → `/admin/structure/menu/manage/{menu}/access`
(`WorkbenchMenuAccessMenuForm`), also reachable from the menu's *Workbench menu access* tab and
the "Access settings" operation on the menu list (shown only to holders of the permission).

A multi-select of the scheme's tree sections. Selecting one or more sections restricts *update*
of that menu (and its links) to users in those sections. **Selecting none leaves the menu
unrestricted** (only core `administer menu` applies). Saved as a third-party setting on the
`system.menu.<id>` config entity:

```yaml
# system.menu.main.third_party.workbench_menu_access
access_scheme:
  - marketing
  - press
```

The active scheme id itself is what the per-menu setting is validated against; changing the
active scheme changes which section ids are meaningful. If the site has no active scheme the
per-menu form shows a link back to the settings form instead of the section select.

## How enforcement resolves (read before relying on it)

`WorkbenchMenuAccessControlHandler::checkSections()`:
1. Default result is **allowed** (`TRUE`).
2. Only if the active scheme is set AND the menu has an `access_scheme` third-party setting does
   it load the scheme, fetch the user's sections, and return
   `AccessControlHierarchy::checkTree($scheme, $menu_sections, $user_sections)`.
3. `administer workbench menu access` / `bypass workbench access` short-circuit to core.

So an unconfigured menu (no sections) or an unconfigured site (no active scheme) is **not**
restricted by this module — it falls back to core's `administer menu` permission. Assign
sections to every menu you intend to lock down.

Config schema: `workbench_menu_access.schema.yml` (`workbench_menu_access.settings` +
`system.menu.*.third_party.workbench_menu_access`).
