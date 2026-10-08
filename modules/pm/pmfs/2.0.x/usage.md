<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevent Multiple Form Submissions (pmfs) blocks duplicate and concurrent submissions of the same form on the server side, instead of relying on JavaScript to disable the submit button. It also exposes a small service API so custom code can guard its own operations with the same locking mechanism.

---

The module works entirely through `hook_form_alter`: for each form you enable at `/admin/config/system/pmfs` it injects its own validate and submit handlers onto every button. On submit it acquires a **persistent lock** (core's `lock.persistent` backend) whose key is built from the form id plus a per-visitor value stored in a `pmfs_key` cookie that an event subscriber sets on the first request. While that lock is held, any further submission of the same form by the same visitor fails validation with a configurable message ("The form still processing, please, try again later." by default). The **timeout** (default 30s) is how long the lock is held; with **skip timeout** enabled the lock is released the moment the initial submit handler finishes, so a visitor only waits as long as the real processing takes rather than the whole window. This is therefore the "same visitor + same form id + time window" model — it guarantees idempotency/serialisation for one visitor's repeated clicks, back-button re-POSTs, lost-response retries and concurrent tabs, but it is **not a rate limiter and not cross-visitor abuse protection** (each visitor has an independent lock namespace via their own cookie), and because the discriminator is a cookie rather than a per-render token, a legitimate visitor deliberately submitting the *same* form again within the timeout is also blocked. Beyond forms, any controller can call the `pmfs` service's `isCustomRequestExecutable($id)` / `setCustomRequestDone($id)` to wrap a custom operation in the same lock. A development mode records every rendered form id (in state) so administrators can discover the exact ids to configure, and there is per-form config-translation support. Note the release is old (packaged 2023) while still declaring `^10 || ^11`; the settings route is gated by `administer site configuration` and the module ships no permissions or Drush commands of its own.

---

- Stop an order form being submitted twice by an impatient double-click.
- Prevent duplicate user registrations from a resubmitted POST.
- Block a payment form from being replayed after a slow response.
- Serialise concurrent submits of the same form from two browser tabs.
- Prevent duplicate nodes created from one editor submission.
- Cover browsers where the client-side double-submit script did not run.
- Guard against back-button resubmission of a form.
- Protect a Webform or contact form from duplicate entries.
- Reduce reconciliation work from duplicated records.
- Stop duplicate comments from repeated clicks.
- Protect a booking/scheduling form from double booking within a window.
- Handle a flaky connection where the request arrived but the response was lost.
- Prevent duplicate support tickets.
- Protect a survey from double entries per visitor.
- Reduce duplicate leads submitted through a form.
- Add server-side submit validation without theming or JS changes.
- Show a custom "still processing" message when a duplicate submit is caught.
- Use skip-timeout so users are not made to wait the full window after a quick submit.
- Wrap an AJAX form callback so the callback itself is lock-protected.
- Guard a custom controller/route operation with `isCustomRequestExecutable()` to keep one processing per visitor.
- Force-attach `core/drupal.form` on a specific form that lost the library.
- Use development mode to list the form ids currently being rendered on the site.
- Configure a different timeout and message per form id, with a global default.
- Translate per-form validation messages via config translation.
