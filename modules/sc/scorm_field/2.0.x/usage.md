<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scorm field lets you attach a SCORM e-learning package (a ZIP) to a Drupal node field and plays it back in an iframe SCORM 1.2 / 2004 player that tracks each learner's score and completion.

---

The module defines a **`scorm_field_scorm_package`** field type (extends core `FileItem`, restricted to `.zip`, stored under `public://scorm_field`). When a node with that field is saved, `ScormFieldScormPackageItemList::postSave()` calls `ScormFieldScorm::scormExtract()`, which unzips the package into `public://scorm_field_extracted/scorm_<fid>`, reads `imsmanifest.xml` with a custom expat parser (`XML2Array`), and stores the parsed course structure — SCOs, resources, sequencing control modes and objectives, and manifest metadata — across the `scorm_field_scorm_packages`, `scorm_field_scorm_package_scos` and `scorm_field_scorm_package_sco_attributes` tables. On display, the **"Scorm player"** formatter (`ScormFieldScormFormatter`) uses `ScormFieldScormPlayer` to build a themed render array (`scorm-field-scorm--player`) with an iframe pointing at `/scorm-field-scorm/player/sco/{id}`, attaching the `scorm-field-scorm-player` library (`js/lib/api-1.2.js`, `api-2004.js`, `player.js`, `scorm_field.player.js`) which implements the SCORM JavaScript runtime and posts CMI data back to `/scorm-field-scorm/scorm/{scorm_id}/{scorm_sco_id}/{nid}/commit`. CMI values (location, suspend_data, score, status, objectives) are persisted per user in `scorm_field_scorm_cmi_data` by helpers in `scorm_field.module`, and pass/fail score reports are written through `ScormFieldCommonService::saveScormReport()` into `scorm_report` records; the module integrates with **`attempt_mgmt`** (a hard dependency) to manage learning attempts, installing a `scorm` attempt type plus `field_score_raw/min/max` and `field_scorm_status` fields on the attempt entity. Two Views (`scorm_attempts`, `scorm_report_per_node`) present the reports, gated by a custom Views access plugin. Per content type, a node-type third-party settings form controls iframe responsiveness, dimensions and scrolling. A **decoupled mode** (configured at `/admin/config/system/scorm_field/settings`, which stores a shared `decoupled_access_token`) exposes `@RestResource` endpoints — get-access-token, create-attempt, report and scorm-data — and a token-gated `/scorm-field-decoupled/{node}/{token}` route (custom Stark theme, chrome stripped) so a headless front-end can embed the player in an iframe on another domain. A `scorm field reset scorm data` permission gives editors an AJAX "Reset scorm data" button on the node form.

---

- Upload a SCORM 1.2 or SCORM 2004 course as a ZIP to a node and play it inline.
- Add a "Scorm field" to any content type via *Manage fields* (listed under Reference fields).
- Deliver e-learning modules, compliance training or onboarding courses inside a Drupal site.
- Track each learner's completion status (completed / passed / failed / incomplete) per course node.
- Record raw / min / max scores reported by the SCO and store them as attempt reports.
- Resume a learner where they left off using stored `cmi.suspend_data` / `cmi.location`.
- Present a navigable SCO tree for multi-SCO packages (organizations, items, sequencing).
- Support both SCORM 1.2 (`cmi.core.*`) and SCORM 2004 (`cmi.*`) runtime data models.
- Manage repeat attempts through the attempt_mgmt integration (last attempt, force new attempt).
- Show per-node and per-attempt reporting through the bundled `scorm_attempts` / `scorm_report_per_node` Views.
- Let an editor reset a course's stored SCORM data from the node edit form (permission-gated button).
- Configure iframe sizing, responsive behavior and scrolling per content type.
- Embed the player responsively (1:1 in % or dvh) or at fixed pixel/percent dimensions.
- Run the player headless / decoupled: a front-end requests a one-time token and gets an iframe URL.
- Expose SCORM completion data to a decoupled app via `/api/scorm-data/{user_id}?nids=[…]`.
- Fetch a node's SCORM report over REST (`/api/scorm-field-scorm-report/{nid}`), optionally filtered by user UUID.
- Create a fresh learning attempt from a decoupled front-end (`/api/scorm-field-scorm-create-attempt`).
- Look up the start SCO for a package by file id (`/api/scorm-field-scormstartsco/{fid}`).
- Serve SCORM content to authenticated learners as well as anonymous visitors (session-keyed tracking).
- Provide iOS 13 SCORM playback compatibility via the bundled `scorm_field_scorm_ios_13.js` library.
- Store course structure in queryable DB tables for custom reporting or integrations.
- Uninstall cleanly — the module drops its own SCORM tables on uninstall.
