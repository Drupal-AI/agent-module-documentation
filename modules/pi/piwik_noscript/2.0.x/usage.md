<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Matomo Noscript adds the `<noscript>` tracking image to every page, so Matomo counts visits from browsers and clients that do not run JavaScript.

---

Matomo's main tracker is JavaScript, and the standard install also emits a `<noscript>` fallback: a one-pixel image request carrying the same tracking parameters, which works because fetching an image needs no script engine. Who that actually captures is worth being clear about, because it is a smaller and stranger group than "users with JavaScript off" — text-mode browsers, some assistive setups, corporate environments with scripting restricted, privacy tooling that blocks scripts but permits images, and a good deal of automated traffic. The project name is the historical one: **Piwik was renamed Matomo in 2018**, and the module name preserves the old spelling while the description does not, which is a search hazard rather than a functional one. Version **2.0.1**, core requirement **`^11.1 || ^12`** — Drupal 11.1 or later, reaching into a major that does not exist yet. Two things to settle before adding it. **Consent applies to the noscript image exactly as it applies to the script** — it is a tracking request to a third-party endpoint regardless of how it is triggered, and a consent manager that blocks JavaScript trackers will not necessarily block an `<img>` in a `<noscript>` block, so this is a common way for tracking to continue after a visitor has declined. And the data it produces is **not comparable** with the main tracker's: no session stitching, no interaction events, no accurate bounce measurement, so it inflates visit counts with shallow records rather than adding equivalent detail.

---

- Track visitors without JavaScript.
- Add a Matomo noscript fallback.
- Count text-browser visits.
- Capture traffic from restricted environments.
- Complete a Matomo installation.
- Track visits where scripts are blocked.
- Add the standard noscript image.
- Support an accessibility-focused audit.
- Measure non-script traffic volume.
- Compare script and noscript counts.
- Support a privacy-conscious analytics setup.
- Add tracking for legacy clients.
- Meet an analytics completeness requirement.
- Track a kiosk browser.
- Support an intranet with locked-down browsers.
- Add a fallback to a Matomo rollout.
- Measure script-blocking prevalence.
- Complete a self-hosted analytics setup.
