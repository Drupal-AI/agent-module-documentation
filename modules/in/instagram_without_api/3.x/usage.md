<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Instagram Without API displays Instagram images in a block by scraping the public profile, without using the Instagram API.

---

Showing an Instagram feed normally needs the Instagram API and its tokens. Instagram Without API avoids that by scraping the public profile page. Two things to weigh. First, fragility: scraping depends on Instagram's page structure and anti-scraping measures, so it breaks when Instagram changes or blocks it — it is inherently unreliable. Second, it makes the Drupal server fetch Instagram pages (an outbound request); confirm it uses TLS with verification and handles failure gracefully, and be aware scraping may violate Instagram's terms of service. For a low-stakes feed display where API setup is unwanted it works until it doesn't; for anything important, the official API is more reliable.

---

- Show Instagram images without the API.
- Scrape a public Instagram profile.
- Add an Instagram block.
- Avoid Instagram API tokens.
- Display a feed.
- Accept scraping fragility.
- Handle Instagram blocking it.
- Use TLS with verification.
- Consider terms of service.
- Prefer the API for reliability.
- Show recent posts.
- Fetch profile images.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.