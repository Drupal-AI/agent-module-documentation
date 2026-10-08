<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fileslog — Drush commands

New in 1.3. Defined in `src/Drush/Commands/FileslogCommands.php` (autowired via `AutowireTrait`;
no `drush.services.yml`). Two commands.

## `fileslog:show`
Aliases: `fs-show`, `fss`, `fileslog-show`.

Prints the most recent log entries as a table. Newest first (reads through
`FilesLogManager::getLogs()`).

Options:
- `--count=N` — number of messages to show. Default **10**.
- `--extended` — include the `link` and `referer` columns and stop truncating the message
  (default truncation is 188 chars).

Default columns: `date`, `type` (channel), `severity`, `message`. Available field labels also
include `location` (request uri), `hostname`, `username`, `uid`, `link`, `referer` — selectable
with the standard `--fields=` / `--format=` options (returns a `RowsOfFields`, so `--format=json`,
`csv`, `yaml`, etc. all work). Prints "No log messages available." when empty.

Examples:
```
drush fileslog:show
drush fileslog:show --count=46
drush fileslog:show --extended --fields=date,type,severity,message,hostname
drush fss --format=json
```

## `fileslog:delete`
Aliases: `fs-del`, `fs-delete`, `fsd`, `fileslog-delete`.

Deletes **all** log files and their channel directories under `private://logs`
(`FilesLogManager::deleteLogs()`). No confirmation prompt. Prints "Cleared the logs."

```
drush fileslog:delete
```

Note: messages/severity are `strip_tags`-cleaned and decoded before printing; unknown severities
render as an empty severity cell.
