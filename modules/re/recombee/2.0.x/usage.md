<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Recombee provides configurable recommendation blocks that display results from the Recombee recommendation service.

---

Recombee provides configurable recommendation blocks backed by Recombee — a hosted recommendation-
engine API — showing personalized "recommended for you" / "related items" results based on user behaviour.
It depends on JS Cookie and JSON Template (for client-side rendering) and is configured at
`recombee.settings`.

Use it to add personalized recommendations to a site. The security/privacy-relevant points are
significant: it sends **user interaction/behaviour data** (views, clicks, possibly identifiers) to
Recombee to power personalization, and it authenticates with Recombee API credentials — so store the
credentials as secrets, and obtain appropriate consent and disclose the data sharing (behavioural tracking
sent to a third party has GDPR/ePrivacy implications; gate it behind consent where required). It is a
recommendations/integration feature; configure the Recombee database/credentials and the recommendation
blocks.

---

- Show Recombee recommendations.
- Add recommendation blocks.
- Personalize 'recommended for you'.
- Depend on JS Cookie and JSON Template.
- Configure at recombee.settings.
- Store Recombee credentials as secrets.
- Send user behaviour to Recombee.
- Obtain consent for tracking.
- Disclose the data sharing.
- Gate behind consent where required.
- Power related-items blocks.
- Handle GDPR/ePrivacy implications.
- Track views/clicks for personalization.
- Configure the Recombee database.
- Display personalized results.
- Authenticate to Recombee.
- Add related content.
- Mind behavioural data to a third party.
- Configure recommendation blocks.
- Personalize content.
