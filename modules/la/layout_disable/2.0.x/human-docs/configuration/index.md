# Configuration

Layout Disable has a single admin form: a checklist of every layout on your site.

## Open the form

1. Log in as a user with the **Access layout_disable** permission
   (`access layout_disable`) — grant it at **People → Permissions**.
2. Go to **Configuration → User interface → Layout Disable**
   (`/admin/config/user-interface/layout-disable`).

## Disable a layout

The form lists every discovered layout plugin — core, theme, and contrib — as a
checkbox.

- **Tick a layout to disable it.** Disabled layouts are removed from every layout
  picker on the site (Layout Builder's section chooser, Display Suite, entity
  view display layout selectors, and so on).
- **Untick and save to re-enable** a layout.

Click **Save configuration** to apply. Two core-required layouts —
`layout_onecol` (one column) and `layout_builder_blank` — are intentionally left
off the list, because Drupal needs them; they can't be disabled.

## Good to know

- **Disabling never uninstalls anything.** It only hides the layout from
  selection. The module or theme that provides the layout keeps working, and any
  content already using a now-hidden layout continues to render.
- **The disabled list is stored in configuration** (`layout_disable.settings`), so
  it exports and imports with the rest of your config — handy for standardising
  available layouts across a multisite or between environments.
- **Changes take effect immediately.** Saving the form clears Drupal's cached
  layout definitions for you. If you ever change the setting outside this form
  (for example via imported config), clear the cache (**`drush cr`**) so the
  layout picker reflects it.
