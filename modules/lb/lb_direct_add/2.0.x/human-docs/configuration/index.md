<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Layout Builder Direct Add works out of the box as a dropbutton. The settings form
offers a single presentation choice, and there are two permissions that control
access to the form and to the fallback chooser.

## Open the settings form

1. Log in as a user with the **Administer layout builder direct add settings**
   permission.
2. Go to **Configuration → Content authoring → Layout Builder Direct Add**, or
   navigate directly to `/admin/config/content/layout-builder-direct-add`.

## How to display list

This radio choice decides the shape of the widget that replaces the **Add block**
link:

- **Dropbutton** *(default)* — a compact core drop-button. The first block type shows
  as the main button and the rest appear in its drop-down arrow.
- **Popover menu** — a single labelled trigger link that, when clicked, reveals the
  full list of block types in a popover.

## Label name

This text field only applies when you choose **Popover menu**. It sets the text of
the popover's trigger link — the default is **Add block**, but you can change it to
something like *Add content*. It is ignored when the dropbutton style is selected.

## Save

Click **Save configuration**. The change is global and takes effect immediately in
every Layout Builder region — there is no per-entity or per-view-mode override.

## Setting it from the command line

If you prefer Drush:

```bash
# Switch to the popover menu with a custom trigger label:
drush cset lb_direct_add.settings use_label 1 -y
drush cset lb_direct_add.settings label 'Add content' -y

# Back to the default dropbutton:
drush cset lb_direct_add.settings use_label 0 -y
```

(`use_label` is `0` for the dropbutton and `1` for the popover menu.)

## Permissions

The module defines two permissions, set at **People → Permissions**
(`/admin/people/permissions`):

- **Administer layout builder direct add settings** — required to open the settings
  form above. Give it to administrators only.
- **Access layout builder direct add more options** — controls whether the **"More…"**
  link (which reopens the full core "Choose a block" chooser) appears in the
  direct-add widget. Roles **with** it get both the direct list and the fallback
  chooser; roles **without** it still get the direct list of inline block types but
  lose the fallback. Withhold it to restrict a role to just the pre-approved inline
  block types.
