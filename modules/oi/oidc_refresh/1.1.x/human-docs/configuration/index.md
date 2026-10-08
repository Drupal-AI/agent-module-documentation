# Configuration

OIDC Refresh has a small settings form where you control how often it refreshes the
session and whether it should only do so while the user is active. Open it from the
module's settings page in the admin interface (you'll need administrative access to
site configuration).

## Refresh interval

Set how often — in seconds — the module makes its background AJAX request. Each
request triggers the OIDC module's normal "do these tokens need refreshing?" logic.
Choose a value comfortably shorter than your OIDC token lifetime so the token is
refreshed before it can expire, but not so short that you generate needless traffic.

## Interaction‑only refresh

Optionally, restrict the refresh so it only fires when the user has actually
interacted with the page — a mouse move, click, touch, scroll, or keypress. Turning
this on is recommended.

## The trade‑off worth understanding

Keeping a session alive is convenient, but it has a security trade‑off: a session
that is refreshed indefinitely stays valid even if someone walks away from an
unlocked machine. Mitigate this by:

- turning on the **interaction‑only** option, so a genuinely idle tab stops being
  refreshed; and
- choosing a **sensible interval** rather than an aggressively short one.

This module stores no tokens itself — all token and session handling remains inside
the OIDC module; OIDC Refresh only triggers the refresh on a timer. There are no
credentials to store for this module.
