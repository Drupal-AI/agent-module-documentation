# Configuration

All of Activity Emails' settings live on one small form.

## Open the settings form

1. Sign in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Activity Emails**, or navigate directly to
   `/admin/config/system/activity_emails`.

## The settings

- **Enabled** — the on/off switch. Notifications are only sent while this is on,
  so you can pause emails (for example during a bulk import) without uninstalling
  the module, then turn them back on later.
- **Email (recipient)** — the address that receives the notifications. You can
  enter **several recipients as a comma-separated list**. Because each message
  includes the acting user's email address in its body, only send to inboxes you
  trust.
- **Template** — the text of the notification message. This is your own wording;
  the module appends the changed item's absolute URL and the acting user's name
  and email to whatever you write here.

Click **Save** to store the settings.

## What triggers an email

Once enabled with a recipient set, an email is sent whenever a **node** or a
**user** entity is **created or updated**. The module automatically skips:

- changes made by **anonymous** users, and
- entities that have **no canonical URL** (such as paragraphs).

The "From" address is your site's configured email address. Delivery is
immediate and synchronous — one email per save — routed through the site's normal
mail system, so make sure outgoing mail works.

## Good to know

There is no per-content-type targeting beyond "nodes and users", no daily digest,
and no stored history — this is a live change feed, not an audit log. If you need
richer filtering or a persisted record, this module is not the right tool.
