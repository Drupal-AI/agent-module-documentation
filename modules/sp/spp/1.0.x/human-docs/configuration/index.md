# Configuration

Single Page Protection is configured entirely by an administrator: you list the
internal paths you want to gate and give each one a password. Everything else —
hashing, flood protection, session handling — the module manages for you.

## Open the settings form

1. Log in as a user with permission to administer the module (administrators only
   by default).
2. Open the Single Page Protection settings form (route
   `single_page_protection.admin_settings`) from the module's configuration page.

## What you configure

- **Protected paths and their passwords** — specify the internal Drupal path(s) to
  protect and the password required for each. Paths are validated strictly as
  internal paths (no open redirects). When you save, the password is stored hashed
  with Drupal's password API; you never store the plain password.

## How the protection behaves

- A visitor requesting a protected path who has not yet unlocked it in their
  session is redirected to a password form before the page renders.
- The entered password is compared in constant time (`hash_equals()`), and the
  session remembers a successful unlock.
- **Flood protection** limits failures to five per hour, keyed by path and IP.
- If you later **change a page's password**, existing session unlocks for it are
  revoked automatically, so previously‑unlocked visitors must re‑enter it.
- A dedicated **bypass permission** lets chosen roles skip the gate.

## Remember the scope

This gates page **paths**, not the underlying content itself. If the content must
be truly confidential, confirm it is not reachable by another route (canonical
path vs alias, JSON:API/REST, feeds, other Views) and add real entity access on
top. For casual page‑gating, the path protection alone is enough.
