<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Recombee provides Recombee integration as a Search API backend for indexing content, powering recommendation-based search.

---

Search API Recombee provides a Search API backend that indexes content into Recombee — the hosted
recommendation-engine service — so search/recommendation results can be powered by Recombee's
personalization. Content indexed via Search API is stored in Recombee and queried from it. It depends on
the Search API and Recombee modules and provides its own permissions.

Use it to power personalized search/recommendations with Recombee. The security/privacy-relevant points
are significant: indexed content is sent to and stored in Recombee, and personalization relies on **user
behaviour data** sent to Recombee — store the Recombee API credentials as secrets, obtain appropriate
consent and disclose the data sharing (behavioural tracking to a third party has GDPR/ePrivacy
implications), and consider data-residency. It is a search-backend integration; configure the Recombee
database/credentials and the index.

---

- Index content in Recombee.
- Power recommendation-based search.
- Provide a Search API backend.
- Depend on Search API and Recombee.
- Provide its own permissions.
- Store Recombee credentials as secrets.
- Send indexed content to Recombee.
- Send user behaviour to Recombee.
- Obtain consent and disclose sharing.
- Consider data residency.
- Personalize search results.
- Configure the Recombee database.
- Handle GDPR/ePrivacy implications.
- Query from Recombee.
- Index via Search API.
- Authenticate to Recombee.
- Support personalized search.
- Send content externally.
- Configure the index.
- Integrate Recombee search.
