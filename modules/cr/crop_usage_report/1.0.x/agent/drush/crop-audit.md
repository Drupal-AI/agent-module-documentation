<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command: `crop:audit`

Class `CropAuditCommands` (`src/Commands/CropAuditCommands.php`), extends `DrushCommands`,
registered as service `crop_usage_report.commands` with the `drush.command` tag and the
`crop_usage_report.audit_service` injected. Uses PHP-8 Drush attributes (`Drush\Attributes`).

Command name **`crop:audit`**, alias **`crop-audit`**.

## Options

| Option | Default | Meaning |
|---|---|---|
| `--crop-types` | `''` | Comma-separated crop type machine names. Overrides the module config; empty = fall back to `getAuditCropTypes()` (config, else all). |
| `--bundles` | `''` | Comma-separated media bundle machine names. Overrides config; empty = fall back to `getImageMediaBundles()` (config, else all image bundles). |
| `--format` | `table` | Output format: `table`, `csv`, or `ids`. |

The command splits each option on `,` with `array_map('trim', explode(...))`, logs a `notice`
naming the effective crop types and bundles, then calls
`auditService->runAudit($crop_types, $bundles)` (passing the raw option arrays, so an empty
option lets the service apply its own config fallback and shared cache). Empty results log the
success `NO_ISSUES_MESSAGE`.

## Output formats

- **`table`** (default): a padded fixed-width table (`MID / Name / Bundle / Missing crop types /
  Edit URL`), values truncated with `mb_strimwidth`, followed by a success line
  `Audit complete. N item(s) require attention.`
- **`csv`**: header `mid,name,bundle,filename,missing_crop_types,edit_url` then one CSV line per
  result (fields `addslashes`-escaped, missing types joined by `|`, absolute edit URL).
- **`ids`**: one media id per line — convenient for piping into other Drush/shell commands.

## Examples (from the command's `#[CLI\Usage]` attributes and README)

```bash
# Audit using the admin-UI settings.
drush crop:audit

# Only specific crop types.
drush crop:audit --crop-types=focal_point,hero_banner

# Only specific media bundles.
drush crop:audit --bundles=image

# CSV to a file.
drush crop:audit --format=csv > missing-crops.csv

# Just the media IDs, for piping.
drush crop:audit --format=ids
```

## Note

The command reads the same permanent result cache (tag `crop_usage_report`) as the web report,
so run `drush cache:rebuild` — or the report's **Refresh report** action — after applying crops
to get fresh output.
