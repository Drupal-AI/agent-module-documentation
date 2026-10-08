<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Matomo Reporting API lets Drupal retrieve analytics reports from a Matomo instance's Reporting API, for displaying stats inside Drupal.

---

Matomo (formerly Piwik) is the privacy-friendly, self-hostable analytics platform, and beyond just sending it tracking data, sites often want to read the analytics back — to show popular content, a dashboard of visits, or per-node stats inside Drupal. Matomo Reporting API is the client for that: it authenticates to a Matomo instance's Reporting API and fetches report data for use in Drupal code, blocks or displays.

It is an integration library more than a finished feature — it provides the API client and the plumbing; what you show with the data is built on top (an example submodule illustrates usage). It needs a Matomo instance and an API auth token.

The security note is that **the Matomo auth token is a credential** — it grants read access to your analytics, which can itself be sensitive (visitor data, popular pages, referrers) — so it should be stored securely rather than in plain configuration that lands in git. Configure the token through a Key entity or environment where possible, and treat retrieved analytics as data that may carry its own privacy weight.

---

- Retrieve Matomo reports in Drupal.
- Show analytics inside Drupal.
- Display popular content.
- Build a visits dashboard.
- Fetch per-page stats.
- Query the Matomo Reporting API.
- Read analytics back from Matomo.
- Authenticate to Matomo.
- Store the Matomo token securely.
- Show referrer stats.
- Build a stats block.
- Integrate Matomo reporting.
- Display visit counts.
- Use the API client in code.
- Keep the auth token out of git.
- Report on content performance.
- Fetch report data.
- Show a popular-pages list.
- Consume Matomo analytics.
- Treat analytics as sensitive.