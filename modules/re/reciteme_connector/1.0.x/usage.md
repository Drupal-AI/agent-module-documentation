<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recite Me Connector

Recite Me Connector wires a Drupal site up to the [Recite Me](https://reciteme.com/) assistive
toolbar — a client-side widget that provides text-to-speech, translation, styling and reading
aids for visitors. The module stores the Recite Me **service URL** and **service key** in
configuration and exposes them to the browser via `drupalSettings`, then loads the Recite Me
JavaScript.

Provided pieces:
- An admin config form at `/admin/config/reciteme_connector/recitemeconfig` (permission
  *access administration pages*).
- A **ReciteMe block** that attaches the widget library when the site-wide toggle is on.
- Options for autoload, an enable-fragment CSS selector, widget text, and background/hover
  images for the launcher.

---

## Installation & configuration

- Install with `drush en reciteme_connector`.
- Visit the configuration form and enter the Recite Me **Service URL** and **Service Key**
  supplied by Recite Me, plus the target fragment selector and widget appearance options.
- Place the **ReciteMe block** in a region, or enable "Enable Recite me through out the site".
- The service URL and key are public client-side integration values (the widget runs in the
  browser); they are intentionally exposed in `drupalSettings`. The module makes no server-side
  HTTP calls, so there is no TLS/verification setting to harden.
- Uploaded launcher images are stored in `public://recite_me/`.

---

## Use cases

- Add the Recite Me assistive toolbar to a public-facing site.
- Improve accessibility with text-to-speech and reading aids for visitors.
- Offer on-page translation via the Recite Me widget.
- Provide dyslexia-friendly styling and text customisation.
- Meet accessibility/WCAG programme requirements with a hosted toolbar.
- Toggle the widget site-wide from a single checkbox.
- Restrict the widget to a specific page fragment via a CSS selector.
- Customise the launcher with background and hover images.
- Fall back to a text launcher label when no images are set.
- Autoload the toolbar without requiring a click.
- Place the launcher block in any theme region.
- Centralise the Recite Me key/URL in Drupal config.
- Roll out the toolbar across a multisite via config sync.
- Support public-sector accessibility compliance initiatives.
- Give visitors reading and comprehension support on content-heavy pages.
- Enable/disable the integration without code changes.
