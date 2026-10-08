# Webform XLSX Export — manual setup guide

**Webform XLSX Export** (`webform_xlsx_export`) adds a real **XLSX** (Excel) option to
Webform's results-export screen and to its Drush export command. Webform core can already
"export" to a `.xls` file, but that file is really just an HTML table with an Excel
extension — and modern versions of Excel warn that "the file format and extension don't
match" when you open it. This module produces genuine Office Open XML workbooks instead,
using the PhpSpreadsheet library, so the files open cleanly in Excel, Google Sheets, Power
BI and anything else that reads real spreadsheets.

It contributes exactly one exporter plugin, with the id **`xlsx`** and the label **XLSX**,
which Webform discovers automatically. Because it builds on Webform's tabular exporter, it
inherits all the usual options — which columns to include, label-vs-key headers,
delimiters for multi-value fields, entity-reference handling, submission ranges, and so on.
It also bolds the header row for you and, as a safety measure, writes any answer beginning
with `=` as literal text rather than a spreadsheet formula (guarding against formula-
injection). The module has **no settings page, no permissions and no configuration of its
own** — enabling it is the whole install. It depends on Webform (`^6.2`) and the
PhpSpreadsheet library (`^3.5`), which Composer installs for you.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and PhpSpreadsheet) with
   Composer and enable it.

## How to use it

There is nothing to configure — once the module is enabled, the XLSX option appears
wherever Webform exports submissions.

**From the admin UI:** go to a webform's results and open the Download tab —
**Structure → Webforms → \<your webform\> → Results → Download**
(`/admin/structure/webform/manage/<webform>/results/download`). In the **Export format**
options choose **XLSX**, set the usual tabular options (header format, column selection,
submission range), and click **Download**. Use **Save settings** on the same screen if you
want XLSX to become that webform's remembered default export format.

**From Drush:** the module plugs into Webform's own `webform:export` command through the
`--exporter=xlsx` option. A destination file is effectively required, because a binary
workbook printed to the screen is not useful:

```bash
drush webform:export contact --exporter=xlsx --destination=/tmp/contact.xlsx
```

You can combine it with Webform's normal export options, for example last-100 completed
submissions with machine-name headers:

```bash
drush webform:export contact --exporter=xlsx --header-format=key \
  --range-type=latest --range-latest=100 --state=completed \
  --destination=/tmp/contact-latest.xlsx
```

This makes it easy to schedule a nightly submission dump from cron.

**Check it is available:** the exporter list appears at
`/admin/reports/webform-plugins/exporters`, and the site **Status report**
(`/admin/reports/status`) tells you whether PhpSpreadsheet is installed — the one thing
XLSX export depends on.
