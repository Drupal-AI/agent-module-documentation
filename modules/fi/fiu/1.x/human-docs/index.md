# Field Image Upload — manual setup guide

**Field Image Upload** (`fiu`) adds a friendlier widget for Drupal's core image
fields. It's the same image field you already know, but with a nicer editing
experience: a clearer upload control that shows only the settings that matter, a
pop‑up image preview, drag‑and‑drop uploading, and details about each uploaded
image. Editors get a more pleasant way to add images; the field itself is
unchanged underneath.

It's important to understand what this module does and does *not* change. Field
Image Upload only swaps the **widget** — the form control editors use to upload.
The real upload rules — which file extensions are allowed, the maximum file size,
and whether files go to public or private storage — remain the **image field's**
own settings, and Drupal enforces those regardless of which widget you pick. So
if the images matter for security or privacy, confirm those field settings; the
widget improves the experience, it doesn't loosen what the field accepts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) add the Magnific Popup library.

Field Image Upload has **no central settings page** — you turn it on per field,
in *Manage form display*, so there is no configuration chapter in this guide.

## Where it lives in the admin menu

Field Image Upload adds no page of its own to the admin menu. You choose it as a
widget on an image field from **Structure → Content types → *(your type)* →
Manage form display**.

## How to use it

1. Go to the content type (or any fieldable entity) that has an image field, and
   open its **Manage form display** tab.
2. Find your image field and change its **Widget** to the Field Image Upload
   ("Fine image upload") widget.
3. Save the display. Editors adding content will now see the enhanced uploader
   with preview and drag‑and‑drop.

Before you rely on it, open the image field's own settings and confirm the
**allowed file extensions**, **maximum upload size**, and **public vs. private
file storage** are appropriate for your site — those field‑level controls are
what actually govern what can be uploaded.
