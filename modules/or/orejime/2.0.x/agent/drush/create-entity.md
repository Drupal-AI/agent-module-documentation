<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `orejime:create-entity`

`Drush/Commands/CreateCommands::createEntity()` — scripts creation of an `orejime_service`
consent entity (bundle `orejime_system`). Alias `orejime:create`.

```
drush orejime:create-entity <machine_name> <label> --description="..." [options]
```

Arguments:
- `machine_name` — system name; must be unique and match `^[a-z0-9_]+$`.
- `label` — human label (≤255 chars).

Options:
- `--description=""` — **required** (throws if empty).
- `--publish` — publish the service (default unpublished → not shown in the banner).
- `--cookies=""` — comma-separated cookie list (`, ` is converted to newlines internally).
- `--default` — enabled by default in the modal.
- `--required` — strictly-necessary (cannot be declined).
- `--purposes=""` — purposes text (≤255 chars).

Example:
```
drush orejime:create-entity custom_tracking 'Custom Tracking' \
  --description="Analytics cookies" --cookies="_ga, _gat" --default --publish
```

Validation: unique + valid machine name (`assertMachineName`), and `label`/`purposes` ≤ 255 chars
(`assertTextlength`). On success prints "'<machine_name>' entity has been successfully created."
