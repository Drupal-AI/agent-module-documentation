<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Simplenews Handler — agent index

One Webform handler plugin that (un)subscribes a submission's email to Simplenews newsletters.
Depends on `webform` + `simplenews`. No config/permissions/schema/routes/Drush.

- **Adding + configuring the "Submission Newsletter" handler; trigger + subscribe logic** →
  [configure/handler.md](configure/handler.md)

Key facts:
- Plugin id `submission_newsletter`, class `SubmissionSimplenewsWebformHandler`, category "Newsletter",
  cardinality UNLIMITED.
- Runs in `postSave()`; calls `simplenews.subscription_manager->subscribe()/unsubscribe()` per selected
  newsletter, then sets new subscribers UNCONFIRMED and sends a confirmation (unless `skipConfirmation()`).
