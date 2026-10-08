# Permissions

Defined in `access_unpublished.permissions.yml` (static) plus a dynamic callback
(`AccessUnpublishedPermissions::permissions`).

## Static permissions

| Permission | Gates |
|---|---|
| `access tokens overview` | The token overview page `/admin/content/access_token` |
| `renew token` | Renewing an (expired) token (`entity.access_token.renew`) |
| `delete token` | Deleting a token (`entity.access_token.delete`) |

## Dynamic per-entity-type/bundle "view via token" permissions

For every applicable entity type (implements `EntityPublishedInterface` + has a `canonical` link),
one permission is generated per type, or per **bundle** if the type is bundled:

- Bundled: `access_unpublished <entity_type> <bundle>` — e.g. `access_unpublished node article`
  (title: *Access unpublished article Content*).
- Non-bundled: `access_unpublished <entity_type>`.

This is the permission checked by `hook_entity_access()`: a user (including the **anonymous** role)
may `view` a given unpublished entity through a token **only** if they hold the matching
`access_unpublished …` permission for that entity's type/bundle. It grants view only, never edit.
Grant it to `anonymous` to make shared preview links work for logged-out visitors.

```
drush role:perm:add anonymous 'access_unpublished node article'
```

## Other gates

- Settings form (`access_unpublished.settings_form`) requires core **`administer site configuration`**.
- The `access_token` entity's `admin_permission` is **`administer access token entities`** (full CRUD bypass).
