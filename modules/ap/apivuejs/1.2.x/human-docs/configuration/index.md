# Configuration

Api vuejs is configured in two places: a small settings form, and — more
importantly — the permissions that decide who can drive its create/update/delete
endpoints.

## Open the settings form

1. Log in as a user with the **Administer apivuejs configuration**
   (`administer apivuejs configuration`) permission.
2. Go to **Configuration → System → apivuejs**, or navigate directly to
   `/admin/config/system/apivuejs` (route `apivuejs.settings_form`).

## Permissions — read this carefully

The endpoints are gated by permissions you set at **People → Permissions**
(`/admin/people/permissions`):

- **`edit-create apivuejs entities`** — required by all the data routes
  (save/update, count, duplicate, delete). This permission is **coarse**: it
  covers **create, update and delete across every entity type**, not a specific
  type or bundle. Grant it only to roles you fully trust. It is marked as a
  restricted-access permission for exactly this reason.
- **`canonical apivuejs entities`** — a separate permission for read access (the
  endpoint that returns an entity render). Grant it independently of the
  create/edit permission.
- **`administer apivuejs configuration`** — access to the settings form above;
  administrators only.

## How requests authenticate

The data routes accept either a **session cookie** (a logged-in browser session)
or **HTTP basic auth**. Whichever a request uses, the module still enforces the
permissions above and runs Drupal's own entity access checks — updates call
`access('update')` before writing, and entity queries are access-checked. Because
the coarse permission is the main gate, treat control of that permission as the
security boundary for the whole API.

## The endpoints (for your Vue.js client)

Once configured, your Vue.js front end can call:

- `POST /apivuejs/save-entity/{entity_type_id}` — create or update an entity.
- `POST /apivuejs/count-entities/{entity_type_id}` — count entities (access-checked).
- `POST /apivuejs/edit-duplicate-entity` — get a form for editing or duplicating.
- `POST /apivuejs/entity-delete` — delete entities.
- `GET /apivuejs/add-entity/{entity_type_id}/{bundle}/{view_mode}` — get an add-form definition.
- `GET /apivuejs/canonical-entity/{entity_type_id}/{entity_id}` — get an entity render (needs `canonical apivuejs entities`).

Translations are respected — updates load the current-language translation before
setting fields — and Layout Builder sections are handled when extracting entity
values.
