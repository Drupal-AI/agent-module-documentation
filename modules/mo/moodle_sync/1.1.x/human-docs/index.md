# Moodle Sync — manual setup guide

**Moodle Sync** (`moodle_sync`) keeps data in step between Drupal and a
**Moodle** LMS by pushing Drupal entities into Moodle through Moodle's built-in
web services. When you create a Drupal entity, the matching Moodle component
(course, category, cohort, user, enrolment, and so on) is created; when you
update the Drupal entity, the corresponding Moodle component is looked up and
updated. It's the integration layer for sites that manage learning content or
membership in Drupal and want it reflected in Moodle automatically.

The base module provides the connection and the shared machinery; the actual
syncing is split across **submodules**, so you enable only the pieces you need:

- **`moodle_sync_category`** — syncs Drupal taxonomy terms into Moodle course
  categories.
- **`moodle_sync_course`** — syncs Drupal entities into Moodle courses.
- **`moodle_sync_template`** — syncs taxonomy terms into Moodle courses used as
  templates.
- **`moodle_sync_cohorts`** — syncs taxonomy-term references into Moodle cohort
  membership.
- **`moodle_sync_enrollments`** — syncs Drupal registrations into Moodle user
  enrolments.
- **`moodle_sync_users`** — syncs Drupal users and profiles into Moodle users.
- **`moodle_sync_completion`** — receives Moodle completion data back from Moodle
  (requires the Moodle-side `local_completion_push` plugin).

How the mapping works is worth understanding up front: the Drupal entity ID is
written into the Moodle component's `idnumber`, and the Moodle ID is written back
into the Drupal entity's `field_moodle_id`. On update, the module finds the Moodle
component via that stored ID; if `field_moodle_id` is empty it tries to create a
new component; and if you put an **invalid** value (e.g. `ignore`) into
`field_moodle_id`, that entity stops syncing. As a safety measure, the module also
stores the current Drupal site path and refuses to write to Moodle if the
database is copied to a different site (so a cloned test site won't clobber your
live Moodle data).

> **Security-advisory note:** this module is **not covered** by Drupal's security
> advisory policy. Evaluate accordingly before production use.

This talks to Moodle's API with a **web-service token** and exchanges user and
enrolment data (PII). Store the token as a **secret** (env-backed / Key module),
connect over **HTTPS**, and handle the personal data in line with your privacy
obligations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and the submodules you need.
2. [Configuration](configuration/index.md) — set up Moodle web services, the API
   token, field mappings, and the safety site-path setting.

## Where it lives in the admin menu

Once enabled, the settings live at **Configuration → Moodle Sync → Settings**
(`/admin/config/moodle_sync/settings`). See [Configuration](configuration/index.md).
