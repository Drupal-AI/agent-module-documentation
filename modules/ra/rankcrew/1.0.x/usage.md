<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rankcrew exposes REST resources that let the external RankCrew service create multilingual content (nodes) — including base64-embedded images and taxonomy terms — in one request.
---
The main resource (`RankcrewResource`, POST `/api/rankcrew`) accepts a JSON payload with `content_type` plus a `data` map keyed by langcode; it creates a base node from the first language and adds a translation per remaining valid, translatable language (`rankcrew/src/Plugin/rest/resource/RankcrewResource.php:85`). It sets title/body/category and, when `image.image_base64`+`mime_type`+`field_image_name` are supplied, decodes the image into a managed file. Companion resources expose vocabularies and categories. Because these are core REST resources, access is governed by the REST framework: the endpoints require the corresponding `restful post rankcrew_rankcrew` permission and an authenticated principal (the module depends on `basic_auth`), and they must be enabled via `rest.resource.*` config.

Notes: the body field is written with `'format' => 'full_html'`; grant the REST permission only to a dedicated API account. `is_published` defaults to TRUE (content goes live unless `is_published:false` is sent). Language codes are validated against the language manager; images are created from base64 only (no server-side URL fetch). Filenames use `uniqid()`.

Typical setup: enable the REST resources, grant the POST permission to a dedicated API user/role, and configure basic auth (or another authentication provider).
---
- Create an article in multiple languages via one POST.
- Import RankCrew-generated content into Drupal.
- Attach a base64 image to the created node.
- Assign a taxonomy term/category to imported content.
- Auto-generate a teaser from the first sentence.
- Strip markdown from incoming body text.
- Publish or leave unpublished via `is_published`.
- List available vocabularies through a REST resource.
- List categories through a REST resource.
- Restrict the endpoint to a dedicated API account.
- Authenticate requests with basic auth.
- Map images to a specific image field via `field_image_name`.
- Return the created node id and uuid to the platform.
- Skip untranslatable content types gracefully.
- Log received languages for debugging.
- Force a specific image field per language.
