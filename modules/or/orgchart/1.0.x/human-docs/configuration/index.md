# Configuration

Everything about orgchart is managed from its admin area at
**Configuration → orgchart** (`/admin/config/orgchart`). This page holds both the
module's default settings and the list of charts you've created.

## Open the configuration page

1. Log in as a user with the **administer orgchart** permission.
2. Go to `/admin/config/orgchart`.

## Set your defaults

On the configuration page you set the module‑wide defaults — the styling and color
options and the default settings applied to new charts. These give every chart a
consistent starting look, which you can then override per chart.

## Create and build a chart

From the same admin area you can add, build, edit, and delete charts:

1. **Add a chart** and give it a name.
2. **Build it** with the drag‑and‑drop editor — add boxes for people or units,
   drag them into position, and use the resize handles to size them. Charts
   support multiple **displays** (for example desktop, tablet, and phone) so you
   can lay the same structure out differently per breakpoint, up to three CSS
   media queries.
3. Save. The chart definition is stored as Drupal configuration, so it can be
   exported and imported between environments.

## Editing the raw YAML

For precise or bulk changes, each chart has a **YAML editor** at
`/admin/config/orgchart/yaml/{id}/{display}`. Editing raw YAML is more powerful
than the visual builder, so it sits behind its own **administer orgchart yaml**
permission — grant it only to trusted users. You can delegate ordinary chart
management (**administer orgchart**) without handing out YAML access.

## Permissions summary

- **access orgchart** — view charts on the site.
- **administer orgchart** — create, build, edit, and delete charts, and set
  defaults.
- **administer orgchart yaml** — edit a chart's raw YAML source (restricted).

## Displaying a chart

Once a chart exists, show it by placing the **Org Chart** block (**Structure →
Block layout**) or by linking to the chart's own dedicated page. See
[How to use it](../index.md#how-to-use-it) in the overview for details.
