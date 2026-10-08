<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ShURLy runs a URL shortening service on a Drupal site — short links on the site's own domain, with per-user ownership, custom aliases and click analytics.

---

Organisations want short links on their own domain rather than a third party's for reasons that are mostly about trust and measurement: a link reading `example.org/summer` is recognisable in print, on a poster or read aloud, it does not depend on a shortening service still existing in five years, and the click data stays with the organisation rather than with a vendor. This supplies that, with `shurly_analytics` for click statistics and `shurly_service` for programmatic creation, depending on core `views`. Version **8.x-1.0-beta4** — a **beta**, and the most recent release is from 2024. **The premise deserves stating because it is easy to miss: a URL shortener is an open redirect with a permission on it.** Anyone holding `create short URLs` can point the organisation's own domain at anything, which is exactly what a phishing campaign wants — a link that passes a "is this a domain I trust" check and lands somewhere else. Links are permanent and public once created, there is no expiry in the model, and destinations can usually be edited after a link has been shared, so a link reviewed at creation is not necessarily pointing where it was reviewed to point. Treat `create short URLs` as a reputation-bearing permission. Two defects to know about: `/shurly/edit/{rid}` returns a **500 to anonymous requests** when the id is non-numeric, because the access callback has no `else` branch and returns NULL instead of an access result; and the same callback reads a database row without checking the query matched, which fails closed but emits a warning.

---

- Create short links on your own domain.
- Shorten a URL for a printed campaign.
- Make a memorable link for a poster.
- Track clicks on a campaign link.
- Replace a third-party shortener.
- Keep click data in-house.
- Create a custom short alias.
- Share a short link on social media.
- Shorten a long report URL.
- Create a link for a QR code.
- Track a newsletter link's clicks.
- Give staff their own short links.
- Create a link readable aloud on radio.
- Shorten a deep documentation URL.
- Track a conference handout's link.
- Create a redirect for an event.
- Provide short links via an API.
- Manage an organisation's link inventory.
