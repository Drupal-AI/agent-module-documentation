Adds a config entity and admin UI so site builders can create, configure, enable and run Batch Plugin plugins without writing code.

---

Batch Plugin Entity is the UI layer for the Batch Plugin framework. It defines the `batch_plugin_entity` configuration entity, each instance wrapping one discovered batch plugin through a lazy plugin collection and storing that plugin's settings (including which processor — Batch API, cron, or queue — should run it). An admin section under *Structure → Batch plugins* (`/admin/structure/batch-plugin`) lists the entities, offers an add flow that presents every non-hidden batch plugin, and provides edit/delete forms plus a **Process** button that executes the configured plugin on demand. All routes are gated by the single permission `administer batch_plugin_entity`. It depends on `batch_plugin` and requires no code to operate a batch job.

---

- Give site builders a no-code way to run existing batch plugins from the admin UI.
- Create a named, saved configuration of a batch plugin (label, description, processor, plugin settings).
- Choose per entity whether a plugin runs via Batch API, a queue, or on cron.
- Enable or disable a batch job without deleting its configuration.
- Trigger a one-off run of a configured job with the Process button.
- Schedule a plugin on cron by selecting the cron processor and a cron expression, managed from the UI.
- Expose only the batch plugins you want by marking internal plugins `hidden` in their attribute.
- Restrict a plugin's UI availability to users holding a specific permission (the add-list honours the plugin's `permission`).
- Export the resulting configuration entities as part of a site's config for deployment.
- Let editors pick target content bundles for a batch through the plugin's own configuration form rendered in the entity edit form.
- Manage many independent batch jobs from one collection listing with label, machine name, plugin id, provider, processor and status columns.
- Automatically provision a dedicated queue per cron/queue-backed entity (via the queue-worker deriver).
- Clean up an entity's queue automatically when the entity is deleted or switched away from a cron processor.
- Provide an admin landing page under Structure for all batch operations on the site.
- Combine code-defined batch plugins with UI-configured instances discovered together by `getDefinitionsByType()`.
