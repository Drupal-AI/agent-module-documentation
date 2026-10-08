Blackbird Translator adds a Translation Management Tool (TMGMT) translator plugin that hands content to the Blackbird content-orchestration platform, which polls Drupal over an API-key-authenticated REST endpoint to fetch job HTML and post translations back.

---

The module registers a `blackbird` TMGMT translator plugin (`BlackbirdTranslator`) plus a small REST surface under `/api/tmgmt/blackbird/*` that Blackbird calls. Unlike push-style connectors, this module never calls out to Blackbird: when an editor submits a TMGMT job to the Blackbird translator, the job is parked in the `unprocessed` state with a `blackbird_awaiting_acceptance` flag, and Blackbird (or any consumer holding the translator's API key) pulls it. The endpoints list available languages, list jobs by state, download a job as TMGMT File HTML, accept an unprocessed job (moving it to `active`), read/set a free-text provider note stored on the job's `reference`, import translated HTML back, and reject a job with a reason. Every endpoint authenticates by matching the request's `x-api-key` header against the API key stored in the translator's own configuration (a random key generated in the translator settings form, then copied into Blackbird's Drupal app connection); there is no separate user login for the API. It depends on TMGMT and TMGMT File and provides no permissions, Drush commands, or new plugin types of its own.

---

- Add Blackbird as a translation provider for a Drupal 8.8–11 multilingual site via TMGMT.
- Configure the `blackbird` translator at `/admin/tmgmt/translators` and generate/store its API key.
- Copy the generated API key into Blackbird > Apps > Drupal > Connections to link the two systems.
- Regenerate a fresh API key in-place from the translator form (AJAX button) without saving unrelated changes.
- Let an editor submit a translation job (single or multiple target languages) to the Blackbird translator.
- Keep submitted jobs pending in `unprocessed` until Blackbird explicitly accepts them.
- Have Blackbird poll `GET /api/tmgmt/blackbird/languages` to discover the site's enabled languages.
- Have Blackbird poll `GET /api/tmgmt/blackbird/jobs?state=unprocessed` to discover jobs awaiting acceptance.
- Filter the jobs listing by `created` timestamp, `source`/`target` language, `state`, or `note_contains` substring.
- Download a job's source content as TMGMT File HTML via `GET /api/tmgmt/blackbird/job/{id}` (preview before accepting).
- Accept a job with `POST /api/tmgmt/blackbird/job/{id}/accept`, moving it from `unprocessed` to `active`.
- Post translated HTML back with `POST /api/tmgmt/blackbird/job/{id}` once the job is accepted.
- Reject a job Blackbird cannot process with `POST /api/tmgmt/blackbird/job/{id}/reject` and a reason string.
- Read or set a provider note on a job with `GET`/`POST /api/tmgmt/blackbird/job/{id}/note` (shown under Provider information).
- Track a Blackbird workflow/reference ID by storing it in the job note and later filtering jobs by `note_contains`.
- Translate content for multiple target languages, where TMGMT creates one independent job per language.
- Re-submit a previously rejected job so it returns to `unprocessed` and requires acceptance again.
- Integrate with an AI/automation-driven translation pipeline orchestrated on the Blackbird side.
- Run a pull-based integration where Drupal never makes outbound calls to the translation vendor.
- Keep API responses uncached so a response for one API key is never served to a request with another.
