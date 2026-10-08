# CKEditor Accordion (Detail Plugin) — manual setup guide

**CKEditor Accordion - Detail Plugin** (`ckeditor_details`) adds an **"Add accordion"**
toolbar button to CKEditor 5. When an editor clicks it, CKEditor inserts a native HTML5
`<details>`/`<summary>` block — the browser then renders it as a click‑to‑expand accordion
with no runtime JavaScript at all. It's the clean, accessible way to let content authors
build collapsible FAQs, "read more" panels, and expandable documentation sections without
writing any HTML or relying on per‑theme accordion scripts.

The module registers a CKEditor 5 plugin that provides a single toolbar item, **Detail**.
Clicking it drops in a `<details>` element containing a `<summary>` (the clickable title)
and a `<div class="details-wrapper">` for the body — into which editors can put text,
lists, images, and other content. Because it's a native HTML disclosure widget, the result
is semantic and works everywhere, including on mobile.

You enable it per **text format**: on *Text formats and editors*, drag the Detail button
into a CKEditor 5 format's toolbar, and make sure that format's allowed‑HTML filter permits
the elements the plugin inserts. There's no module settings page — all configuration lives
on the individual text formats. The module also ships legacy CKEditor 4 support and a
CKEditor 4→5 upgrade plugin, so formats migrated from CKEditor 4 keep their accordion
button automatically. It depends only on core's CKEditor 5.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There's no central settings page. You add the accordion button to each **text format**
that uses CKEditor 5:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit (or add) a format whose text editor is **CKEditor 5** — for example *Full HTML*, or
   a custom "Article body" format.
3. In the toolbar configuration, drag the **Detail** button (the accordion icon) from
   *Available buttons* up into the *Active toolbar*.
4. If the format has **Limit allowed HTML tags** turned on, make sure it permits the
   elements the plugin needs: `<details>`, `<summary>`, and `<div class="details-wrapper">`
   (plus `<div>`). Otherwise the inserted markup will be stripped when the content is
   filtered.
5. **Save** the format.

Editors using that format will now see an **Add accordion** button. Clicking it inserts a
collapsible block:

```html
<details>
  <summary>Summary / title</summary>
  <div class="details-wrapper"> … body content … </div>
</details>
```

### Upgrading from CKEditor 4

If you're migrating a format that used the old CKEditor 4 accordion/detail button, the
module's CKEditor 4→5 upgrade plugin maps it to the new **Detail** toolbar item
automatically — you don't need to add it by hand for upgraded formats.
