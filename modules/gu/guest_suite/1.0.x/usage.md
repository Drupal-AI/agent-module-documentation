<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Guest suite integrates a Drupal site with the Guest Suite reviews platform. It defines a `guest_suite_review` content entity, an API consumer that pulls reviews and establishment statistics from the Guest Suite REST API, cron-driven import queues, and tokens for the average rating and total review count.

---

The `ApiConsumer` service calls `https://wire.guest-suite.com/rest/` endpoints (`reviews`, `establishments`, `establishment`, `establishments/statistics`) over HTTPS using the Drupal HTTP client, authenticating with an `access_token` stored in `guest_suite.settings` config and passed as a query parameter. On cron, the `Cron` service enqueues fetch/import jobs into `guest_suite_review_fetcher` / `guest_suite_review_importer` queues to sync reviews into review entities. Two tokens (`guest_suite_average_rate`, `guest_suite_reviews_total_number`) expose aggregate stats for use in blocks/templates.

Configuration lives at `/admin/config/services/guest-suite` and is gated by `administer site configuration`; a review overview page is gated by `access guest suite review overview`. The API host is a fixed HTTPS URL, and the access token is stored in config — keep config exports out of public repos.

---

- Import Guest Suite customer reviews into Drupal.
- Store reviews as `guest_suite_review` content entities.
- Display reviews and ratings with Views and blocks.
- Show the average review rating via a token.
- Show the total number of reviews via a token.
- Sync reviews automatically on cron.
- Queue fetch and import jobs to avoid duplicates.
- Authenticate to the Guest Suite API with an access token.
- Configure the token at `/admin/config/services/guest-suite`.
- Pull per-establishment statistics from the API.
- Support single- or multi-establishment accounts.
- Manually import reviews from the admin UI.
- Render an establishment-data block.
- Expose a review overview page behind a dedicated permission.
- Aggregate ratings across all establishments.
- Integrate third-party reputation content into pages.
- Translate the UI via the bundled translations.
