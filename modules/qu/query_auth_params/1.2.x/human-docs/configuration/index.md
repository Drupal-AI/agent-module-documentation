# Configuration

All setup happens on one form, where you add a rule for each page you want to gate.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Query Auth Params**, or navigate directly
   to `/admin/config/development/query_auth_params`.

Use the **Add** button to add another protected page (the form adds rows via AJAX),
and remove a row to stop gating that page.

## The fields for each rule

- **Url to apply** — the relative path you want to gate, starting with `/`. The
  form validates it against Drupal's path validator, and either the system path
  (for example `/node/203`) or its alias (`/mathematics`) works — they are
  interchangeable. The module also prevents duplicate path entries.
- **Query param name** — the parameter key a visitor must supply. Maximum **10
  characters, alphanumeric only**.
- **Query param value** — the value that key must have. Also maximum **10
  characters, alphanumeric only**. The module compares the incoming value with a
  strict match, so it must match exactly.
- **Display options** — how long the gate stays open once opened:
  - **forever** — the page is always reachable with the correct parameter.
  - **once** — after the first successful view, a `shown` flag is set and every
    later visit is redirected, even with the correct parameter.
  - **until a specific datetime** (`datetime_period`) — pick a date and time; once
    that moment passes, the page is no longer gated at all.
- **Redirect URL** — where visitors without the correct parameter are sent.
  Optional; defaults to the front page (`/`).

Click **Save configuration** when you are done.

## How it behaves

When someone requests a gated path, the module resolves the current path (and its
alias) against your rules. On a match it turns off the front‑end page cache for that
request and checks whether the incoming `?name=value` matches exactly. If it does,
the page is shown; if not, the visitor is redirected to your redirect URL (or the
front page). Examples:

- Allowed: `/mathematics?access=secret123`
- Redirected: `/mathematics` (missing or wrong parameter)

## A reminder on secrecy

This gate only redirects — it does not change route or entity access, and the
secret is visible in the URL (and therefore in history, `Referer` headers, and
server logs). With the ten‑character alphanumeric limit it is a low‑entropy shared
secret. Use it for soft launches and preview links, not for confidential content.
