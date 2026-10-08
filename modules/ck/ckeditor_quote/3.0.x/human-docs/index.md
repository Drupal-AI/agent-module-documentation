# CKEditor Quote — manual setup guide

**CKEditor Quote** (`ckeditor_quote`) adds a single **Quote** button to the
CKEditor 5 toolbar. Where core's plain blockquote button just wraps text, this one
inserts a proper pull-quote widget with both the quotation text *and* an attributed
author line — ideal for testimonials, press quotes, and case-study callouts.

When an editor clicks the button, the module inserts a `<blockquote>` containing a
`<div class="quote">` for the words and a `<div class="author">` for the
attribution, which your theme can style however you like. It is backward
compatible with existing content: when a page loads, the plugin recognises any
plain `<blockquote>` and turns it into the editable widget, treating a child
`<div class="author">` or `<cite>` as the author — so old quotes without an author
keep working. The plugin also declares the HTML elements it needs (`<p>`, `<div>`,
`<div class="author">`, `<blockquote>`), so CKEditor 5 automatically allows them
even on restricted "Limit allowed HTML tags" formats.

There is nothing site-wide to configure: no settings form, no permissions, no
Drush commands. You simply add the Quote button to whichever text formats should
offer it. It works on any field that uses a CKEditor 5 text format — body fields,
Layout Builder text blocks, comments, Webform rich text, and so on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Turning the button on for a text format is covered in the *How to use it* section
below.

## Where it lives in the admin menu

CKEditor Quote has no page of its own. You enable its button per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to *Configuration → Content authoring → Text formats and editors* and edit a
   format whose editor is **CKEditor 5** (for example *Basic HTML* or *Full HTML*).
2. In the toolbar configuration, drag the **Quote** button (its tooltip reads
   "Quote Dialog") from *Available buttons* up into the *Active toolbar*.
3. Click **Save configuration**. If the format limits allowed HTML tags, CKEditor 5
   automatically adds the tags the plugin needs — you do not have to edit the tag
   list by hand.

Now, editing content with that format, click the Quote button and type the
quotation and the author. Saved output looks like:

```html
<blockquote>
  <div class="quote"><p>Only when we are brave enough…</p></div>
  <div class="author">Brene Brown</div>
</blockquote>
```

Style the `.quote` and `.author` classes in your theme to match your design.
