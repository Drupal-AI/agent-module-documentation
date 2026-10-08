# Matomo Noscript — manual setup guide

**Matomo Noscript** (`piwik_noscript`) adds Matomo's `<noscript>` tracking image to
the bottom of every page, so that visits from browsers and clients that do not run
JavaScript can still be counted by Matomo. Instead of loading Matomo's JavaScript
tracker (`piwik.js`/`matomo.js`), it uses Matomo's alternative image-tag syntax: a
tiny image request inside a `<noscript>` tag carries the same tracking parameters, and
fetching an image needs no script engine.

> **Name history:** Piwik was renamed **Matomo** in 2018. This project keeps the old
> `piwik_noscript` machine name while the description uses the new name — a search
> quirk, not a functional issue.

It works **with or without** the main Matomo module installed. If the Matomo module is
present, this module reads the site ID and Matomo URL from it. If it is not, you set a
couple of values in your site's `settings.php` instead (see below). When the Matomo
module is absent, it also uses a little JavaScript to track the referrer URL.

Two things are worth settling before you add it:

- **Consent applies to the noscript image just as it does to the script.** It is still
  a tracking request to a third-party endpoint, and a consent manager that blocks
  JavaScript trackers will **not necessarily** block an `<img>` inside a `<noscript>`
  block. That means tracking can continue after a visitor has declined — so make sure
  this fallback is covered by your consent tooling and privacy policy.
- **The data is not directly comparable** with the main tracker's: there is no session
  stitching, no interaction events, and no reliable bounce measurement. It tends to
  add shallow visit records rather than equivalent detail, and the audience it
  actually captures is a narrow, mixed group (text-mode browsers, some assistive
  setups, script-restricted corporate environments, script-blocking privacy tooling,
  and a fair amount of automated traffic).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no admin settings form**. Configuration comes either from the main Matomo
module or from a few `settings.php` values, described below.

## How to configure it

**If you use the Matomo module:** enable [`matomo`](https://www.drupal.org/project/matomo),
configure your Matomo site ID and server URL there as usual, and Matomo Noscript picks
those values up automatically — there is nothing further to set.

**If you do not use the Matomo module:** you must provide the equivalent settings in
your site's `settings.php` so the module knows which Matomo instance and site to send
the tracking image to (your Matomo server URL and site ID). Consult the module's
README for the exact `$settings`/`$config` keys and current syntax, then add them to
`settings.php` and clear the cache (`drush cr`).

Either way, once the values are in place the `<noscript>` tracking image is added to
every page automatically.
