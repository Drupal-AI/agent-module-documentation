# Configuration

The confirmation dialog works as soon as the module is enabled, for every content
type. The settings form lets you reword the prompt, switch on logging, and exclude
content types you would rather not confirm.

## Open the settings form

1. Log in as a user who can administer site configuration (an administrator by
   default).
2. Go to **Configuration → Content authoring → Confirm Unpublish**, or navigate
   directly to `/admin/config/content/confirm-unpublish`.

## The settings

- **Confirmation message** — the text shown in the dialog when someone unpublishes
  a node. Customise it to explain the consequence in your own words (for example,
  reminding editors that the page will disappear from menus and search).
- **Enable logging** — when ticked, each time a user confirms an unpublish a
  message is written to Drupal's database log. The entry records the user name and
  the node path, giving you a simple audit trail. You can read these at **Reports →
  Recent log messages** (`/admin/reports/dblog`). Leave it off if you do not need
  the record.
- **Exclude content types** — by default the dialog is shown for every content
  type. Select any types here to **exclude** them, and unpublishing content of
  those types will skip the confirmation. Everything not excluded keeps the dialog.

## Save

Click **Save configuration**. The changes take effect immediately the next time
someone unpublishes a node.

## Good to know

The dialog is a safeguard, not a hard stop — after confirming, the user still
completes the unpublish. If the dialog does not appear for a particular content
type, the most common reason is that the type has been added to the **Exclude
content types** list on this form.
