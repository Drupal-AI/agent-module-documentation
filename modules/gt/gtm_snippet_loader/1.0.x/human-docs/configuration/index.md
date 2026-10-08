# Configuration

## Open the configuration page

1. Log in as a **fully trusted administrator** — this permission lets a user inject
   JavaScript and HTML into every page, so grant it sparingly.
2. Go to **Configuration → System → GTM Snippet Loader**
   (`/admin/config/system/gtm-snippet-loader`).

## Fields on the form

- **Head snippet** — the trusted snippet to place in the document `<head>`. For
  Google Tag Manager this is the main container script GTM gives you.
- **Body‑open snippet** — optional markup placed immediately after the opening
  `<body>` tag. This is where GTM's `noscript` fallback goes, and it is also the
  right place for any other body‑open tag‑manager markup.
- **Exclude administration routes** — when enabled, the snippet is not added on
  Drupal admin pages, so your tracking doesn't fire while editors work in the back
  office.
- **Excluded paths** — configurable path patterns where the snippet should *not*
  appear, for finer control (for example, excluding a particular section or a
  transactional page).

## Placement mode

- **Automatic injection** (recommended for most sites) — the module injects the
  head and body snippets into the response for you, no theme changes needed.
- **Theme‑controlled placement** — for stricter control over exactly where the
  markup lands, your theme can render the variables the module provides in its page
  templates instead of relying on automatic injection.

## Deployment

Everything here is stored as Drupal configuration, so it exports and imports with
`drush config:export` / `config:import` like the rest of your site. Combine that
with **Config Split** or **Config Ignore** (see
[Installation](../installation/index.md)) if the snippet needs to differ between
environments.

## Privacy reminder

Loading a tag manager typically means loading third‑party trackers and setting
cookies. Make sure a **cookie‑consent** mechanism is in place and that the tracking
is disclosed to visitors before the snippet goes live.
