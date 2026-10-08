# Configuration

Admin notification is controlled by one small settings form. Whatever you set here is
stored and applied on every page request for logged‑in users until you change it.

## Open the settings form

1. Log in as a user with the **administer admin notification** permission.
2. Go to **Configuration → System → Admin notification**, or navigate directly to
   `/admin/config/system/admin_notification`.

## The fields

The form has three settings:

- **Enabled** — the on/off switch for the whole notice. When ticked (and the message
  is not empty), the message is shown to every authenticated user on each page load.
  Untick it to stop the notice immediately without having to delete your message text.

- **Message** — the text of the notice itself. Keep it short, since it appears in
  Drupal's standard messages area at the top of the page. The text is displayed
  verbatim to logged‑in users, so treat this as trusted admin‑only input and only let
  people you trust edit it.

- **Type** — the severity/style of the message, matching Drupal's three standard
  message types:
  - **Status** — a neutral, informational notice (the usual choice for
    announcements).
  - **Warning** — a more prominent, cautionary style for things people should not
    miss.
  - **Error** — the most attention‑grabbing style, for an urgent issue.

## Save and verify

Click **Save configuration**. The notice takes effect right away: reload any page as
a logged‑in user and you should see your message in the chosen style at the top. It
will reappear on each page load until you untick **Enabled** (or clear the message)
and save again.

Remember that **anonymous visitors never see the notice** — only authenticated users
do. This is by design.
