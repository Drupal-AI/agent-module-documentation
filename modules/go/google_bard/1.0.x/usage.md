<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Bard Integration lets a Drupal site send prompts to Google Bard and display the answer, using captured Google account session cookies for authentication rather than an official API.

---

It exposes a query form at /google-bard (perm 'access content') where a user types a message; on submit the module instantiates a Bard client that performs raw cURL calls to bard.google.com, seeding the request with two configured cookie values (__Secure-1PSID / __Secure-1PSIDTS) stored via the settings form at /admin/config/system/google-bard-settings (perm 'administer site configuration'). The response is parsed, converted from markdown to HTML, stored in shared Drupal state, and rendered back. Because it drives the consumer Bard web endpoint with account cookies, it is fragile and tied to one Google account; there is no official API key. Treat the configured cookies as full Google-account credentials. This module is best regarded as an experimental/demo integration; for production AI use, prefer an official provider (e.g. the Drupal AI module ecosystem).

---

- Add a simple 'ask Bard' form to a Drupal site.
- Prototype an AI chat feature quickly.
- Demo Google Bard responses inside the CMS.
- Let editors query Bard without leaving Drupal.
- Experiment with generative answers on a page.
- Render Bard markdown answers as HTML.
- Show the last Bard answer on the query page.
- Test conversational prompts against Bard.
- Provide a lightweight internal AI helper.
- Explore AI integration patterns in Drupal.
- Capture Bard replies for a proof of concept.
- Offer a basic Q&A box backed by Bard.
- Trial AI content ideation for authors.
- Wire a single Google account's Bard into a site.
- Evaluate feasibility before adopting an official AI provider.
- Generate draft text suggestions on demand.
