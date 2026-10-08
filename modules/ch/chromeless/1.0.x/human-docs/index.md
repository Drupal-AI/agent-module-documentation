# Chromeless — manual setup guide

**Chromeless** (`chromeless`) lets you render just the **main content** of a page —
no header, footer, sidebars, or other blocks — by adding `chromeless=1` to the
page's URL. It's designed for cases where you want to embed a Drupal page inside an
iframe, a print/PDF view, or another application, and you want only the content
without the surrounding site "chrome." When chromeless mode is active, every block
in the block layout other than the main content is hidden.

The module reads two query parameters:

- **`chromeless`** — its value decides whether chromeless mode is on or off. Any
  non-zero value counts as "on."
- **`title`** — its value decides whether the page title is shown or hidden while
  chromeless mode is active.

A useful detail: visiting a URL with either parameter **stores that preference for
the current session**, so subsequent page views stay chromeless (or not) until the
preference is changed. Preferences are kept in Drupal's private temp store for one
week by default.

The module works the moment you enable it — there is **no mandatory configuration**
and no admin settings page. It has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no admin settings page** for this module. The only optional tuning is
done in your site's `services.yml`, described below.

## How to use it

Add the query parameter to any page URL:

- `https://example.com/some/page?chromeless=1` — show only the main content.
- `https://example.com/some/page?chromeless=1&title=0` — main content only, with
  the page title hidden too.
- `https://example.com/some/page?chromeless=0` — turn chromeless mode back off.

The expressed preference is remembered for the session (about one week), so you
don't have to repeat the parameter on every request.

## Optional: rename or shorten the parameters

There is no UI for this, but two things can be tuned from your site-wide
`sites/default/services.yml`:

- **Rename the query parameters** by overriding the container parameters
  `chromeless.query.active` and `chromeless.query.title`.
- **Shorten how long preferences are kept.** They live in Drupal's private temp
  store for one week by default; if your chromeless pages are hit by a large number
  of distinct user agents, consider shortening the temp-store lifetime to keep that
  table from growing.

After editing `services.yml`, rebuild the cache (`drush cr`).
