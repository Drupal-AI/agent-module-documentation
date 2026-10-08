# Simplenews Stats — manual setup guide

**Simplenews Stats** (`simplenews_stats`) measures what happens after you send a
Simplenews newsletter. It rewrites the links in each mailing so clicks can be counted,
embeds a tracking image so opens can be counted, and then reports the results per
newsletter — giving a marketing team open and click figures without leaving Drupal.

The mechanism is the standard email-analytics one. A tracking pixel is served so that
loading it registers an open, and each link is routed through a click receiver that
records the click and then redirects the reader onward. Both of those routes are
public and uncached (a cached hit would be counted once and never again), because the
person opening the email is a mail recipient, not a logged-in site visitor — and the
click redirector is constrained to an allow-list of the newsletter's own links, so it
cannot be abused as an open redirect. Results are stored as entities (one per mailing,
plus a detail record per event) and surfaced both at a site-wide overview and as a tab
on each newsletter node. Two mail implementations ship so both the legacy mail system
and the newer Symfony Mailer are covered.

It depends on **Simplenews** (matching branch — use Simplenews 4.x with this 4.0.x
release) and requires Drupal 10 or 11. Note that the current release is
**`4.0.0-beta3` — a beta**, so treat it accordingly on production.

**A privacy point that is not optional to think about.** Open and click tracking
records how individual recipients behave, which is personal-data processing. A site
subject to GDPR needs a lawful basis for it and a privacy notice that covers it — this
is not a purely technical change, so do not switch it on without that in place.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The reporting overview lists your mailings and their figures at **Content → Simplenews
Stats** (`/admin/content/simplenews-stats`). Each newsletter node also gains a
**Simplenews Stats** tab (`/node/{node}/simplenews-stats`) showing that issue's
results.

## How to use it, and who can see what

Once enabled, tracking is applied to newsletters you send, and the figures accumulate
automatically. The interesting part is the granular permission set, which lets you
decide precisely who sees which data:

- **Administer simplenews stats** — the full administrative permission. It is marked
  restricted (high-privilege); grant it only to trusted roles.
- **Access simplenews stats overview** — see the site-wide overview.
- **Access simplenews stats results** — view the detailed results.
- **Access simplenews stats results editable node** — a narrower permission that lets
  an author see figures only for the newsletters they are allowed to edit, which is
  ideal for giving content authors visibility of their own mailings without exposing
  everyone else's.

There is also create/view/delete control over the stats entities themselves. Assign
these under **People → Permissions** to match how your team is organised.

> **Compatibility note:** this release is currently tied to MySQL/MariaDB and does not
> instantiate cleanly on PostgreSQL or SQLite. If your site runs on those databases,
> check the module's issue queue before relying on it.
