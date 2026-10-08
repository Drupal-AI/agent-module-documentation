# Manage MTM containers

A container is a `matomo_tagmanager_container` config entity (see
`src/Entity/Container.php`, list builder `ContainerListBuilder`, form `ContainerForm`).
Manage at `/admin/config/system/matomo/tagmanager`:

| Operation | Route path |
|---|---|
| Collection (list) | `/admin/config/system/matomo/tagmanager` |
| Add | `/admin/config/system/matomo/tagmanager/add` |
| Edit | `/admin/config/system/matomo/tagmanager/manage/{container}` |
| Enable | `/admin/config/system/matomo/tagmanager/manage/{container}/enable` |
| Disable | `/admin/config/system/matomo/tagmanager/manage/{container}/disable` |
| Delete | `/admin/config/system/matomo/tagmanager/manage/{container}/delete` |

- Each container stores its MTM container ID and embed/JS URL (schema in
  `config/schema/matomo_tagmanager.schema.yml`).
- Only **enabled** containers are attached to pages; disable to pause without deleting.
- Containers are configuration — export/import with `drush config:export` /
  `config:import` to deploy the same MTM setup across environments.
- All operations require the `administer matomo tag manager` permission (see
  [../permissions/permissions.md](../permissions/permissions.md)).
