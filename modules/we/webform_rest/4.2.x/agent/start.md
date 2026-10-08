<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# webform_rest — agent start

Exposes **Webform** over Drupal core **REST**. Ships five `@RestResource` plugins; none are
active until you enable them by creating a `rest_resource_config` entity (allowed methods +
formats + auth). Depends on `webform` and `rest`. Package **Webform**. No UI to toggle
resources — use core REST config, the `restui` module, or the entity API.

The five resource plugin ids and their endpoints:

- `webform_rest_elements` — `GET /webform_rest/{webform_id}/elements` (render-array elements)
- `webform_rest_fields` — `GET /webform_rest/{webform_id}/fields` (flattened fields + defaults)
- `webform_rest_submit` — `POST /webform_rest/submit` (create a submission; returns `sid`/UUID)
- `webform_rest_submission` — `GET`/`PATCH` `/webform_rest/{webform_id}/submission/{uuid}`
- `webform_rest_complete_submission` — `GET /webform_rest/{webform_id}/complete_submission/{uuid}`

Read the docs you need:

- Endpoints, HTTP methods, request/response payloads, the submit event → [api/rest-resources.md](api/rest-resources.md)
- Enabling resources (rest_resource_config), the settings form + permission → [configure/enable-resources.md](configure/enable-resources.md)
