Cron Time adds a single custom-interval choice to core's cron settings form so admins can make automatic cron fire on an interval of their own.

---

Cron Time is a tiny administration helper with no dependencies, entities, routes or permissions of its own. It ships a `hook_form_alter()` that targets core's cron settings form (`system_cron_settings` at `/admin/config/system/cron`). It injects one extra option into the existing **Run cron every** (`interval`) select list whose value is the number of seconds stored in the module's own config (`cron_time.settings:custom_cron_time`, default `60`), labelled "Cron Time", plus a **Cron Time** textfield where an admin types that number of seconds. On submit a custom handler saves the textfield value back to `cron_time.settings`. Core's own automated-cron mechanism (the `automated_cron` module / `system.cron` behaviour) then treats the chosen value like any other interval: cron runs on the first request after the interval elapses. The module does not run cron itself, does not add a scheduler, and does not disable cron — it only widens the interval dropdown with one admin-defined value. Config schema (`cron_time.settings`, integer `custom_cron_time`) and an install default of `60` are provided.

---

- Make automatic cron run more often than core's shortest built-in option by entering a small second count.
- Set a bespoke cron interval (e.g. 90, 300, 900 seconds) that is not one of core's preset choices.
- Give editors/admins a memorable "Cron Time" entry in the interval dropdown that maps to your site's agreed frequency.
- Standardise the automatic-cron interval across environments by shipping `cron_time.settings` in config.
- Tune cron frequency on a site where scheduled tasks (queues, updates, feeds) must run on a tighter cadence.
- Reduce cron frequency to lighten load on a low-traffic site by choosing a larger second value.
- Change the interval without editing `settings.php` or core config directly — do it from the cron admin UI.
- Keep the custom interval value version-controlled and exportable via the `cron_time.settings` config object.
- Pair with core's Automated Cron so the chosen interval is honoured on the next qualifying page request.
- Quickly experiment with different cron cadences during development by editing the Cron Time field.
- Document a site's intended cron interval as a named, visible option rather than a raw number buried in config.
- Provide a lightweight alternative to a full scheduler when all you need is a custom automatic-cron interval.
- Apply a per-site cron interval that a hosting cron job or external cron can complement.
- Use as a teaching/example module for how `hook_form_alter()` extends a core system form.
- Restore the interval by re-editing the Cron Time field if a deployment changed `custom_cron_time`.
- Set the interval to a value that matches your queue-worker or feeds-import expectations.
- Give admins a single field to adjust cron timing instead of hunting through core performance settings.
- Seed a sensible default interval (60s) on fresh installs via `config/install`.
