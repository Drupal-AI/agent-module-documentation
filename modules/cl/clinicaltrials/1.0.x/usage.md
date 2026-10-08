<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Clinical Trials imports public study records from the ClinicalTrials.gov REST API v2 into Drupal as nodes of a dedicated content type, driven from the command line.

---

Clinical Trials integrates the public **ClinicalTrials.gov API v2** into Drupal. It ships a **"ClinicalTrials" content type** whose title field is the study's NCT id and whose single `field_data` field stores the full serialized `protocolSection` of the study. An administrator configures the API connection and query filters (base URL, endpoint, lead sponsor, overall status, returned fields, page size, markup format) on a settings page gated by the `administer clinical trials config` permission. Importing is then run from the **CLI**: `drush ct-import-studies` fetches every matching study page by page in a batch, creating a node per trial (or updating the existing node with the same NCT id). A companion `drush ct-delete-studies` command removes nodes for trials that are no longer returned by the API, by diffing the current import against the previous one (tracked via the State API). There is no front-end search or query UI — all fetching happens through Drush (and thus can be scheduled with cron). The module depends only on core's Language module and supports Drupal 8 through 11.

---

- Import matching ClinicalTrials.gov studies into Drupal as nodes of the `clinicaltrials` content type.
- Store each study's full `protocolSection` (serialized) in the node's `field_data` field for later processing.
- Use the study's NCT id (e.g. `NCT01234567`) as the node title, keeping imports idempotent (re-import updates the existing node).
- Filter which studies are pulled by lead sponsor (`query.lead`) and overall status (`filter.overallStatus`).
- Limit the returned API fields and choose markup format (`legacy` / `markdown`) from the settings form.
- Page through large result sets automatically using the API's `nextPageToken` in a Drupal batch.
- Run imports on demand or on a schedule via cron with `drush ct-import-studies`.
- Prune stale trials with `drush ct-delete-studies`, which deletes nodes for studies no longer in the API result set.
- Restrict configuration access to trusted roles via the `administer clinical trials config` permission.
- Keep the "ClinicalTrials" content type translatable (the module depends on core Language).
- Prevent accidental uninstall while imported trial nodes still exist (uninstall validator).
- Present curated trial listings on medical, research, and healthcare sites sourced from the official registry.
