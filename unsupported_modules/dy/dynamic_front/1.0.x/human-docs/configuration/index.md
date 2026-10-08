# Configuration

Dynamic front is configured in one place: an ordered list of candidate front‑page
paths. The order is the whole point — the module redirects each visitor to the
**first** path in the list they're allowed to access.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Dynamic front**, or navigate directly to
   `/admin/config/system/dynamic-front`.

## Set the candidate paths

- Enter your **candidate front‑page paths** as an **ordered list** of internal
  user‑input paths — for example `/dashboard`, `/welcome`, `/node/1`.
- **Order matters:** put the most specific audience match first. The module walks the
  list top to bottom and redirects to the first path the current user can access.
- Use real internal paths on your site. Each one is access‑checked before any
  redirect happens, so listing a path a user can't view simply means they fall
  through to the next candidate.

Click **Save** when done. Invalid configured URLs are logged to the `dynamic_front`
log channel, which is a useful place to look if a redirect isn't behaving.

## How the redirect behaves

When a visitor hits the front page, the module iterates your list in order, checks
access on each candidate, and issues a redirect to the first one that passes. If none
of them are viewable by that user, it returns an access‑denied response rather than
guessing. The redirect route is intentionally left uncached so it always reflects the
current user's access.

## Interaction with the core front‑page setting

While Dynamic front is enabled, it disables the core **front page** field on the Basic
site settings form and manages the behavior itself. If you want to return to a normal
static front page, disable this module — the standard front‑page field becomes
editable again.

> **Reminder:** for new work, migrate to **Dynamic Links** (`dynamic_links`), the
> supported successor to this obsolete module.
