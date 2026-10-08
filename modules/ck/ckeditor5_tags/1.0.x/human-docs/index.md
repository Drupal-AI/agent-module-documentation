# CKEditor Tags (Dynamic Tags) — manual setup guide

**CKEditor Tags** (project `ckeditor5_tags`, but the **Drupal machine name is
`ckeditor_tags`**) adds a "Dynamic Tags" widget to CKEditor 5. It lets editors
insert inline placeholder tokens into rich text — each token is a named tag with
a visible label — that the site's own front-end JavaScript can look up and replace
with a live value at runtime. Think of injecting `Hello <name>` or a live price
or count into otherwise static content, decoupling the data from where it is
displayed.

Each tag is a small widget: a lookup key (rendered as a `code.tag-id`) plus a
visible placeholder label (a `span.tag-label`), wrapped in a
`span.dynamic-tag`. The tag id is automatically restricted to letters, digits,
dashes, and underscores so it stays safe to use as a JavaScript/URL key. The
module bundles a small JavaScript library, complete with loading spinners, to
make substitution easy.

It is important to understand that **replacement is entirely client-side and
developer-driven**. There is no server-side token resolution: the module exposes
a `window.dynamicTags` runtime API, and it is your site's own trusted JavaScript
that calls `replace(value)` on each tag to fill in the real content after the page
loads. That makes this a lightweight tool for dynamic content without a full
token/render pipeline — but it does require a developer to write the code that
supplies the values. It depends only on core's CKEditor 5, and has no settings
form, permissions, or routes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (mind the machine name).

There is **no configuration page** for this module. You add its toolbar button
per text format, described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** on the CKEditor 5 format you want the widget in.
3. In the CKEditor 5 toolbar configuration, drag the **Dynamic Tags** button into
   the *Active toolbar*.
4. Make sure the format's allowed HTML permits the tag markup — `<span
   class="dynamic-tag">`, `<code class="tag-id">`, and `<span class="tag-label">`
   — so the widgets survive filtering on save.
5. **Save configuration**.

Editors can then insert a Dynamic Tag, give it an id and a placeholder label, and
save. On the rendered page, your site's JavaScript uses
`window.dynamicTags.tags[<id>]` to call `replace(value)` (with `wait()` and
`stop()` helpers for a spinner) to swap in the live value.
