# Configuration

Most of Taxonomy Overview is used through the **Reports** section (see the
[main guide](../index.md) for the dashboard and report walk-through). The pieces you
actually *configure* are the trend settings form and the permissions that govern the
action plan workflow.

## Trend settings

The module has a settings form for its trend and drilldown features at
**Configuration → System → Taxonomy Trend settings**
(`/admin/config/system/taxonomy-trend-settings`). Open it to adjust how the trend
chart and time-series reporting behave, then save. If you never open it, the reports
still work with their defaults.

## Permissions — separate duties by role

This is the most important thing to configure, because the module can delete and
re-reference content. Go to **People → Permissions**
(`/admin/people/permissions`) and assign the module's granular permissions
deliberately:

| Permission | What it allows |
|------------|----------------|
| `taxonomy_overview view action plans` | See the action plan listing and individual plans. |
| `taxonomy_overview create action plans` | Create clean-up and merge action plans. |
| `taxonomy_overview approve action plans` | Approve a plan so it can run — the governance gate. |
| `taxonomy_overview execute action plans` | Run an approved plan. |

Because clean-ups and merges are destructive, use these permissions to **separate
duties**: let one role create plans and a different, more trusted role approve and
execute them. The approval gate exists precisely so that no single person can both
propose and carry out a bulk deletion or merge unchecked.

## Operational notes

- Run `drush updb` after module updates that add schema fields, and `drush cr` after
  route, menu, or command changes.
- For large datasets, always run clean-ups and merges with `--dry-run` first.
- The action plan lifecycle (pending → approved → running → completed, plus failed /
  cancelled / retry) and the execution claim guard are there to reduce the risk of
  duplicate or concurrent execution — lean on them rather than bypassing the workflow.
