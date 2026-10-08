Extends Simplenews so a newsletter issue can be sent on a schedule and, optionally, resent repeatedly at a fixed interval — each run clones the template newsletter node into a new "edition" and sends it via cron.

---

The module adds a **Scheduled Newsletter** section to the Simplenews send tab of a newsletter node (`simplenews_scheduler_form_simplenews_node_tab_alter`), shown to users with the `send scheduled newsletters` permission. There you activate scheduling and set a start date, a send frequency/interval (e.g. every N days/weeks/months), and how the run ends (a fixed number of editions, an end date, or none). The settings are stored in a custom `simplenews_scheduler` database table keyed by the template node id; `hook_cron` (`simplenews_scheduler_cron`) finds schedules whose next run time is due, computes the edition time, **clones the template node** into a new edition node (`simplenews_scheduler_clone_node`, firing `hook_simplenews_scheduler_edition_node_alter` so you can dynamically rewrite the cloned node before it saves), and hands the edition to Simplenews for sending. Each template node exposes a **Newsletter Editions** tab at `/node/{node}/editions` (route `simplenews_scheduler.node_page`, controller `EditionsController`) listing past/upcoming editions, guarded by a custom access check requiring the `overview scheduled newsletters` permission. A single config value, `simplenews_scheduler.settings:default_send_action` (default `5` = SIMPLENEWS_COMMAND_SEND_NONE), sets the initial send action. There is no global settings form (`configure` is null); the module also ships a `simplenews_scheduler_views.inc` for Views integration and a `hook_simplenews_scheduler_edition_node_alter` API hook.

---

- Schedule a Simplenews newsletter to send automatically at a future date/time.
- Send a recurring newsletter (daily/weekly/monthly) from a single template node.
- Automatically generate a fresh "edition" node for each recurring send.
- Stop a recurring newsletter after a set number of editions.
- Stop a recurring newsletter on a specific end date.
- Run an open-ended recurring newsletter with no end.
- Dynamically rewrite each edition's title/body before it sends via the alter hook.
- Insert the current date or schedule-driven data into each edition automatically.
- Review a newsletter's past and upcoming editions on its Editions tab.
- Restrict who can schedule newsletters with the `send scheduled newsletters` permission.
- Restrict who can view the editions overview with `overview scheduled newsletters`.
- Drive all scheduled sends from Drupal cron (no manual send step).
- Resend/refresh a periodic digest newsletter on a cadence.
- Automate a "newsletter of the week/month" from one editable template.
- Keep an audit trail of generated editions per template newsletter.
- Build Views reports over scheduled newsletters using the bundled Views integration.
- Set a site-wide default send action for newly scheduled newsletters.
- Pre-stage seasonal or campaign newsletters to fire on their launch date.
- Clone a template's fields into each edition so content teams edit one node.
- Integrate scheduled newsletter data into custom dashboards via the Editions controller/table.
