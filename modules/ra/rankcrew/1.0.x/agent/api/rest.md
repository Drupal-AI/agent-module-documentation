<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rankcrew — REST API

All resources are core `@RestResource` plugins; they are inert until enabled (`drush pmu`-style config `rest.resource.rankcrew_rankcrew`) and access is the standard `restful <method> <id>` permission plus an auth provider (module depends on `basic_auth`).

## POST /api/rankcrew  (id: `rankcrew_rankcrew`)
Body:
```json
{
  "content_type": "article",
  "category_id": 12,
  "field_category_name": "field_tags",
  "is_published": true,
  "data": {
    "en": {"title":"…","body":"<p>…</p>","image":{"image_base64":"…","mime_type":"image/jpeg","field_image_name":"field_image","image_alt":"…"}},
    "fr": {"title":"…","body":"…"}
  }
}
```
Behaviour:
- First key in `data` = base node language; others added via `addTranslation()` if the node is translatable and the langcode is valid.
- `applyFields()` sets title, body, category, image. Body is stored `format => full_html` with an auto-extracted first-sentence teaser and markdown stripped.
- `is_published` defaults TRUE; only an explicit `false` unpublishes.
- Returns `{ "nid": …, "uuid": … }` (200) or `{ "error": … }` (400/500).

## Categories / vocabularies resources
`RankcrewCategoriesResource` and `RankcrewVocabulariesResource` return taxonomy metadata to help the platform map `category_id` / `field_category_name`.

## Hardening
- Grant `restful post rankcrew_rankcrew` only to a dedicated bot role.
- Prefer a stronger auth provider than basic_auth over plain HTTP.
