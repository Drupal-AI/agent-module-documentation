# Configuration

Notify Widget has a small settings form. It does not control *which*
notifications are sent — that is done from code through the `notify_widget.api`
service — but it does control how the widget behaves and looks.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Notify Widget Settings**.

## Settings

- **Maximum number of notifications** — caps how many notifications the widget
  keeps and shows per user. This is your main lever against clutter and unbounded
  growth: a sensible limit stops notifications accumulating forever and keeps the
  dropdown readable. Choose a value that reflects how noisy your notifications
  are.
- **Use the included CSS** — when enabled, the widget uses the stylesheet that
  ships with the module, giving you the badge and dropdown styling out of the
  box. If you **turn this off**, the module outputs no styling of its own and you
  must style the notifications in your own theme. Leave it on unless you have a
  specific reason to take over the styling.

## Save

Click **Save configuration**. Changes take effect immediately — reload a page
with the Notify Widget block to see them.
