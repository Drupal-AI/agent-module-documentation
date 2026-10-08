<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

The module has exactly one setting, and it is **on by default** — so most sites
never need to open this form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Layout Builder Admin Theme**, or
   navigate directly to `/admin/config/content/lbat`.

## The one setting

- **Enable admin theme for layout builder** *(checked by default)* — when ticked,
  Layout Builder editing screens render in your site's admin theme. Untick it to
  make Layout Builder editing use the front-end theme again (useful if you want to
  preview layout editing in the real front-end theme).

Click **Save configuration** to apply.

## Toggling from Drush

```bash
# turn OFF
drush config:set layout_builder_admin_theme.config lbat_enable_admin_theme false -y
# turn ON
drush config:set layout_builder_admin_theme.config lbat_enable_admin_theme true -y
# read it back
drush config:get layout_builder_admin_theme.config lbat_enable_admin_theme
```

> The module ships no config schema, so `drush config:set` prints a warning about
> a missing schema. The value still saves correctly — you can ignore the warning.

## Changing which theme is used

This form only turns the behavior on and off — it does not pick the theme. Layout
Builder editing uses whatever is set as your site's **admin theme**. To change it,
go to **Appearance** (`/admin/appearance`) and set a different admin theme (or run
`drush config:set system.theme admin <theme>`).
