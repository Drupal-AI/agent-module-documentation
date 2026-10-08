<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reviews enables user reviews of content or entities.

---

Reviews enables users to review content/entities — submitting reviews (rating + text) on nodes or other
entities, so a site can collect and display user reviews (products, articles, etc.). It is configured at
`reviews.settings` and provides its own permissions, in the Other package.

Use it to collect user reviews. The security-relevant point: reviews are **user-submitted content**, so —
sanitize/escape review text when displaying (avoid stored XSS), moderate reviews (public reviews attract
spam/abuse — consider approval/flood control), and gate who can submit/moderate with its permissions. Review
content may include personal data. It has no access-control role beyond its permission. Configure the reviews
behaviour.

---

- Enable user reviews of content.
- Collect rating + text reviews.
- Display user reviews.
- Configure at reviews.settings.
- Provide its own permissions.
- Review nodes/entities.
- Sanitize/escape review text (stored XSS).
- Moderate reviews (spam/abuse).
- Consider approval/flood control.
- Gate who submits/moderates.
- Have no access-control role beyond permission.
- Handle reviews as user content.
- Collect reviews.
- Configure moderation.
- Handle user reviews.
- Display reviews.
- Configure reviews.
- Moderate submissions.
- Escape review content.
- Handle review content.
