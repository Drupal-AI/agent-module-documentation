# CKEditor Read More — manual setup guide

**CKEditor Read More** (`ckeditor_readmore`) adds a toolbar button to CKEditor 5
that wraps a selected chunk of content in a collapsible "Read more" region. On the
rendered page, that region is hidden behind a link (or button) the visitor clicks
to expand it — and a "Show less" toggle to collapse it again. It's the easy way to
add spoilers, expandable fine print, or teaser-style hidden sections inside
rich-text content, without touching code.

Setting it up on a text format takes **two** steps that must both be done:
add the **Read more** button to the editor toolbar, *and* enable the companion
**Filter readmore** text filter on the same format. The button is what lets editors
create the region; the filter is what makes the toggle labels and the
click-to-expand behavior work on the front end. Miss either one and the feature
won't fully function.

You control how the toggle looks (plain text link or a button, plus optional CSS
classes) and what the "Read more" / "Show less" labels say — all per text format.
There is no central settings page and no permissions of its own. The module is
CKEditor 5 only; it ships an upgrade path that maps an old CKEditor 4 read-more
button and its settings across, but no longer supports CKEditor 4 itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. You configure everything per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — edit a format (for example *Full HTML*) to add
the toolbar button and enable the filter.

## How to use it

### 1. Add the Read more toolbar button

On the text format's edit page, drag the **Read more** button from the *Available
buttons* into the **Active toolbar**. A vertical-tab settings section titled *Read
more* then appears, with:

- **Type** — render the toggle as plain **text** (default) or as a **button**.
- **Classes** — optional, space-separated extra CSS classes added to the toggle
  element so you can style it to match your theme.

### 2. Enable the "Filter readmore" filter

On the same format, scroll to **Enabled filters** and tick **Filter readmore**.
Without it, the toggle labels and the click-to-expand behavior are not attached on
the rendered page. Its two settings (under the filter settings area) are:

- **Read more text** — the expand label (default *Read more*). Translatable.
- **Show less text** — the collapse label (default *Show less*). Translatable.

### 3. If "Limit allowed HTML tags" is on

The module normally registers the markup it needs automatically. But if your
format uses **Limit allowed HTML tags and correct faulty HTML** and the region
markup is being stripped, add this to the allowed tags:

```
<div class="ckeditor-readmore ckeditor-readmore-wrapper" data-readmore-type data-readmore-more-text data-readmore-less-text data-readmore-classes>
```

### Using it as an editor

In a field that uses the configured format, select the content you want to hide,
click **Read more** in the toolbar, and it gets wrapped in a read-more region. On
the published page that content is collapsed behind your "Read more" toggle. You
can have several independent read-more regions in one field.

### Notes

- The front-end toggle behavior needs only jQuery (bundled via Drupal's `once`) —
  no extra framework.
- The more/less labels are set per format and are translatable.
- Upgrading from CKEditor 4? The module maps the legacy `btn_readmore` button and
  its `readmore` settings onto the CKEditor 5 plugin, smoothing the migration —
  but v3 does not support CKEditor 4 as an editor.
