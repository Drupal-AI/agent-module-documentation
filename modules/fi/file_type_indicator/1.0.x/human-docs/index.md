# File type indicator — manual setup guide

**File type indicator** (`file_type_indicator`) is a **text-format filter** that
adds a small file-type icon next to file links in your content. When the filter
runs, it scans the links in rendered text, looks at the file extension in each
link's address, and — for the extensions you've chosen — adds a CSS class that
displays the matching icon (PDF, DOC, ZIP, and so on). Editors get helpful "this
link downloads a PDF" cues without having to touch any markup.

It works cleanly and safely: the filter only adds a CSS *class* to matching links
(it never injects user-controlled markup), it preserves any classes the links
already have, and it ships an icon CSS library that it attaches automatically so
the icons actually render. Links without a recognizable extension are left alone.

The filter depends on core's **Filter** module and is configured **inside a text
format** — there's no separate settings page. You enable it on the text formats you
want and tell it which extensions to decorate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** for this module. The one setting (the
list of extensions) lives inside each text format's filter settings, described in
"How to use it" below.

## Where it lives in the admin menu

File type indicator adds no settings page of its own. You configure it from **Con­
figuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), inside the text format you want to enhance.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** on the text format you want (for example *Full HTML* or
   *Basic HTML*).
3. Under **Enabled filters**, tick **"Add icon to file link, depends on its
   extension."**
4. Scroll to the filter's settings and set the **comma-separated list of file
   types** to decorate. The default is `pdf,doc,zip`; add or remove extensions to
   match the file types your site links to.
5. Click **Save configuration**.

From then on, links to matching file types in content using that format will show
the appropriate file-type icon. The needed icon CSS is attached automatically. If
you want different icons, you can override them in your theme's CSS.
