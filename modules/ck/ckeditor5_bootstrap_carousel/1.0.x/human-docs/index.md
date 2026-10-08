# CKEditor 5 Bootstrap Carousel — manual setup guide

**CKEditor 5 Bootstrap Carousel** (`ckeditor5_bootstrap_carousel`) lets editors
build a responsive, mobile-friendly Bootstrap 5 carousel (a rotating slider)
directly inside CKEditor 5. Rather than wiring up complex Paragraph structures or
separate entity-reference fields, editors get a true "What You See Is What You Get"
experience: insert a carousel, add and edit slides, and see it take shape in the
editor.

This is handy for hero sliders, image galleries, and promotional rotators placed
inline in body content. The module adds a toolbar button that inserts the carousel
and provides the in-editor controls to manage its slides.

The module is at an early (alpha) stage, targets Drupal 10.6+ and 11.3+, and
depends only on core's CKEditor 5. As with any Bootstrap-based output, your
front-end theme needs to load **Bootstrap 5** CSS and JavaScript for the carousel
to display and rotate correctly on the published page. The module also defines a
permission controlling who may use the carousel plugin (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

There is **no central configuration page**. You enable the carousel button per
text format, described below.

## How to use it

This is a CKEditor 5 plugin module: you enable its button per text format.

1. Grant the carousel permission to the roles that should be able to use it at
   **Administration → People → Permissions** (`/admin/people/permissions`).
2. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
3. Edit the text format whose editor is CKEditor 5.
4. In the CKEditor 5 toolbar configuration, drag the **Bootstrap Carousel** button
   into your active toolbar.
5. Make sure the format's allowed HTML tags permit the carousel markup (Bootstrap
   `div` classes, `data-` attributes, images) so it survives saving.
6. Save the text format.

Editors can then click the button to insert a carousel and add or edit slides
inline. Confirm your theme loads Bootstrap 5 so the slider works on the front end.
