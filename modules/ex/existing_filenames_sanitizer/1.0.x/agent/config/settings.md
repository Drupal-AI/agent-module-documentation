<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: it reads core `file.settings`, ships none of its own

This module defines **no config objects and no config schema**. It has no `config/install/`, no `config/schema/`,
no settings form and no `configure` route. Its sanitization defaults come entirely from Drupal **core's**
`file.settings` configuration.

## Where the defaults come from

In `ExistingFilenameSanitizerCommands::sanitizeFilenames()`:

```php
$file_settings = $this->configFactory->get('file.settings');
$sanitization_settings = $file_settings->get('filename_sanitization');
```

`file.settings:filename_sanitization` is the core mapping edited at **Configuration → Media → File system**
(`/admin/config/media/file-system`), under "Sanitize filenames". Its keys map 1:1 to the command's rule options:

| `filename_sanitization` key | Command option |
| --- | --- |
| `transliterate` | `--transliterate` |
| `replace_whitespace` | `--replace-whitespace` |
| `replace_non_alphanumeric` | `--replace-non-alphanumeric` |
| `deduplicate_separators` | `--deduplicate-separators` |
| `lowercase` | `--lowercase` |
| `replacement_character` | `--replacement-character` |

For each rule the command uses `$options[x] ?: $sanitization_settings[x]` — a CLI option that is set wins, otherwise
the stored core value is used. (Note the `?:` semantics: an option left FALSE cannot turn a rule OFF that core config
has ON; it can only add rules on top of the stored config.)

## Managing the core settings

```bash
# Inspect / edit the core config that drives defaults
drush config:edit file.settings

# Or via the admin form
#   /admin/config/media/file-system  → "Sanitize filenames"

# Export / import as usual
drush cex
drush cim
```

## Practical note

Because this module only *reads* `file.settings`, configure core's filename sanitization the way you want new uploads
handled, then run `drush efssf --dry-run` to see that same policy applied retroactively to existing files. If you want
a run that ignores the stored policy, pass the exact rule options you want on the command line instead. See
[../drush/commands.md](../drush/commands.md).
