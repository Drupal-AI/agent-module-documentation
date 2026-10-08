# Configure Custom Permissions

## Mental model

A **custom permission** is a `custom_perms_entity` config entity. Each one:

1. adds a real, grantable permission whose **title is the entity `label`** (via the
   dynamic `permission_callbacks` in `config_perms.permissions.yml`), and
2. takes over access control for every **route** listed in its `route` field — a route
   subscriber strips the route's normal access requirements and replaces them with the
   module's `_config_perms_access_check`, which allows access iff the current user holds
   the permission named by that `label`.

Net effect: you can peel a single admin form out from under a broad core permission
(typically `administer site configuration`) and grant it to a role on its own. User 1
always keeps access; other roles must lose the broad permission for the scoping to matter.

> Custom permissions support **routes only** (route machine names), not arbitrary paths.
> An older `path` field was migrated to `route` by update hook `config_perms_update_8201`.

## Config entity shape

Config object name: `config_perms.custom_perms_entity.<id>`

```yaml
langcode: en
status: true
dependencies: {  }
id: administer_file_system          # machine id
label: 'Administer file system'      # <-- becomes the permission title on People > Permissions
route: system.file_system_settings   # one route name, or several separated by newlines
```

Exported keys (`config_export`): `id`, `label`, `route`, `status`. The top-level
`status: true` is the entity's enabled flag — a disabled entity provides no permission and
does not alter any route.

Multiple routes in one permission (note the YAML block scalar / literal newlines):

```yaml
route: |-
  system.site_information_settings
  system.performance_settings
```

## Configure route

- `configure` in `config_perms.info.yml` → route **`custom_perms_select_list_form`**
  (confirmed in `config_perms.routing.yml`), path **`/admin/people/custom-permissions/list`**,
  gated by the `administer config permissions` permission. Menu tab "Custom permissions"
  under People.
- The form lets you add rows (Enabled checkbox, Name, Route(s)), Save, and Delete. The
  machine id is auto-generated from the Name. Deleting: clear a row's name+route and Save,
  or use the delete link (`/admin/structure/custom_perms_entity/{id}/delete`).

## Drush / scripting recipes

Create a custom permission (grants the "Site information settings" form to whoever holds
the "Manage site information" permission):

```bash
drush php:eval '
  \Drupal::entityTypeManager()->getStorage("custom_perms_entity")->create([
    "id" => "manage_site_information",
    "label" => "Manage site information",
    "route" => "system.site_information_settings",
    "status" => TRUE,
  ])->save();
'
drush cr   # rebuild routes so the access override takes effect
```

Then assign it to a role by its **label** (the permission machine name is the label string):

```bash
drush role:perm:add editor 'Manage site information'
```

Read one back / list all:

```bash
drush config:get config_perms.custom_perms_entity.manage_site_information
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("custom_perms_entity")->loadMultiple() as $e) { print $e->id()." | ".$e->label()." | ".$e->getRoute()." | ".($e->getStatus()?"on":"off")."\n"; }'
```

Disable (keep but deactivate) vs delete:

```bash
drush php:eval '$e=\Drupal::entityTypeManager()->getStorage("custom_perms_entity")->load("manage_site_information"); $e->set("status", FALSE)->save();'
drush php:eval '\Drupal::entityTypeManager()->getStorage("custom_perms_entity")->load("manage_site_information")->delete();'
drush cr
```

After any create/enable/disable/route change, run `drush cr` (or trigger a router rebuild)
so `RouteSubscriber` re-applies or removes the `_config_perms_access_check` on the routes.

## Ships-with defaults

`config/install` seeds four example permissions: `administer_account_settings`
(`entity.user.admin_form`), `administer_date_time` (`entity.date_format.collection`),
`administer_error_logs` (`dblog.overview`), `administer_file_system`
(`system.file_system_settings`).
