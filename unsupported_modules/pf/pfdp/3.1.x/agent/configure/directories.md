<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring pfdp: directories and settings

## Routes

| Route | Path | Permission |
|---|---|---|
| `entity.pfdp_directory` | `/admin/config/media/private-files-download-permission` | `administer pfdp` |
| `entity.pfdp_directory.add` | `…/add` | `administer pfdp` |
| `entity.pfdp_directory.edit` | `…/{pfdp_directory}` | `administer pfdp` |
| `entity.pfdp_directory.delete` | `…/{pfdp_directory}/delete` | `administer pfdp` |
| `pfdp.settings` (**`configure`**) | `…/settings` | `administer pfdp` |

Admin menu: *Configuration → Media → Private files download permission* (+ a *Settings* child).

## The `pfdp_directory` config entity

Config prefix `pfdp.pfdp_directory.<id>`; `config_export` =
`id, path, bypass, grant_file_owners, users, roles`. Class
`Drupal\pfdp\Entity\DirectoryEntity` (plain public properties, no getters).

```yaml
# drush config:get pfdp.pfdp_directory.downloads
id: downloads
path: /downloads          # relative to $settings['file_private_path']
bypass: false             # true = pfdp ignores this path entirely (returns NULL)
grant_file_owners: false  # true = the uploader of the file may always download it
users:                    # uids, only consulted when by_user_checks is on
  - '5'
roles:
  - member
```

**Path rules** (enforced by `DirectoryForm::validateForm()`):

- must start with `/` (or `\`); `/` alone means "the whole private file system";
- no `//` and no trailing slash;
- the form shows `$settings['file_private_path']` as a field prefix — the stored value is the
  part *after* it.

The machine `id` is generated from the path via `#machine_name` (`source: path`).

### Create / edit from code

```php
use Drupal\pfdp\Entity\DirectoryEntity;

DirectoryEntity::create([
  'id' => 'downloads',
  'path' => '/downloads',
  'bypass' => FALSE,
  'grant_file_owners' => TRUE,
  'users' => [],                 // uids as strings; '0' entries mean "unchecked" and are filtered
  'roles' => ['member'],
])->save();
```

```bash
drush config:get pfdp.pfdp_directory.downloads
drush php:eval 'foreach (\Drupal\pfdp\Entity\DirectoryEntity::loadMultiple() as $d) {
  printf("%s path=%s bypass=%s owners=%s roles=%s users=%s\n", $d->id(), $d->path,
    var_export($d->bypass, TRUE), var_export($d->grant_file_owners, TRUE),
    implode(",", $d->roles), implode(",", $d->users));
}'
```

The `users` checkbox element stores `'0'` for unchecked boxes; `pfdp_get_proper_user_array()`
strips those before the membership test, and the list builder does the same when rendering.

## `pfdp.settings`

| Key | Effect |
|---|---|
| `by_user_checks` | Enables per-user grants. When off, the `users` list is ignored **and** the "Enabled users" fieldset is not even rendered on the directory form. |
| `cache_users` | Caches the user list used by that fieldset in `cache.default` under `pfdp.cache.users`. Forced off when `by_user_checks` is off. |
| `attachment_mode` | `Content-Disposition: attachment; filename=…` instead of `inline`. |
| `override_mode` | Instead of returning headers, stream the file with `BinaryFileResponse` and `exit()` — skips every other `hook_file_download()` implementation. |
| `debug_mode` | Log every grant (info) and denial (warning) to the `pfdp` logger channel. |

```bash
# ⚠ On a fresh install this object does not exist (see below).
drush config:get pfdp.settings
drush php:eval '\Drupal::configFactory()->getEditable("pfdp.settings")
  ->set("by_user_checks", TRUE)->set("cache_users", FALSE)
  ->set("attachment_mode", FALSE)->set("override_mode", FALSE)
  ->set("debug_mode", TRUE)->save();'
drush watchdog:show --type=pfdp
```

### Gotcha: `pfdp.settings` is missing after install

The project ships `config/install/pfdp.settings` — **without the `.yml` extension, and empty** —
so Drupal never installs it. Until the settings form at
`/admin/config/media/private-files-download-permission/settings` is saved once (or the object is
created with `getEditable()->set()->save()`), `drush config:get pfdp.settings` reports *"Config
pfdp.settings does not exist"* and every `$settings->get(...)` in `pfdp.module` returns `NULL`.
Practical effect of the NULL defaults: by-user grants are **off**, downloads are served `inline`,
no override mode, no logging. `config/schema/pfdp.schema.yml` is present and correct, so once the
object exists it validates normally.

## Prerequisites for the module to do anything

- `$settings['file_private_path']` must be set in `settings.php`.
- The files must actually be served through the private stream (`private://`), i.e. the field's
  upload destination is private — the list builder warns if `system.file:default_scheme` is not
  `private`, but per-field private destinations work regardless.
- `public://` URIs are returned early and never checked.
