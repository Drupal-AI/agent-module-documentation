# Configure — SEO Checklist

SEO Checklist has **no settings form of its own**. Its `configure` route is the Checklist API
checklist page it registers:

- Route: `checklistapi.checklists.seo_checklist`
- Path: `/admin/config/search/seo-checklist`
- Menu: Admin → Configuration → Search and metadata → **SEO Checklist**
  (`seo_checklist.links.menu.yml` places it under `system.admin_config_search`).

The route, the vertical-tab UI, the progress bar, the two per-checklist permissions, and the
saving of progress are all provided by **Checklist API** (dependency
`checklistapi:checklistapi`), not by this module.

## Using it

- Visit the checklist and check off each SEO task as you complete it, then click **Save** —
  progress is not stored until you save.
- Items whose recommended module is already installed are **pre-checked** automatically
  (`#default_value` is set from `\Drupal::moduleHandler()->moduleExists()`).
- Each module item renders Download / Install links (and a **Configure** link when the target
  route exists and you have access, and a **Configure permissions** link when the module is
  installed and has a `*.permissions.yml`).

## Storage & permissions

- Progress is persisted by Checklist API in the config object
  `checklistapi.progress.seo_checklist` (recording who checked each item and when).
- Access is gated by Checklist API's auto-generated per-checklist permissions
  (e.g. *view seo_checklist checklist* / *edit seo_checklist checklist*) — see the checklistapi
  docs. SEO Checklist defines no permissions itself.

## Uninstall

`hook_uninstall()` deletes `checklistapi.progress.seo_checklist`, so removing the module clears
the stored progress.
