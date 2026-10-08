# My CKE Button — manual setup guide

**My CKE Button** (`myckebutton`) lets administrators define their own named
text/button styles through a form and then apply them with a dedicated button in
the CKEditor toolbar. Instead of teaching editors raw HTML and CSS, or hand‑editing
CKEditor configuration, you create brand‑approved styles once and expose them as a
one‑click toolbar button so authors can format content consistently.

Each style you define carries six colors — text, background, and border, plus a
hover variant of each — along with three adjustable properties: border radius,
border width, and padding. Editors pick a saved style from the button's dialog,
and if they need a one‑off look they can also declare a style right there in the
style‑selection dialog without saving it permanently. The styles are stored as
exportable Drupal configuration (`ckeditor.plugin.myckebutton`).

Two things are important to know before you install. First, this module depends
on the legacy **CKEditor** (CKEditor 4) module — it does **not** work with
CKEditor 5, so it only suits sites still running the older editor. Second, the
module is minimally maintained and is **not** covered by Drupal's security
advisory policy, so weigh that before using it on a production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm your text format uses CKEditor 4.

There is no separate settings page under *Configuration*; you manage the styles
from the module's own styles form, described in "How to use it" below.

## Where it lives in the admin menu

The styles form lives at **`/admin/config/content/myckebutton-styles`**. It is
gated by the **`access myckebutton config`** permission, so grant that permission
(under *People → Permissions*) to any non‑administrator role that should be able
to manage styles.

## How to use it

1. Make sure the text format your editors use is powered by **CKEditor 4** (the
   legacy editor this module targets).
2. Go to **`/admin/config/content/myckebutton-styles`** and add one or more named
   styles. For each style, set the text, background, and border colors (and their
   hover versions), plus the border radius, border width, and padding.
3. Add the **My CKE Button** to your text format's CKEditor toolbar: go to
   **Configuration → Content authoring → Text formats and editors**, edit the
   format, and drag the My CKE Button into the active toolbar.
4. When editing content, editors click that toolbar button and choose one of your
   saved styles — or define a one‑time style directly in the dialog. The rendered
   markup still passes through the text format's normal filters.
