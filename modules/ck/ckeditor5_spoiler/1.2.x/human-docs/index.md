# CKEditor5 Spoiler — manual setup guide

**CKEditor5 Spoiler** (`ckeditor5_spoiler`) adds a spoiler plugin to CKEditor 5,
letting editors mark a section of content as a hide/reveal spoiler — text that is
hidden until a reader clicks to reveal it. It is handy for hiding plot details,
quiz answers, or optional content inside a rich-text field. The plugin is
compatible with the old CKEditor 4 spoiler plugin, so content authored there
carries over.

It depends only on core's CKEditor 5. Once enabled, you add its **Spoiler**
button to a text format's toolbar and turn on the accompanying "Spoiler support"
filter so the spoiler markup survives text-format filtering.

One important thing to understand: a spoiler is a **display toggle, not access
control**. The hidden content is still present in the page's HTML source — anyone
who views source or reads the raw markup can see it. Never use a spoiler to hide
anything that genuinely needs to be protected.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You set it up per text format
by adding its toolbar button and enabling its filter, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** on the format you want spoilers in.
3. In the CKEditor 5 toolbar configuration, drag the **Spoiler** button into the
   *Active toolbar*.
4. Scroll down to the **Enabled filters** list and tick **Spoiler support** so
   the spoiler markup is preserved when content is saved and displayed.
5. **Save configuration**.

Now, when editing content with that format, select some text (or place the
cursor) and use the Spoiler button to wrap it as a spoiler. On the rendered page,
that content stays hidden until the reader clicks to reveal it.
