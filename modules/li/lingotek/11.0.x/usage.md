<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ray Enterprise Translation (formerly Lingotek) connects Drupal to a translation management system: content, configuration and interface strings are uploaded, translated by machine or by professional translators, and pulled back into Drupal as translations.

---

This is the enterprise end of Drupal multilingual. Rather than translating in Drupal's own UI, entities are enrolled in *profiles* that decide when they upload, whether translation is automatic or requested, and which target locales apply; a dashboard tracks the state of every document; a job-management layer groups work for a vendor. Content entities, config entities and the interface all go through the same pipeline, which is the main argument for it over piecemeal tools — one place to see what is translated, what is in progress and what has drifted.

The integration is bidirectional, so the site exposes a callback at `/lingotek/notify` that the TMS calls when a document changes state. That endpoint's access check is genuinely well built and worth citing as an example: Basic Auth with `hash_equals()` on the username, `password_verify()` against a stored bcrypt hash, failing closed when unconfigured, with caching disabled on the result. Very few webhook endpoints reviewed in this campaign do all four.

**One defect to fix before production, verified on a clean install.** Both rejection paths log `json_encode($request->headers->all())`, which includes `authorization` and — because PHP parses Basic auth itself — `php-auth-pw`. A request with wrong credentials wrote the presented password to `watchdog` **in plain text**. The paths that fire are exactly the ones that fire when a *legitimate* callback stops authenticating (rotated secret, restored backup, proxy rewriting), so the real shared secret ends up in the log, readable by anyone with `access site reports` and by every downstream log consumer. Redact the header set before logging.

---

- Send content to a professional translation vendor.
- Machine-translate content through a managed pipeline.
- Translate configuration entities as well as content.
- Translate interface strings through the same system.
- Enrol content types in translation profiles.
- Upload automatically when content is saved.
- Request translation manually for selected items.
- Track document state on a dashboard.
- Group translation work into jobs for a vendor.
- Receive translation-complete callbacks from the TMS.
- Detect content that has drifted from its translation.
- Assign translation profiles per entity.
- Restrict who may administer the integration.
- Separate profile assignment from full administration.
- Audit which content is translated and which is stale.
- Redact the notify endpoint's failure logging before go-live.
- Rotate the callback shared secret safely.
- Plan a multilingual rollout with a translation vendor.