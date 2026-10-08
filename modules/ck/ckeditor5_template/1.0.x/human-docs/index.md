# CKEditor 5 Template — manual setup guide

**CKEditor 5 Template** (`ckeditor5_template`) adds a **Template** button to the
CKEditor 5 toolbar that lets content authors insert ready‑made blocks of HTML —
tables, callouts, call‑to‑action promos, two‑column layouts, FAQ blocks, legal
notices — chosen from a picker. Instead of hand‑writing the same markup over and
over, an editor clicks the button, picks a template from a list (each with an icon
and a short description), and the block drops in at the cursor.

The set of templates a format offers comes from a **JSON file** you point the
plugin at. Each template in that file has a title, an icon, a description, and the
HTML that gets inserted. The module ships an example file with a couple of
templates to get you started, and you can supply your own file (kept in your
codebase or a custom module) to give editors a branded, versioned library of
snippets. Because it's per format, you can give *Full HTML* one library and *Basic
HTML* another — or none.

This is the CKEditor 5 successor to the old CKEditor 4 `ckeditor_template` module,
and it depends only on Drupal core's text‑editor / CKEditor 5. There is **no
site‑wide settings page** — everything is configured on each text format, so this
guide has no separate configuration page; the "How to use it" section below covers
the whole setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

CKEditor 5 Template adds **no admin page of its own**. You configure it while
editing a text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).

## How to use it

### 1. Add the Template button to a format

1. Go to **Text formats and editors** (`/admin/config/content/formats`) and edit a
   format whose editor is **CKEditor 5** (for example *Full HTML*).
2. In **Toolbar configuration**, drag the **Template** button from *Available
   buttons* into the *Active toolbar*.
3. A **Template** settings tab appears below the toolbar. Set:
   - **Template file location** *(required)* — the path (from the Drupal root, with
     a leading `/`) to your JSON templates file. To try the bundled example, use
     `/modules/contrib/ckeditor5_template/template/ckeditor5_template.json.example`.
     The file must exist or the form won't save.
   - **Show title in toolbar?** — whether to show a text label next to the button
     icon.
   - **Toolbar label** — the label text to show (only when the checkbox above is
     on). Leave it blank to default to "Template"; set it to rename the button to,
     say, "Snippets" or "Insert block".
4. **Save**.

Editors using that format now see the Template button; clicking it opens the
picker.

### 2. Provide your own templates

The templates come from a JSON **array**, each entry being one selectable
template:

```json
[
  {
    "title": "Simple Table",
    "icon": "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\"><path d=\"M8 16h8v2H8z\"/></svg>",
    "description": "Insert a simple Table.",
    "html": "<table border='1'><tr><th>Header 1</th><th>Header 2</th></tr></table>"
  }
]
```

- **title** — the name shown in the picker.
- **icon** — inline SVG shown next to the entry.
- **description** — short help text under the title.
- **html** — the markup inserted when the template is chosen.

Copy the bundled example to a path in your codebase or a custom module, edit the
array, and point the format's **Template file location** at your file. No code
changes are needed.

> **Important:** the inserted HTML must be permitted by the text format's *allowed
> HTML tags*. If a format strips `<table>` or `<div class>`, those templates won't
> survive — loosen the format's filters (or use a Full‑HTML‑style format)
> accordingly.
