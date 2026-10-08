<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exporting webform submissions as XLSX

The module has **no configuration of its own** (`configure: null`). You select the exporter
per export, or save it as a webform's default.

## From the UI

*Structure → Webforms → \<webform\> → Results → Download*
(`/admin/structure/webform/manage/<webform>/results/download`)

1. **Export format → Export type**: choose **XLSX**.
2. Set the usual tabular options (header format, delimiters for multi-value elements,
   which columns, submission range…).
3. **Download** to get the file, or **Save settings** to persist those options as this
   webform's default export settings (**Reset settings** clears them).

## With Drush

```bash
# print to stdout is not useful for a binary format — always use --destination
drush webform:export contact --exporter=xlsx --destination=/tmp/contact.xlsx

# a real-world variant
drush webform:export contact \
  --exporter=xlsx \
  --header-format=key \
  --range-type=date --range-start=2026-01-01 --range-end=2026-06-30 \
  --state=completed \
  --destination=/var/www/html/private/contact-h1.xlsx
```

See [drush/webform-export.md](../drush/webform-export.md) for the full option list.

## Saved (default) export settings — where they live

Webform stores per-webform export options in **webform state**, not config:

```php
$webform = \Drupal\webform\Entity\Webform::load('contact');
$webform->getState('results.export');            // ['exporter' => 'xlsx', ...] or []
$webform->setState('results.export', ['exporter' => 'xlsx'] + $defaults);
$webform->deleteState('results.export');         // = "Reset settings"
```

With a source entity the key becomes `results.export.<entity_type>.<entity_id>`
(`WebformSubmissionExporter::getWebformOptionsName()`).

Read it back from the shell:

```bash
drush php:eval 'print_r(\Drupal\webform\Entity\Webform::load("contact")->getState("results.export"));'
```

Make XLSX the saved default for one webform:

```bash
drush php:eval '
  $webform = \Drupal\webform\Entity\Webform::load("contact");
  $options = \Drupal::service("webform_submission.exporter")->getDefaultExportOptions();
  $options["exporter"] = "xlsx";
  $webform->setState("results.export", $options);
'
```

Site-wide export defaults (used when a webform has no saved state) are Webform's own
`webform.settings:export.*`; setting `exporter: xlsx` there makes XLSX the default
everywhere.

## From code

```php
/** @var \Drupal\webform\WebformSubmissionExporterInterface $exporter */
$exporter = \Drupal::service('webform_submission.exporter');
$exporter->setWebform($webform);
$exporter->setExporter(['exporter' => 'xlsx']);   // merges over getDefaultExportOptions()
$exporter->generate();
$path = $exporter->getExportFilePath();
```

## Verify the module is working

```bash
# the plugin must be in the exporter list
drush php:eval 'print_r(array_keys(\Drupal::service("plugin.manager.webform.exporter")->getDefinitions()));'
# → [... 'delimited', 'table', 'xlsx']

drush status-report --severity=2      # PhpSpreadsheet requirement, if it were missing
```

The exporter list is also visible at `/admin/reports/webform-plugins/exporters`.

## Gotchas

- The exporter id is `xlsx` (lower case). `xls` is Webform's own legacy option on the
  `delimited`/`table` exporters.
- `openExport()` calls `FileSystem::realpath()` for `LOCAL_NORMAL` stream wrappers because
  PhpSpreadsheet cannot read `public://`-style URIs — a remote/exotic stream wrapper
  destination will fail.
- Exports with attached files are wrapped by Webform in a tar/zip archive (`--files=1`,
  `--archive-type`); the XLSX is then inside the archive.
