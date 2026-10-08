<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: suggests taxonomy tags in real time as editors type, using Apache Stanbol semantic enhancement over a WebSocket.
- When: you want automatic entity/keyword tagging suggestions drawn from content text.

---

- Enable the module (depends on core `taxonomy`); a running Apache Stanbol server is required.
- Configure the Stanbol/WebSocket connection at `/admin/config/services/auto_recommended_tags` (route `auto_recommended_tags.settings`, `administer auto recommended tags settings`).

---

- Provides the `administer auto recommended tags settings` permission.
- A settings form (`AutoRecommendedTagsSettingsForm`) stores the Stanbol endpoint configuration.
- Front-end JS (in `js/`, built from `scss`/`gulp`) opens a WebSocket to Stanbol and streams suggestions.
- Recommended tags appear as the editor types into the content form.
- Editors accept suggestions to populate a taxonomy reference field.
- Depends on Stanbol's enhancement engines to extract entities/keywords.
- Use it to speed up consistent tagging of articles or knowledge-base content.
- Point the config at your Stanbol host and WebSocket bridge.
- The module ships build tooling (gulpfile, package.json, yarn.lock) for the JS assets.
- CSS in `css/` styles the suggestion UI.
- Grant the admin permission only to roles configuring the integration.
- Requires network access from the browser/site to the Stanbol service.
- Suggestions are advisory; editors choose which tags to apply.
- Test the WebSocket connection after configuring the endpoint.
- Best paired with a curated taxonomy vocabulary.
- Version 2.0.x targets Drupal 9/10.
