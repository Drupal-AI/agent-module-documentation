# Permissions

The module defines static permissions in `date_content.permissions.yml` and generates per-bundle
permissions dynamically via `DateContentPermissions::generatePermissions()`.

## Static permissions (`date_content.permissions.yml`)

| Machine name | Title | Notes |
|---|---|---|
| `add date content entities` | Create new date content entities | Gates `date_content.add_form_param`; also checked by the augmenter's Add link. |
| `administer date content entities` | Administer date content entities | `restrict access: true`. Grants add/edit/delete in the augmenter's link logic. |
| `edit date content entities` | Edit date content entities | Gates `date_content.revise` and the entity `update` op. |
| `delete date content entities` | Delete date content entities | Entity `delete` op. |
| `view all date content revisions` | View all date content revisions | Consumed by the revision access checker (`view`). |
| `revert all date content revisions` | Revert all date content revisions | Revision `revert`. |
| `delete all date content revisions` | Delete all revisions | Revision `delete`. |

## Dynamic per-bundle permissions

`DateContentPermissions::buildPermissions()` emits eight permissions per `date_content_type` bundle
(here `<type>` is the bundle id, e.g. `session`):

- `<type> create entities`
- `<type> edit own entities`
- `<type> edit any entities`
- `<type> delete own entities`
- `<type> delete any entities`
- `<type> view revisions`
- `<type> revert revisions`
- `<type> delete revisions`

Runtime `user.permissions` for this site (bundle `session` present but no per-bundle rows appeared,
i.e. the dynamic callback yielded none because the entity schema is not installed): the seven static
permissions above are all registered.

## Naming caveats (functional, fail-closed)

Several code paths reference permission spellings that do **not** match the ones actually defined,
which makes those paths effectively deny (never grant) until fixed. Know this before wiring roles:

- Entity annotation `admin_permission = "administer date_content entities"` (underscore) — no such
  permission exists; the defined one is `administer date content entities` (spaces). The bundle config
  entity instead uses `administer site configuration` as its admin permission, so bundle admin works.
- `DateContentAccessControlHandler::checkCreateAccess()` checks `add date_content entities` (underscore)
  — undefined; the working create path is the custom `date_content.add_form_param` route, which
  correctly requires `add date content entities` (spaces).
- `DateContentHtmlRouteProvider` builds the version-history / revision / revert / delete routes with
  `_permission` values like `view all date_content revisions` / `revert all date_content revisions`
  (underscore) — undefined; the defined spellings use `date content` (spaces).
- The revision *view* route in `date_content.routing.yml` requires `_access_DateContent_revision`, but
  the access-check service is tagged `applies_to: _access_date_content_revision` (different casing), so
  no checker matches that requirement.

None of these grant unintended access — they only make the affected routes/operations deny. The
reliably working, permission-gated paths are the augmenter's inline Add/Edit/Remove links and the
custom `date_content.add_form_param` / `date_content.revise` routes.
