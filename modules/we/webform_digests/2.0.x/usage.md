<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Digests sends periodic summary emails of webform submissions instead of one email per submission.

---

Install it alongside the **Webform** module (it depends on `webform:webform`) and enable it; there is no settings page. You create one **Webform digest** per form at *Structure → Webform digest* (`/admin/structure/webform_digests`), setting a recipient, a from address, a subject, a body and the target webform — every one of those fields accepts **tokens**, including a `[webform_digest:submissions]` list of the included submissions' labels and a `[webform_digest:submissions_count]`. Optionally attach **conditional logic** (the same `#states` selectors Webform uses) so a digest only counts submissions that match. On cron the module queues one job per digest and mails **one message per source entity**, covering the submissions whose *changed* time falls in the window; the body is delivered as plain text. Scheduling is controlled by config `webform_digests.settings` — `cron.enabled`, `cron.frequency` (`hour`/`day`/`week`, default `day`) and `cron.hour` (default `9`) — which has **no UI** and is changed by overriding it in `settings.php`, e.g. `$config['webform_digests.settings']['cron.frequency'] = 'week';`. You can also disable the built-in cron and instead hit `GET /admin/structure/webform_digests/send` (permission *Send webform digest*) or run `drush webform:queue-digests` from an external scheduler. Two dedicated permissions gate the module — *Edit any webform digest* and *Send webform digest* — while creating and editing digest entities requires *administer site configuration*. Version **2.0.0-rc3**, a release candidate, on core `^9 || ^10 || ^11`. Two things to plan: digests are only as reliable as the site's cron and the failure is silent, and because a digest is a batch by design it is the wrong shape for anything urgent, so keep immediate per-submission notification for forms that report faults or failures.

---

- Replace per-submission emails with a periodic digest.
- Send a daily summary of enquiries to a team address.
- Send a weekly digest instead of an email per submission.
- Reduce notification email volume from a busy form.
- Stop a high-volume form flooding an inbox.
- Report how many submissions arrived in the last day or week.
- Send a digest counting registrations or sign-ups.
- Restrict a digest to submissions matching conditional logic.
- Only digest submissions where a given field has a value.
- Route a digest to a per-node author using tokens.
- Group submissions by their source node into separate emails.
- Change the digest frequency to hourly, daily or weekly.
- Set the hour of day after which digests are sent.
- Disable the built-in cron and trigger sends from an external scheduler.
- Trigger a digest send from a URL for an OS cron job.
- Queue digests on demand with a drush command.
- Summarise applications or feedback received.
- Support a scheduled batch-review workflow for submissions.
- Reduce inbox pressure on staff who triage forms.
- Keep detailed submission data behind the site rather than in every email.
