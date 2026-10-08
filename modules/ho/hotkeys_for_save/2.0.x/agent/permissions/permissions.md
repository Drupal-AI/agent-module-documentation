<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission

Defined in `hotkeys_for_save.permissions.yml`:

- **`use hotkeys for save`** — *"Use hotkeys instead of clicking on the Save buttons."* When a
  user has it, `hook_page_attachments()` attaches the hotkeys library on every page and the
  Ctrl+S/Cmd+S shortcut is active for them.

Security note (from the module): because the shortcut **suppresses the browser's native "Save
As" dialog**, the description warns *do not give this permission to ordinary users*. On install,
`hotkeys_for_save_install()` grants it to the `administrator` role only.

```bash
drush role:perm:add editor 'use hotkeys for save'
```
