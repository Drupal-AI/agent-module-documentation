<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Field Mapper renames webform fields for remote POST submissions.

---

Webform Field Mapper allows mapping of form fields to different names on the remote post — so when a webform submission is posted to an external endpoint (via a remote handler), the field keys can be renamed to match the remote API's expected names, without changing the webform's own field machine names.

Submissions are sent to the configured remote endpoint (store any endpoint credentials securely, env-backed; mind data privacy). Depends on `webform`; supports Drupal 9, 10, and 11.

---

- Map webform fields to remote names.
- Rename field keys for remote posts.
- Match a remote API's field names.
- Keep local machine names unchanged.
- Post submissions to an external endpoint.
- Store endpoint credentials securely (env-backed).
- Mind data privacy.
- Depend on `webform`.
- Support Drupal 9, 10, and 11.
- Configure the mapping.
- Integrate remote APIs.
- Aid form-to-API integration.
- Send submissions outward
- Handle field mapping
- Support remote handlers.
- Rename fields.
- Map submissions.
- Post to remote
