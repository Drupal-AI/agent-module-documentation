<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Screenshot One captures URL screenshots via the ScreenshotOne API, with an AI Automator.

---

Screenshot One generates screenshots from URLs using the ScreenshotOne service — providing an exposed API and an AI Automator type that captures a screenshot of a given URL and stores it as media, useful for automatically generating preview images of pages/links.

The URL is fetched by the external ScreenshotOne API (not the Drupal server, so no server-side SSRF), and the API key is stored via the Key module (env-backed). Settings are gated by `administer site configuration`. Depends on `key`; supports Drupal 10.3+ and 11.

---

- Generate screenshots from URLs.
- Use the ScreenshotOne service.
- Provide an AI Automator type.
- Store screenshots as media.
- Auto-generate preview images.
- Fetch via the external API (no server SSRF).
- Store the API key via Key (env-backed).
- Gate settings with `administer site configuration`.
- Depend on `key`.
- Support Drupal 10.3+ and 11.
- Capture page previews.
- Automate screenshot generation.
- Support media workflows
- Configure the API
- Keep the key secure.
- Screenshot links.
- Integrate ScreenshotOne.
- Produce previews
