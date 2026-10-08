# Configuration

Redirect Regex has no settings page. You configure it one redirect at a time, on
the Redirect module's normal add/edit form, by turning an ordinary redirect into
a regex redirect.

## Create a regex redirect

1. Go to **Configuration → Search and metadata → URL redirects → Add redirect**
   (`/admin/config/search/redirect/add`).
2. In the **From** (source) field, enter your pattern — for example
   `user/\d+/profile`.
3. Set the **To** field to the redirect target.
4. Tick the **Regular expression** checkbox to enable regex matching for this
   redirect.
5. Save.

Internally the source is stored with a `regex:` prefix so the module knows to
treat it as a pattern; you don't type that prefix yourself.

### Important rules for the source pattern

- **Do not include a leading slash.** Use `user/\d+/profile`, not
  `/user/\d+/profile` — the redirect system strips leading slashes before
  matching.
- Patterns are matched against the **entire path** and are **case‑insensitive**.
- **Multilingual:** patterns are tested against both the current path and the
  path with a language prefix (for example `user/123/profile` and
  `en/user/123/profile`).
- To redirect from existing routes, enable **"Allow redirects from aliases"** in
  the Redirect module's settings.

## Substituting captured groups into the destination

You can capture parts of the matched path and reuse them in the destination:

| Source pattern | Destination | What it does |
|---|---|---|
| `blog/\d+/.*` | `/blog/archive` | Sends all old blog URLs to one archive page |
| `user/\d+/profile` | `/user/profile` | Collapses per‑user profile URLs |
| `legacy/(\d+)` | `/migrated/$1` | Reuses the captured id positionally |
| `legacy/(?'id'\d+)` | `/migrated/$id` | Reuses the captured id by its named group |

Both positional (`$1`) and named (`$id`) references work.

## Write safe patterns

A regular expression is powerful, so two habits keep you out of trouble:

- **Guard against catastrophic backtracking (ReDoS).** Avoid patterns with
  nested or ambiguous quantifiers that can blow up on crafted request paths —
  that is effectively a self‑inflicted denial of service. Prefer **anchored,
  specific** patterns (for example, match `\d+` rather than `.*` where you mean
  digits). The module validates that your regex is syntactically valid, but it
  cannot judge whether it is efficient.
- **Avoid open redirects.** Because a destination can be built from captured
  groups and is emitted as a *trusted* redirect response (which is allowed to
  point off‑site), never let an attacker‑influenced capture group form the host
  part of an external URL. Keep the host portion of destinations fixed and anchor
  your patterns so captures only ever contain the values you expect.
