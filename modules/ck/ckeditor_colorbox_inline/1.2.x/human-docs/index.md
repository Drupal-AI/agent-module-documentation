# Colorbox Inline Text Filter — manual setup guide

**Colorbox Inline Text Filter** (`ckeditor_colorbox_inline`) adds a **text‑format
filter** that makes inline images in your rich‑text content open in a
[Colorbox](https://www.drupal.org/project/colorbox) lightbox. When the filter runs,
it finds every `<img>` in the text and wraps it in a link pointing at the image's
own source, tagged so that all the images in a field become **one Colorbox
gallery** the visitor can page through. Editors don't have to add any link markup
themselves — the effect is applied automatically at display time.

Despite the "ckeditor" in its name, this is **not** a CKEditor plugin. It's a
display‑time output filter, which means it affects every `<img>` in the content
regardless of how it got there — typed in CKEditor, pasted as HTML, or brought in
by a migration. That also makes it a quick way to add lightbox behavior to legacy
content: just enable the filter on the text format that content uses.

The module depends on the **Colorbox** module (`drupal/colorbox ^2.1`), whose own
assets and settings provide the actual lightbox styling and behavior. It has no
settings page of its own, no permissions, and no Drush commands — its one option
lives in the per‑format filter settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Colorbox.

## Where it lives in the admin menu

There is no dedicated admin page. You turn the effect on per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

**Enable the filter on a text format.** Edit a format such as *Full HTML* at
**Configuration → Content authoring → Text formats and editors**, tick **Colorbox
Inline Text Filter** under *Enabled filters*, and save. Content using that format
now opens its images in Colorbox. Enable it only on the formats where you want the
behavior (for example Full HTML but not a plain‑text format).

**Set the link classes (optional).** In the filter's own *Filter settings* there's
a single option — **CSS classes** (`css_classes`), a space‑delimited list of
classes applied to the generated `<a>` tags. It defaults to `colorbox`. Supply
several classes if you want to style the lightbox trigger differently.

**Exclude an image.** To keep a particular image *out* of the lightbox/gallery,
add the class `noColorbox` to that `<img>`. The filter skips any image whose class
contains `noColorbox`.

Behind the scenes, for each eligible image the filter turns:

```html
<img src="/sites/default/files/photo.jpg" alt="Photo">
```

into:

```html
<a href="/sites/default/files/photo.jpg" class="colorbox" data-colorbox-gallery="ckeditor-colorbox-inline">
  <img src="/sites/default/files/photo.jpg" alt="Photo">
</a>
```

The link's `href` is the image's own `src`, and the shared
`data-colorbox-gallery` value is what groups the field's images into a single
gallery. Colorbox's assets are attached site‑wide, so the lightbox styling and
options come from the Colorbox module's configuration — pair it with Colorbox's
slideshow option, for instance, for an automatic image slideshow.
