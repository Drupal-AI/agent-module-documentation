# Configuration

The core feature of Entity Reference Edit Link — the edit link inside reference
widgets — works as soon as the module is enabled, with nothing to configure.
The settings page exists for one **optional** extra: adding a reference link to
the content type's **Manage fields** page from the node edit form. If you never
open this form, the module still adds its edit links.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Navigate to `/admin/config/entity-reference-edit-link`.

## The "Manage fields" link option

The form lets you enable a link, shown on the node edit page, that jumps to the
content type's **Manage fields** administration page. This is a convenience for
site builders who frequently move between editing content and adjusting its
field configuration. It is disabled by default — enable it only if you want that
link to appear, then **Save**.

Because this link leads into field administration, it is only useful for users
who can administer content types; it does not grant any access, it merely
provides a shortcut.

## Save

Click **Save configuration**. The change takes effect immediately — reload a
node edit form to see (or hide) the "Manage fields" link.
