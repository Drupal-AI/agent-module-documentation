# Configuration

All of Disable Messages' behavior is set on one form.

## Open the settings form

1. Log in as a user with the **Administer disable messages** permission (an
   administrator by default).
2. Go to **Configuration → Development → Disable messages**, or navigate directly
   to `/admin/config/development/disable-messages`.

## The settings, field by field

- **Enable filtering** — the master switch. When off, no filtering happens at all
  and every message shows, but your patterns are kept — handy for turning
  suppression off quickly without deleting anything.
- **Messages to be disabled** — the heart of the module: a textarea where you list
  messages to hide, **one regular expression per line**. Patterns are matched
  against the *whole* message (they are anchored on save), so use `.*` for the
  parts that vary. For example, `Article .* has been created.` hides every "Article
  … has been created." confirmation. Invalid regular expressions are rejected when
  you save, so you get immediate feedback.
- **Ignore case** — when on, matching is case‑insensitive (so `article` matches
  `Article`). On by default.
- **Strip HTML tags** — removes HTML from a message before matching, so markup
  differences don't break your pattern. On by default.
- **Page filtering** — controls where filtering applies. You choose one of: all
  pages; all pages *except* a listed set; or *only* a listed set. When you pick one
  of the "listed" modes, you enter Drupal paths (one per line, `*` wildcard,
  `<front>` for the front page) — for example only on `/checkout/*`, or everywhere
  except `/admin/*`.
- **Users excluded from filtering** — a comma‑separated list of user IDs that are
  exempt from all filtering (for example `0,1` to leave anonymous and user 1
  unaffected, or the reverse).
- **Enable permission checking** — when on, whole message *types* are hidden from
  roles that lack the matching "view messages" permission (see below), independent
  of your text patterns.
- **Enable debug** — dumps a list of which messages were filtered and why into a
  div at the bottom of the page, so you can see what your patterns are catching.
- **Show debug div visibly** — shows that debug output on the page instead of
  hiding it (useful on a dev site while tuning patterns).

Save the form when you're done. (On save, the module compiles your textarea into
the anchored patterns it uses at runtime — so always edit patterns through the
form rather than the raw config.)

## Tips for writing patterns

- Because patterns match the *entire* message, include the full text (punctuation
  and all), and use `.*` for the variable parts.
- If **Strip HTML tags** is off, remember to account for any markup in the message.
- Turn on **Enable debug** while tuning; it shows exactly which messages matched.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

| Permission | What it controls |
|-----------|------------------|
| **Administer disable messages** | Access to the settings form above. |
| **View status messages** / **View warning messages** / **View error messages** | Only relevant when **Enable permission checking** is on: a role *without* one of these has that whole message type hidden. (All three are granted to every existing role on install.) |
| **Exclude from message filtering** | Users with this bypass all filtering — administrators get it by default, so admins keep seeing everything. |
