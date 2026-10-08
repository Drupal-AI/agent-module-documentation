<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission

One permission, declared in `imageapi_optimize_binaries.permissions.yml`:

| Permission | Machine name | `restrict access` | Gates |
|---|---|---|---|
| Configure Image Optimize Binary paths | `configure imageapi_optimize_binary paths` | true | Whether the **Manually set path** textfield is shown on a binary processor's configuration form (i.e. the ability to override the auto-detected executable path with an arbitrary server path). |

`restrict access: true` marks it as security-sensitive (Drupal shows a warning on the
permissions form) — overriding a binary path is effectively choosing what command the server
runs, so grant it only to trusted administrators. Without it, users can still add/configure a
processor's non-path options but cannot set `manual_executable_path`.

Grant via drush:

```bash
drush role:perm:add administrator 'configure imageapi_optimize_binary paths'
```
