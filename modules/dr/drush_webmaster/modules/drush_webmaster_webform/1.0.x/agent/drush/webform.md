<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `wm:webform:*` — webform & submission management

`WebformCommands` (`modules/drush_webmaster_webform/src/Drush/Commands/WebformCommands.php`) over
`WebformManager` (`src/Service/WebformManager.php`). Requires the base module + contributed Webform
module. Enable: `drush en drush_webmaster_webform -y`.

## Webforms

| Command | Aliases | Args / options |
|---|---|---|
| `wm:webform:list` | `wm-wfl`, `wm:wf:list` | — (id, title, status, category, submission_count) |
| `wm:webform:get` | `wm-wfg`, `wm:wf:get` | `webform_id` (elements, handlers, settings, counts) |
| `wm:webform:export` | `wm-wfe`, `wm:wf:export` | `webform_id` (full config as YAML to stdout) |
| `wm:webform:duplicate` | `wm-wfdup`, `wm:wf:duplicate` | `webform_id` `new_id` `title` `--dry-run` |
| `wm:webform:delete` | `wm-wfd`, `wm:wf:delete` | `webform_id` `--force --dry-run` |

- **`get`** returns decoded elements (`getElementsDecoded()`), a summary of each handler
  (id/plugin_id/label/enabled), all `getSettings()`, and submission/element counts. The command's
  help text also carries a large reference of Webform element types and handler shapes.
- **`export`** does `$webform->toArray()`, strips `uuid` and `_core`, and dumps YAML — useful for
  backup/migration/version control.
- **`duplicate`** validates the new id (`^[a-z][a-z0-9_]*$`, must not already exist), then
  `createDuplicate()` → set new id/title → save. Copies elements, handlers, settings and access —
  **not** submissions (starts empty, serial resets).
- **`delete`** refuses if the form has submissions unless `--force` (which purges submissions first,
  then deletes).

## Submissions

| Command | Aliases | Args / options |
|---|---|---|
| `wm:webform:submission:list` | `wm-wfsl`, `wm:wf:s:list` | `webform_id` `--limit(50)` (metadata only) |
| `wm:webform:submission:get` | `wm-wfsg`, `wm:wf:s:get` | `sid` (full field `data`) |
| `wm:webform:submission:delete` | `wm-wfsd`, `wm:wf:s:delete` | `sid` `--dry-run` |
| `wm:webform:submission:purge` | `wm-wfsp`, `wm:wf:s:purge` | `webform_id` `--dry-run` (deletes ALL submissions) |

- `submission:list` returns sid/serial/created/completed/uid/remote_addr/in_draft, sorted newest
  first, capped by `--limit`. `submission:get` also returns the full submission `data` (form values).
- `submission:purge` deletes **all** submissions for the form — always `--dry-run` first; the count
  is reported. `WebformManager` counts/queries submissions via the entity query API with
  `accessCheck(FALSE)`.

## Notes for agents

- CLI-only admin tool: submission `data` and `remote_addr` may include personal data, and it is
  returned in full to whoever runs the command (already a privileged CLI context). Export/back up
  before purge — there is no undo.
