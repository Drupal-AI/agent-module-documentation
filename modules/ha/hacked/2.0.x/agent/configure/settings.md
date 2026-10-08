<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Hacked!

Hacked! has exactly one setting: which **file hasher** to use when comparing on-disk files
against the official release.

## Config

Object `hacked.settings`, single key `selected_file_hasher`
(default `hacked_ignore_line_endings`, from `config/install/hacked.settings.yml`).
No config schema is shipped.

| Value | Label | Behaviour |
|---|---|---|
| `hacked_ignore_line_endings` (default) | Ignore line endings | Newline differences (Windows vs Unix) are **not** treated as changes |
| `hacked_include_line_endings` | Include line endings | Newline differences **are** counted as changes |

Both are declared by `hook_hacked_file_hashers_info()` in `hacked.module` (see
api/mechanism.md to add your own).

## Change it

Settings form: `/admin/reports/hacked/settings` (route `hacked.settings`, permission
`administer site configuration`) — a radio per hasher.

Drush / config:

```bash
drush cget hacked.settings selected_file_hasher
drush cset hacked.settings selected_file_hasher hacked_include_line_endings -y
```

```php
\Drupal::configFactory()->getEditable('hacked.settings')
  ->set('selected_file_hasher', 'hacked_include_line_endings')->save();
```

## Report routes (all require `administer site configuration`)

| Route | Path | Purpose |
|---|---|---|
| `hacked.report` | `/admin/reports/hacked` | The status report (cached) |
| `hacked.manual_status` | `/admin/reports/hacked/check` | Force a fresh check / rebuild |
| `hacked.project` | `/admin/reports/hacked/{project}` | Per-project file status |
| `hacked.project_diff` | `/admin/reports/hacked/{project}/diff` | Per-file diff (needs `diff` module + `view diffs of changed files`) |
| `hacked.settings` | `/admin/reports/hacked/settings` | This settings form |
