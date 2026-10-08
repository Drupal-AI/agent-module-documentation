<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Auto Export watches for configuration changes, writes them to a directory as they happen, and can call a webhook so something downstream — usually a CI pipeline — reacts.

---

Drupal's configuration workflow assumes discipline: change something in the UI, remember to run `drush config:export`, commit the result. The failure mode is universal and quiet — someone adjusts a view or a field on production or on a shared development site, nobody exports, and weeks later a deployment overwrites the change or a diff appears that nobody can explain. This closes the loop by exporting automatically on change, so the files always reflect the site, and by optionally firing a **webhook** so a pipeline can commit them, open a merge request or simply notify a channel. Version **2.2.2** on core `^10.3 || ^11`, settings behind `administer site configuration`, with a separate `trigger config_auto_export` permission — `restrict access: true` — for firing the webhook by hand. Three things to settle before turning it on. **The export directory must not be web-accessible**: exported configuration contains a great deal a site should not publish, and while sensitive values belong in a Key or an environment variable rather than in config, real sites have API endpoints, internal paths and email addresses in there. **The webhook URL is a credential** — anything holding it can trigger the pipeline — so it belongs in an environment variable, not in exported configuration where this very module would write it. And **automatic export changes what a config diff means**: a diff is no longer a record of deliberate change but of every change including accidental ones, so the review step moves from "export" to "commit", and someone has to be doing it.

---

- Export configuration automatically on change.
- Stop forgetting to run config:export.
- Trigger a CI pipeline on config change.
- Keep exported config in step with the site.
- Detect unexpected configuration changes.
- Open a merge request from a config change.
- Notify a channel when config changes.
- Support a config-driven deployment.
- Audit who changed what configuration.
- Keep a development site's config exported.
- Reduce configuration drift.
- Automate a config commit workflow.
- Catch a production configuration change.
- Support a GitOps workflow.
- Export config from a shared environment.
- Trigger a webhook manually (form or `drush cae:trigger`).
- Pause and resume auto-export from the CLI (`drush cae:pause` / `cae:resume`).
- Batch a burst of changes behind a delay before firing.
- Route split configs to their folders alongside config_split.
- Skip ignored config via config_ignore rules.
- Pass auth tokens or a target branch as webhook params/headers.
- Keep config exports current for review.
- Support a multi-developer team's workflow.
