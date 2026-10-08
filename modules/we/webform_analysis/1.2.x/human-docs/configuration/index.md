# Configuration

Webform Analysis has no global settings page. You configure the analysis per
webform, on that webform's own **Analysis** tab, and the settings are saved with
the webform.

## Open the Analysis tab

1. Make sure you have Webform's results access (for example "view any webform
   submission") — this module uses Webform's own permissions rather than defining
   its own.
2. Go to **Structure → Webforms**, open the webform you want, and go to its
   **Results → Analysis** tab, or navigate directly to
   `/admin/structure/webform/manage/{webform}/results/analysis`.

## Analysis settings

- **Components** — the webform elements to analyze. Tick the elements you want
  statistics for (for example a "How did you hear about us?" select, or a rating).
  You can analyze several elements at once, each getting its own chart or table.
- **Chart type** — how each analyzed component is displayed:
  - **Table** — a plain table of value counts, shown when a chart is not selected.
  - **Pie chart** — good for showing the share each option received.
  - **Column chart** — good for comparing counts across options.
- **Start date** and **End date** — an optional date range that bounds which
  submissions are counted. Set them to report on a single campaign or period;
  leave them empty to include all submissions.
- **Include draft submissions** — when turned on, submissions still in draft are
  included in the counts. Leave it off to report only on finalized submissions for
  cleaner numbers.

Save the tab and the analysis renders right there: for each chosen component you
see the value counts, with human‑friendly labels (checkboxes show Yes/No,
reference elements show the referenced labels) and the count shown next to each
value.

## Embedding a chart elsewhere with the block

The module also provides a **Webform Analysis** block so you can surface a
component's chart or table outside the Analysis tab — on a dashboard, for example.

1. Go to **Structure → Block layout** and place the **Webform Analysis** block in
   a region (or add it through your Layout Builder / block placement workflow).
2. Configure the block to point at the webform and component you want to display.

The block renders the same chart or table as the Analysis tab for that component.

## Where the settings live

All of these choices are stored with the webform itself (as third‑party settings
on the webform's configuration), so they travel with the webform when you export
and deploy configuration between environments.
