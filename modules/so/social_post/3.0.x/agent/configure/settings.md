# Configure — autoposting admin page

Social Post has **no config object and no settings form of its own**. The `configure` link
(`social_post.integrations` in `social_post.info.yml`) points at a read-only listing page of
installed implementers.

## The integrations page

| Item | Value |
| --- | --- |
| Route | `social_post.integrations` |
| Path | `/admin/config/social-api/social-post` |
| Title | `Autoposting settings` |
| Controller | `\Drupal\social_post\Controller\SocialPostController::integrations` |
| Route default | `type: 'social_post'` |
| Permission | `administer social api autoposting` |
| Menu link | `social_post.settings` (parent `social_api.admin_config`, weight 10) |
| Local task | `social_post.integrations.tab` (title `Integrations`) |

`SocialPostController` is an empty subclass of `Drupal\social_api\Controller\SocialApiController`;
its `integrations()` action (inherited) renders a table of modules that register a Social API
integration of `type: social_post`. With only `social_post` installed the table is empty — each
per-network implementer module adds a row. The gating permission
`administer social api autoposting` is **declared by Social API**, not by this module.

## No configuration to set

- No `config/install/*`, no `config/schema/*` (`provides_config_schema: false`).
- There is nothing to set via `drush config:set` or `\Drupal::configFactory()` for this module;
  behaviour comes entirely from which implementer modules are installed and from the per-user
  `social_post` entities they create (see [../api/entity.md](../api/entity.md)).

## Runtime data location

Connected accounts are stored as `social_post` content entities in the `social_post` base table,
not in configuration. Each implementer exposes its own collection route
(`social_post_<provider>.user.collection`, e.g. `/admin/config/social-api/social-post/<provider>/users/`)
to list them; the shared list builder lives in this module
(see [../api/entity.md](../api/entity.md)).
