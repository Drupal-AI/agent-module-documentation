<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IMCE rename permissions

The module adds **two IMCE permissions** (not Drupal `permissions.yml` permissions). They come from
the Rename plugin's `permissionInfo()`:

```php
public function permissionInfo(): array {
  return [
    'rename_files'   => $this->t('Rename files'),
    'rename_folders' => $this->t('Rename folders'),
  ];
}
```

## Where they live

IMCE permissions are **per folder, per IMCE profile**, not global user permissions. Each IMCE
profile (`imce_profile` config entity, edited at *Configuration → Media → IMCE*,
`/admin/config/media/imce`) has one or more folders, and each folder has a `permissions` map. After
this module is enabled, that map gains `rename_files` and `rename_folders` checkboxes alongside the
core IMCE ones (`browse_files`, `upload_files`, `delete_files`, `browse_subfolders`, …).

Config path within an IMCE profile:

```yaml
# imce.profile.<profile_id>
conf:
  folders:
    - path: '.'                 # or 'users/user[user:uid]', etc.
      permissions:
        browse_files: true
        rename_files: true      # added by imce_rename_plugin
        rename_folders: false   # added by imce_rename_plugin
```

A profile is then assigned to roles (IMCE's *Role-Profile assignments* on the same settings page),
so "who can rename" = which roles are assigned a profile whose folder grants `rename_files` /
`rename_folders`.

## Effect

- With **neither** permission on a folder, the Rename button/JS is not attached (`buildPage()` skips
  it) and `opRename()` refuses (`validateRename()` fails).
- `rename_files` gates renaming files; `rename_folders` gates renaming folders. They are independent.

## Read / set via drush

```bash
# read
drush cget imce.profile.member conf.folders

# set (grant rename_files on the first folder of a profile)
drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("imce_profile")->load("member");
  $conf = $p->get("conf");
  $conf["folders"][0]["permissions"]["rename_files"] = TRUE;
  $p->set("conf", $conf)->save();
'
```

There is no configure route on this module itself (`configure: null`); all configuration is done
through IMCE's own settings UI / the `imce_profile` config entities.
