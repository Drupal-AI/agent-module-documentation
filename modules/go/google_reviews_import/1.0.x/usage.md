<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Reviews Import pulls Google business-location reviews into Drupal entities via Migrate.

---

Google Reviews Import fetches the Google reviews of your business locations and imports them into a custom `google_review` entity, using the Migrate framework — so a site can display and manage its Google reviews natively. It runs imports from the Google API.

The Google API key is stored via the Key module (env-backed). Permissions cover CRUD on review entities (`administer/view/edit/delete/create google_review`). Depends on `migrate_tools`, `migrate_plus`, and `key`; supports Drupal 10 and 11.

---

- Import Google reviews.
- Fetch reviews for business locations.
- Store reviews in a `google_review` entity.
- Use the Migrate framework.
- Run imports from the Google API.
- Store the API key via Key (env-backed).
- Gate review CRUD permissions.
- Depend on `migrate_tools`/`migrate_plus`.
- Depend on `key`.
- Support Drupal 10 and 11.
- Display reviews natively.
- Manage reviews in Drupal.
- Sync review data.
- Configure locations.
- Import via Migrate.
- Keep the API key secure.
- Support review display.
- Update reviews on import.
