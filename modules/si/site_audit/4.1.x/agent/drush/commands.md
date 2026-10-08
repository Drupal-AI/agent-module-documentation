# Drush commands

Defined in `src/Commands/SiteAuditCommands.php` (registered via `drush.services.yml`, tag
`drush.command`). The command service is injected with both plugin managers.

| Command | Aliases | Purpose |
|---|---|---|
| `site_audit:audit [checklist]` | `audit` | Run one report, or all if `checklist` = `all` / omitted (interactive picker). |
| `site_audit:all` | `audit-all`, `aa` | Run every report (delegates to `audit('all', …)`). |
| `site_audit:list` | `audit-list` | Table of every report and its checks (report_id/name/description, check_id/name/description). |

## Options (for `audit` / `audit-all`)

- `--format=` — `text` (default, prints to console), `html`, `json`, `markdown`.
- `--detail` — show details even for checks with no issues.
- `--bootstrap` — wrap HTML with Bootstrap-derived styles; **forces `--format=html`**.
- `--skip=` — comma-separated. Skip whole reports by checklist id (`--skip=block,status`) **or** skip
  an individual check by its check id (e.g. `--skip=StatusSystem`, matching the check's PHP class /
  id). Default `none`.

## Examples

```bash
drush audit                       # interactive: pick a report or "All"
drush audit cache                 # just the cache report, text output
drush audit-all                   # every report
drush audit security --format=html --detail > report.html
drush audit --format=html --bootstrap --skip=insights > report.html
drush audit-list                  # list all reports + checks
```

## Permanently opting out of a check

Instead of `--skip`, disable a check for good in `settings.php`:

```php
$config['site_audit.settings']['reports']['cache'] = TRUE;
```

## Output formats

Each format has a renderer in `src/Renderer/` (`Console`, `Html`, `Json`, `Markdown`). `Console`
prints directly; the others return a string (so `> file` works). Non-text formats iterate each
checklist and concatenate output.
