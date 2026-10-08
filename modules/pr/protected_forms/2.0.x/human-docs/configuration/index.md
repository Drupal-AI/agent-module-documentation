# Configuration

Protected Forms starts working with sensible defaults the moment you enable it. This
page covers how to tune those rules and manage who is affected.

## Open the settings form

1. Log in as a user with the **Administer protected forms** permission.
2. Go to **Configuration → Content authoring → Protected Forms**, or navigate directly
   to `/admin/config/content/protected_forms`.

## The settings

- **Allowed scripts** — the Unicode scripts that submissions are *permitted* to use
  (for example Latin, along with common symbol ranges). The filter samples characters
  from a submission and rejects it if any sampled character belongs to a script not on
  this list. On an English-only site, leaving this at Latin (plus symbols) blocks
  Cyrillic, CJK, and similar bot spam. Add scripts here (Greek, Arabic, and so on) if
  your audience legitimately writes in them.

- **Check quantity** — how many random characters are sampled for the language-script
  check (default 50). A higher number catches more but does slightly more work;
  a lower number is lighter but may miss short injected fragments.

- **Reject message** — the error message shown to a submitter whose post is blocked.
  Customise it to suit your site's tone.

- **Reject patterns** — your blocklist of spammy words and URL fragments (such as
  `http://`, `https://`, `www`, `mailto:`, and specific spam keywords). Enter them
  separated by commas or new lines. A submission is rejected if it matches any pattern
  (case-insensitive). This is where you maintain a site-specific list of the junk you
  keep seeing.

- **Allowed patterns** — a whitelist of strings that are stripped from the input
  *before* checking, so legitimate content that would otherwise trip a pattern is let
  through.

- **Excluded forms** — a list of form ids to skip entirely, one per line. Use this to
  turn protection off for a specific form while keeping it on everywhere else. Common
  entries exclude the login, registration, and password-reset forms.

- **Log rejected** — when enabled, every rejected submission is written to the "protected
  forms" logging channel (visible under **Reports → Recent log messages**), which is
  useful for reviewing false positives and tuning your patterns.

Click **Save configuration** when done. The settings live in the
`protected_forms.settings` config object and support config translation, so they can
be exported, deployed, and translated for multilingual sites.

## Which forms are protected

Protection is applied automatically to a form when all of these hold: it is not an
admin-route form and not a delete form; it is not in your **Excluded forms** list; the
current user does not hold the bypass permission (below); and the form id relates to
users, nodes, comments, contact messages, or webforms, or is the private-message add
form.

## What happens on a rejection

When a submission is blocked, the module shows your **Reject message** as a form error,
increments a running counter, and — if **Log rejected** is on — logs the event. The
counter is surfaced on the **Reports → Status report** page
(`/admin/reports/status`), so you can see at a glance how much spam has been stopped.

## Permissions

Two permissions, both at **People → Permissions**
(`/admin/people/permissions`):

- **Administer protected forms** — access this settings page and change the rules.
- **Bypass protected forms validation** — skip all checks. Grant this to trusted roles
  (for example editors or administrators) so their submissions are never filtered.

With Drush:

```bash
drush role:perm:add editor 'bypass protected forms validation'
```
