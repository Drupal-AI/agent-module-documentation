Drupal user / Local translator (tmgmt_local) is the TMGMT provider that lets **local Drupal users translate content inside the site**, turning submitted jobs into translation **tasks** that in-house translators pick up, translate, and hand back for review.

---

tmgmt_local registers a `local` translator plugin (`Plugin\tmgmt\Translator\LocalTranslator`) so a TMGMT provider can be backed by human users rather than an external API. When a job is submitted to a local provider, the module creates a **`tmgmt_local_task`** content entity (with `tmgmt_local_task_item` children) representing the work to be done, and exposes it to eligible translators under `/translate`. Tasks can be assigned to a specific user, assigned to oneself, unassigned, or bulk-assigned; a translator opens a task item, fills in the target text segment by segment, and marks it completed, which returns the translation to the originating job for the normal TMGMT review/accept flow. Eligibility is driven by the **tmgmt_language_combination** field (a required dependency) that records which source→target language pairs each user can handle, so tasks are only offered to capable translators. Two permissions gate the feature: `provide translation services` (be eligible to receive tasks) and `administer translation tasks` (manage and assign all tasks). It depends on `tmgmt` and `tmgmt_language_combination`; the provider is configured on the standard Providers page.

---

- Have in-house staff translate content without any external translation service.
- Create a "local" TMGMT provider backed by Drupal users.
- Turn a submitted job into translation tasks under `/translate`.
- Let a translator open a task and translate each segment inside Drupal.
- Assign a task to a specific translator.
- Let translators assign an available task to themselves.
- Unassign or reassign a task that is stuck or mis-assigned.
- Bulk-assign multiple tasks at once (`/translate/assign-multiple`).
- Offer tasks only to users whose language abilities match (via tmgmt_language_combination).
- Return completed translations to the job for the standard review/accept workflow.
- Gate eligibility with the `provide translation services` permission.
- Give coordinators the `administer translation tasks` permission to manage all tasks.
- Track task status (unassigned, pending, completed, closed) across a translation team.
- Combine with tmgmt_content to route content-entity translations to humans.
- Use as a free, fully in-Drupal alternative to a paid machine or agency provider.
- Record each translator's editorial changes back onto the source job.
- Delete a task that is no longer needed (`/translate/{task}/delete`).
- Review individual task items at `/translate/items/{tmgmt_local_task_item}`.
- Set up a small editorial-translation team on a multilingual site.
- Serve as a reference implementation of a human-backed TMGMT translator plugin.
