<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: a controller exposing POST/GET routes that build entity form definitions and CRUD entities for a Vue.js client.
- When: you build a Vue.js UI that needs to render Drupal entity forms and save/duplicate/delete entities via JSON.

---

- Enable the module (Composer package `habeuk/apivuejs`, requires `symfony/stopwatch`).
- Configure at `/admin/config/system/apivuejs` (route `apivuejs.settings_form`, `administer apivuejs configuration`, restricted).

---

- All data routes require the `edit-create apivuejs entities` permission (marked `restrict access: true`) plus `basic_auth` or `cookie` auth.
- `POST /apivuejs/save-entity/{entity_type_id}` creates or updates an entity; updates call `$entity->access('update')` before writing.
- `POST /apivuejs/count-entities/{entity_type_id}` counts entities via an access-checked query.
- `POST /apivuejs/edit-duplicate-entity` returns a form for editing or duplicating an entity.
- `POST /apivuejs/entity-delete` deletes entities (permission-gated).
- `GET /apivuejs/add-entity/{entity_type_id}/{bundle}/{view_mode}` returns a content-entity add form definition.
- `GET /apivuejs/canonical-entity/{entity_type_id}/{entity_id}` returns an entity render, gated by `canonical apivuejs entities`.
- Entity queries use `->accessCheck()` and update paths call entity `access('update')`.
- Note: the `edit-create` permission is a single coarse grant covering create/update/delete across ALL entity types — assign only to trusted roles.
- Services `GenerateForm` and `DuplicateEntityReference` build form arrays and clone entity references.
- Depends on external `stephane888/*` helper libraries for responses and debug.
- Use it as the API layer behind a decoupled Vue.js admin/editing UI.
- Layout Builder sections are handled when extracting entity values.
- Authenticate requests with a session cookie or HTTP basic auth.
- Grant `canonical apivuejs entities` separately for read access.
- Translations are respected: updates load the current-language translation before setting fields.
- Version 1.2.x targets Drupal 9/10.
