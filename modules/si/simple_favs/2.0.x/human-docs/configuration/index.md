# Configuration

Simple favourites works as soon as you place its blocks, but a short settings pass
lets you choose how favourites are stored and how the blocks look.

## Open the settings form

1. Log in as a user with the **Administer simple favs** permission.
2. Go to **Configuration → User interface → Simple Favs Settings**, or navigate
   directly to `/admin/config/simple_favs/settings`.

## The settings

- **Database storage for authenticated users** — when enabled, logged‑in users'
  favourites are saved in the database so they persist across sessions and devices.
  When disabled (or for anonymous visitors regardless of this setting), favourites
  fall back to a browser cookie. Anonymous users always use cookies — the module
  never writes database favourites for a user who is not logged in.
- **Maximum favourites shown** — a configurable limit on how many items the "My
  Favourites" block displays.
- **Markup, prefix/suffix and class name options** — several site‑builder settings
  let you customise the HTML wrappers and CSS class names used by the heart block
  and its JavaScript, so you can fit the markup to your theme.
- **Language / translation options** — a simple UI for configuring the labels for
  other languages.

Adjust these to taste and **Save**.

## How storage and scoping work

Every favourite is tied to the current user on the server side: the module reads the
user from the active session, never from the request, and it rejects attempts to
write database favourites as an anonymous user. Node favourites are kept in a
`simple_favs_user` table and arbitrary path/title favourites in a
`simple_favs_user_other` table (when database storage is on); otherwise a cookie is
used. Per‑user caches are invalidated when a user's favourites change, so blocks stay
correct without over‑caching.

## Notes for a security review

- **No cross‑user access.** Because favourites are scoped to the authenticated user
  server‑side, one user cannot read or modify another's list, and the one public
  endpoint returns only titles of published, access‑checked nodes.
- **Save endpoints.** The endpoints that save favourites are gated by the core
  *Access content* permission.
