# System Tags — permissions

Defined in `system_tags.permissions.yml` (none marked `restrict access: true`):

| Permission | Gates |
|---|---|
| `administer system tags` | Create/edit/delete `system_tag` entities; any non-view op on the entity (`SystemTagAccessControlHandler`). |
| `view system tags` | `view` on `system_tag` entities; **view** access to `system_tag` reference fields (`hook_entity_field_access`). |
| `assign system tags` | **edit** access to `system_tag` reference fields — i.e. who may tag content. |

## Field access

`system_tags_entity_field_access()` intercepts any `entity_reference` field whose `target_type` is
`system_tag`:
- `view` operation → allowed only with `view system tags` (else forbidden).
- `edit` operation → allowed only with `assign system tags` (else forbidden).

So even a user who can edit an entity cannot set/see its system-tag field without the respective
permission.

## Note on impact

`assign system tags` lets a holder move the `homepage` / `access_denied` / `page_not_found` tags, which
(through `SystemPageConfigOverrider`) changes the site's front page, 403, and 404 targets. This is the
module's documented purpose and still requires edit access to a node carrying such a field, but grant
it with the same care as front-page configuration.
