# Configuration

Comment Notify Author has a single, small settings form with two toggles.

## Open the settings form

1. Log in as a user with the **Administer CNA configuration** permission.
2. Go to **Configuration → System → Comment Notify Author**, or navigate directly
   to `/admin/config/system/cna`.

## The two toggles

- **New comment** — when enabled, the node's author is emailed each time a new
  comment is posted on their content.
- **Update to the comment** — when enabled, the author is emailed when an existing
  comment on their content is updated. This only fires for **published**
  comments.

Enable either, both, or neither. There is no per-user opt-in/opt-out — these
toggles govern the behaviour site-wide.

## What the email looks like

- **Recipient:** the owner of the commented node, at their account email, in
  their preferred language where set.
- **From:** your site's configured email address (`system.site` mail).
- **Body:** the notifying user's name, the node title, and a link to the comment.

If the node owner has no valid email address, the send is skipped and logged —
so make sure your site's mail system is working and that author accounts have
valid emails.

## Save

Click **Save configuration**. Changes take effect immediately; the next matching
comment will trigger a notification.
