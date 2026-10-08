# Flipbook — manual setup guide

**Flipbook** (`flipbook`) turns an uploaded PDF into an interactive, page-flipping
"book/magazine" viewer. Visitors page through the document with a realistic page-turn
animation instead of downloading a flat file. It is ideal for brochures, catalogs,
lookbooks, newsletters, annual reports, restaurant menus, and training material — anything
that reads better as a browsable booklet.

The rendering is done entirely client-side by a bundled 3D flipbook JavaScript stack
(pdf.js, three.js, and friends). Everything the viewer needs ships **inside the module** —
there is no external CDN or extra Composer library to pull in. You can show the book inline
in the page, or in a popup frame over the current page; a single site-wide setting toggles
between the two.

Flipbook defines its own **content entity** type called *Flipbook*. Each one has a name, a
required **cover image**, and a required **PDF file**. You manage them from a dedicated admin
listing, create them with an *Add flipbook* form, and each gets its own URL at
`/flipbook/{id}`. The entity is fieldable (so you can add metadata like a description or
category) and Views-enabled (so you can build a themed grid or list of flipbooks). Five
permissions govern who can view, add, edit, delete, and administer them, and when a flipbook
is deleted its cover and PDF files are cleaned up automatically. It depends on core's
**Options**, **File**, and **Image** modules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — including the entity's base fields, theming,
and Views integration — read the sibling [`agent/`](../agent/start.md) docs instead.

> **Note:** flipbook PDFs are loaded in the browser from a public file URL, so treat them as
> publicly reachable assets unless you place the files behind private-file access.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

### 1. Grant the permissions

On **People → Permissions**, assign the Flipbook permissions to the appropriate roles:

| Permission | Lets a role… |
|---|---|
| **View flipbook entity** | see a flipbook at its `/flipbook/{id}` page |
| **Edit flipbook entity** | edit existing flipbooks |
| **Delete flipbook entity** | delete flipbooks |
| **Administer flipbook entity** *(restricted)* | full access — manage the listing, settings, and create flipbooks |

> **Good to know:** because of a leftover naming quirk from the example the module was built
> from, the "create" check looks for a permission that isn't grantable in the UI. In practice
> that means **creating** flipbooks currently works for users who hold **Administer flipbook
> entity** (which bypasses the create check). If you need a non-admin role to create
> flipbooks, grant it the administer permission. This fails safe — it grants less access, not
> more.

### 2. Create a flipbook

Go to **Structure → Flipbook Listing** (`/admin/structure/flipbook/list`) and click **Add
flipbook**. Enter a name, upload a **cover image** (PNG/JPG — shown before the book opens),
and upload the **PDF** (the maximum size follows your server's upload limit). Save. Visit
`/flipbook/{id}` to see the page-flip viewer.

### 3. Choose popup or inline display

There is one site-wide setting that controls how every flipbook is presented. Go to
**Configuration → (Choose PDF style)** at `/admin/config/choosepdfstyle` and pick:

- **Popup** — the book opens in a popup/colorbox-style frame over the current page.
- **Inline** *(default)* — the book renders directly within the page.

This is a global switch — there is no per-flipbook display toggle. You can also set it with
Drush:

```bash
ddev drush config:set config.flipbook_chooseconfig pdf.choice 1 -y   # 1 = popup, 0 = inline
```

### 4. (Optional) List flipbooks in a View

Because the entity provides Views data, you can build a View of flipbooks. To render the
actual flip viewer inside the View, add the **"Flipbook PDF"** field, edit it, and under
*Style settings* enable **"Use field template"** so the module's template renders the book
rather than a raw file link. This lets you build a themed grid or shelf of flipbooks.
