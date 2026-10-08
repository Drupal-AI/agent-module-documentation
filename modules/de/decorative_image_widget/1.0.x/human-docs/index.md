# Decorative Image Widget — manual setup guide

**Decorative Image Widget** (`decorative_image_widget`) improves the
accessibility of image uploads by making editors do one of two things for every
image: either write alternative text, **or** explicitly mark the image as
*decorative*. It's a small tweak to Drupal's built-in image field widget with a
big payoff for screen-reader users.

Alternative text ("alt text") is what a screen reader announces in place of an
image. Meaningful images should always have it. But some images are purely
decorative — a divider, a background flourish — and for those the correct
accessibility choice is an *empty* alt attribute (`alt=""`) so assistive
technology skips them. This module gives editors a clear **Decorative** checkbox
next to the alt field and won't let them save an image with neither alt text nor
the decorative flag set.

It stores nothing new about your images: a decorative image is simply saved with
empty alt text, exactly as WCAG recommends. The behavior is opt-in per image
field, and it only shows up when the field has alt text *enabled but not
required* — if you've already made alt text mandatory, core enforces that and
this module stays out of the way.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. You switch the feature on per image field, on
the bundle's **Manage form display** page — for example, for the Article content
type: **Structure → Content types → Article → Manage form display**
(`/admin/structure/types/manage/article/form-display`).

## How to use it

**Step 1 — Check the field's alt settings.** On the image field's settings, make
sure **Alt field** is enabled and **Alt field required** is turned *off*. If alt
text is required, core already forces editors to fill it in and this module's
option won't appear.

**Step 2 — Turn on the checkbox for the field.**

1. Go to the bundle's **Manage form display** page.
2. Click the gear/cog icon on the image field's row.
3. Tick **Force image to be marked decorative if no alt text provided**.
4. Click **Update**, then **Save**. The widget summary will now read "Decorative
   checkbox".

**What editors see.** When adding or editing content, the image widget shows a
**Decorative** checkbox beside the alt-text field, labelled "This image is
decorative and should be hidden from screen readers." If an editor uploads an
image but leaves alt text blank and doesn't tick Decorative, saving fails with:
"You must provide alternative text or indicate the image is decorative." A ticked
Decorative box simply saves the image with empty alt text.

**To turn it off** for a field, untick that same checkbox on the Manage form
display page and save.
