# Image Field Permissions — manual setup guide

**Image Field Permissions** (`image_field_permissions`) gives you fine‑grained,
per‑role control over image fields. It builds on the contrib
[Field Permissions](https://www.drupal.org/project/field_permissions) module and
adds image‑specific access rules, so you can decide separately who may **create**,
**edit** or **view** the image file, and — importantly — who may edit the image's
**alt** and **title** text.

The classic use case is letting a translator or a junior editor fix the alt and
title attributes of an image (for accessibility, or for translation) *without*
letting them replace or remove the underlying image file. You can grant "edit own"
versus "edit any" independently for the file, the alt value and the title value, so
authors can manage their own uploads while metadata stays editable for
accessibility and the original imagery is protected.

Enforcement happens on the content form: for each image field the module checks the
current user's permissions and, where the file value isn't editable, hides the
upload and remove buttons; where a restricted user shouldn't touch the metadata, it
hides the alt/title sub‑widgets — while still letting the field render so it can be
viewed. Permissions surface in two places: on the field's own
"Field visibility and permissions" setting (choose **Custom permissions**) and on
the standard **People → Permissions** page.

The widget‑hiding enforcement is applied on the **node** edit form. (Note also that this release, 2.1.x, is
an alpha and the project is not covered by Drupal's security advisory policy.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Field
   Permissions dependency with Composer, and enable them.
2. [Configuration](configuration/index.md) — turn on custom permissions for an
   image field and assign the per‑role file/alt/title permissions.

## Where it lives in the admin menu

This module has no settings page of its own. You configure it in two familiar
places:

- **Structure → *(your entity)* → Manage fields → *(image field)*** — set the
  field to use **Custom permissions**.
- **People → Permissions** (`/admin/people/permissions`) — assign the per‑role
  image file, alt and title permissions.

You can also review which roles can touch image files versus metadata at
**Reports → Field list**.
