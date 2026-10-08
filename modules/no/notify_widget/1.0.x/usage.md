Notify Widget stores per-user notifications in the database and displays them through a header widget (an icon with an unread-count badge and a dropdown popup), plus a `notify_widget.api` service other code calls to send them.

---

Notify Widget is an in-site notification centre. It provides its own database table (`notify_widget`) keyed by user ID, a service (`notify_widget.api`) with a `send()` method that other modules or custom code call to record a notification for one user or many, and a block ("Notify Widget") that renders a notifications icon with an iOS-style red unread-count badge and a dropdown popup listing recent notifications. Each notification carries a source, a type, a title, body text, an optional click-through link and a timestamp; clicking a notification's link marks it read and redirects to the link. A full-page list at `/user/{user}/notifications` lets a user page through, mark individual notifications read or unread, mark all read, and delete one or all of their notifications. A settings form controls how many notifications the popup shows, whether read notifications appear, a read cut-off window, an optional automatic purge of old notifications, and whether the module's bundled CSS is used. A bulk "Send notification to selected user(s)" action is available on the People admin listing for sending an ad-hoc message to chosen accounts. Notifications are always scoped to their owning user, both when displayed and when acted on.

---

- Give authenticated users an in-site notification centre without building the UI yourself.
- Add a notifications icon with an unread-count badge to your site header via the block layout.
- Send a notification to a single user from custom code: `\Drupal::service('notify_widget.api')->send($source, $type, $title, $text, $uid, $link)`.
- Send the same notification to many users at once by passing an array of user IDs.
- Notify a user that their submission was reviewed or their content was published.
- Alert a user to an account change (password expiry, role change, email change).
- Tell a user that content they follow was updated, linking straight to it.
- Attach a click-through link so a notification takes the user to the relevant page.
- Automatically mark a notification read when the user clicks its link.
- Let users browse all their notifications on a paged full-page list.
- Let users mark individual notifications as read or unread from a dropbutton menu.
- Let a user mark all their notifications read in one click.
- Let a user delete a single notification, or delete all of theirs at once.
- Show or hide already-read notifications in the popup via configuration.
- Limit the popup to notifications read within a chosen window (15 minutes to 1 week).
- Cap how many notifications the popup lists (1–5000).
- Automatically purge notifications older than a configured number of days.
- Send an ad-hoc message to selected accounts using the People bulk-action.
- Categorise notifications by type (e.g. warning/alert/add) to drive per-type icon styling.
- Use the bundled CSS for a ready-made popup, or disable it and style `#notify_widget` in your own theme.
- Show relative "time ago" labels (e.g. "5 minutes ago", "Yesterday") in the popup.
- Tag the source of each notification with the raising module's name for future filtering.
- Cache the widget per user so notification rendering stays cheap.
