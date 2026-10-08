# Configuration

Paragraphs Browser has no single global settings form. Instead you configure it
in a few connected places: you build **Browser Types** and their **Groups**,
assign paragraph types to groups, give each paragraph type a preview image and
description, and finally switch the browser widget on for a Paragraphs field.
Everything is gated by the core Paragraphs **"Administer paragraph types"**
permission.

> Note: an internal annotation mentions a permission called "administer
> paragraphs browser", but the module never actually defines it. In practice all
> the admin screens below require **"Administer paragraph types"**.

## Step 1 — Add a Browser Type

1. Go to **Structure → Paragraph Types → Manage Browsers**
   (`/admin/structure/paragraphs_type/browsers`).
2. Click **Add** (the "Add paragraphs browser type" action) and give the browser a
   label and machine name. Browser Types are the broad buckets — for example
   "Layouts" or "Media".

A default "Content" browser ships with the module; you can use or delete it.

## Step 2 — Add Groups to the browser

Within a browser, **Groups** are the finer filters editors use inside the modal —
for example "Single Column" and "Multi Column" inside a Layouts browser.

1. On the browser's edit screen, open its **Groups** management (the "Manage
   Groups" area, with an "Add group" action).
2. Add each group with a label; you can reorder them, and the order controls how
   they appear in the browser.

## Step 3 — Assign paragraph types to groups

1. Go to **Structure → Paragraph Types** and pick a paragraph type.
2. Open its **Configure Groups** tab.
3. Choose which browser's group this paragraph type belongs to. A paragraph type
   can be mapped into groups across several browsers, so the same component can
   appear in more than one browser.

## Step 4 — Give each paragraph type a preview card

Editors recognise components faster with a picture and a caption. On each
paragraph type's **edit form** you'll find a **Paragraphs Browser Settings**
fieldset:

- **Image** — the preview image shown on the card. You can **upload** an image
  (PNG, GIF, JPG/JPEG, APNG, or SVG), which is copied into the site's public
  files, or reference an existing image by its path (relative to the Drupal root
  or a `public://` path). If you leave it empty, the browser falls back to the
  default Paragraphs icon.
- **Description** — a short line of text explaining when to use this paragraph
  type.

## Step 5 — Switch the widget on for a field

1. Go to the content type that has your Paragraphs field, and open **Manage form
   display**.
2. For the Paragraphs (entity reference revisions) field, change its **widget** to
   one of:
   - **Paragraphs Browser EXPERIMENTAL** — built on the newer Paragraphs widget.
   - **Paragraphs Browser Classic** — built on the legacy inline Paragraphs
     widget.
   Choose whichever matches how you use Paragraphs elsewhere.
3. Click the widget's **gear icon** to open its settings and pick **which Browser
   Type** this field should use.
4. Save the form display.

Now, when an editor adds a paragraph to that field, they get the modal browser —
grouped, filterable, and showing your preview cards — instead of the default
dropdown. Because the browser is chosen per field, you can give different fields
different browsers built from the same paragraph types.

## Theming (optional)

Two Twig templates let you restyle the browser to match your design:
`paragraphs-browser-wrapper.html.twig` (the overall browser) and
`paragraphs-browser-paragraph-type.html.twig` (each per‑type card). Override them
in your theme — see the [`agent/`](../agent/start.md) docs for the theme‑hook
names.
