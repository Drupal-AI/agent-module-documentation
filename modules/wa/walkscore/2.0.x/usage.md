<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Retrieves Walk Score walkability ratings from the Walk Score API for geolocation field values and renders them, with a description, through a Drupal field formatter.

---
Sites that show property or place listings often want a walkability rating. WalkScore adds a field type, widget and formatter (built on the `geolocation` module) so a location's latitude/longitude and address can be sent to the Walk Score API and the returned 0–100 score displayed with a friendly label ("Very Walkable", etc.). The `walkscore.service` (`WalkScore` class) builds a query — API key plus address/lat/lon — against the fixed `https://api.walkscore.com/score` endpoint using the Guzzle HTTP client, decodes the JSON response, maps status codes to messages and returns the score; a `printTest()` helper renders a sample. The API key is configured at `/admin/config/services/walkscore` (`WalkScoreForm`, perm `administer walkscore`).

The outbound call targets a fixed HTTPS host (`api.walkscore.com`), and the API key is saved in the `walkscore.settings` config object. The admin config route is permission-gated. Setup: get a Walk Score API key, enter it in settings, and add the WalkScore field/formatter to a bundle that has a geolocation value.
---
- Fetch a Walk Score rating for a location.
- Display a 0–100 walkability score on content.
- Show a friendly walkability label for a score.
- Add a WalkScore field to an entity bundle.
- Use the geolocation lat/lon to query Walk Score.
- Include the street/city/province address in the query.
- Configure the Walk Score API key in settings.
- Render a sample Walk Score via the test helper.
- Map Walk Score status codes to readable messages.
- Show a long-form description of a score.
- Display walkability on property/place listings.
- Format a geolocation field as a Walk Score.
- Call the Walk Score API over HTTPS via the service.
- Restrict Walk Score settings to `administer walkscore`.
- Handle API errors/quotas gracefully (returns 0).
