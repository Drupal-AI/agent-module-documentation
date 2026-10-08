# Configuration

Follower Notification has a single settings form controlling **which content
triggers notifications** and **how comment notifications are delivered**.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission (an
   administrator by default).
2. Go to **Configuration → Follower Notifications → Admin settings**, or navigate
   directly to `/admin/config/follower_notifications/adminsettings`.

## Which content types trigger follower notifications

Choose the content types that should notify a member's followers when the member
publishes one. When a member publishes a node of a selected type, each follower
(a user who has followed that member via Flag Follower) receives a notification.

Only **published** content triggers notifications, and the author is not notified
about their own actions.

## How comment notifications are delivered

When someone comments on a member's content, the content's author is notified. Use
the **comment notification** option to choose how that notification is delivered:

- **Bell** — an on-site bell notification only.
- **Mail** — an email only (localised through the module's mail handling, sent
  from the site's email address).
- **Both** — a bell notification and an email.

## Save

Click **Save configuration**. Your choices take effect immediately for
subsequently published content and new comments.

## Good to know

- The module maintains its own `notifications` database table (created when you
  enable the module); it is not standard exported configuration.
- Notifications are marked as read when the recipient views the target content.
- The bell notification count/popup is rendered through the module's theme hook —
  make sure it is placed or themed where users can see it.
