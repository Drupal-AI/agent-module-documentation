# Configuration

Smart 404 needs **zero configuration to get started** — it logs 404s and lets you
create redirects the moment it is enabled. Everything on this page is optional
tuning, plus the permissions you'll want to set so the right people can use it.

## Permissions

Smart 404 provides three granular permissions, set at **People → Permissions**.
Because the 404 log can contain whatever visitors and bots probe for, grant these
only to trusted staff:

- **View the 404 overview** — read the list of logged 404 paths and their stats.
- **Create redirects from 404s** — turn a logged path into a redirect.
- **Manage Smart 404 settings** — change the retention, ignore-pattern and
  bot-handling options described below.

## Retention (automatic cleanup)

To stop the log growing forever, Smart 404 cleans itself up on cron. You can set:

- **Delete records older than N days** — drop entries once they pass a chosen age.
- **Maximum record count** — cap the total number of stored 404 entries, so the
  table never exceeds a size you're comfortable with.

Sensible behaviour applies out of the box, so you only need to touch these if you
want tighter or looser retention.

## Ignore patterns

Ignore patterns keep known false-positives out of the log entirely. They are
**glob patterns** — for example `/wp-admin/*` or `*.php` — matching the paths that
bots routinely probe but that will never be real pages on your site. Any request
matching an ignore pattern is never logged. Smart 404 ships with a sensible set of
defaults; add your own for anything specific to your site.

## Bot handling

Smart 404 categorises each visitor's user agent as **bot**, **browser** or
**unknown**, and stores only that category — never the raw user-agent string. You
can choose to:

- **Hide bot traffic from the overview**, so the list reflects real visitors, or
- **Exclude bots from logging entirely**, so bot-driven 404s never reach the table
  at all.

## Status and resolution

Every logged path has a **status**: **New**, **Ignored**, or **Resolved**. When
you create a redirect for a path it becomes *Resolved* and the entry links to the
redirect entity that fixed it, so you can always see which 404s you've already
handled. You can also mark a path *Ignored* from the overview's bulk actions
without creating an ignore pattern for it.

## A note on privacy

There is nothing to configure for privacy — it's built in. Smart 404 stores no IP
addresses, contacts no external services, keeps external referers as domain-only,
and discards raw user-agent strings as soon as they've been categorised. That
makes the log GDPR-friendly by default.
