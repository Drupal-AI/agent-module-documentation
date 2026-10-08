<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Travel Safety (travel_safety) — agent index
**Traveler safety check-in: itinerary form, tokenized self-report links, and cron digest emails for unaccounted travelers.**

- **Version:** 1.0.x (1.0.0-beta5)
- **Core:** ^10.6 || ^11.3 (PHP 8.1)
- **Configure:** `/admin/config/people/travel-safety` (`administer travel safety module`)
- **Routes:** `/travel-safety` (form, `access travel safety form`); `/travel-safety/check-in/accommodation/{token}` & `/boarded/{token}` (controller, token-gated); `/travel-safety/submission/update|delete/{token}` (forms); `/admin/people/travel-safety-submissions` (`view travel safety submissions`, restricted).
- **Storage:** `travel_safety_submissions` table. Cron via `CronHelper` (`travel_safety.cron_helper`).

**Security:** admin list/settings are permission-gated (restricted perms). Check-in/update/delete use capability URLs with strong tokens — `Crypt::randomBytesBase64()` (TravelInformationForm.php:365-368, TravelFlightUpdateForm.php:250), not weak randomness. DB access uses parameterized query builder (no raw SQL concatenation). Check-in via GET is a capability-URL pattern (token in path); delete/update go through CSRF-protected forms.

See [configure/settings.md](configure/settings.md)
