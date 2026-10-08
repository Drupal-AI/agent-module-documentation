# Academic Marksheet — manual setup guide

**Academic Marksheet** (`academic_marksheet`) is a basic grade-management tool for
schools and academic sites that want to keep student marks inside Drupal. It
records marks per student and subject and produces result sheets (marksheets) from
them, so you can manage grades without a separate system.

The module leans on standard Drupal building blocks — it depends on core's
**Views**, **Field**, **User**, and **Taxonomy** modules — and layers a small
marks-and-results workflow on top of them.

Access is governed by three permissions, and because marks are personal data it
matters who holds each one. **`administer marksheet`** covers overall
administration, **`assign marks`** covers entering marks for students, and
**`view own results`** lets a student see only their own results. Keep the
administration and assign-marks permissions with staff, and give students only the
self-service view.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

> **Note on the available documentation.** The upstream agent docs describe the
> module's purpose and permissions but do not spell out an exact settings-page
> path or a field-by-field configuration breakdown, so the description below is
> high-level. Confirm the specifics against the module's own README once it is
> installed.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling the module, set up the permissions first: grant `administer
marksheet` and `assign marks` to staff, and `view own results` to the student
role. Staff then record marks per student and subject, and the module generates
the corresponding result sheets. Students with the self-service permission can
view their own results. Treat all of this data as personal information and keep
the assign/administer permissions off ordinary accounts.
