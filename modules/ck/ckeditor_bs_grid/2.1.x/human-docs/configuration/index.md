# Configuration

There are two layers of configuration:

- **Per text format** — which formats have the grid button, and which columns and
  breakpoints editors may use there. That's set on each format's editing screen
  and is covered in [How to use it](../index.md#how-to-use-it) on the overview
  page.
- **Site‑wide** — the catalogue of named layouts editors can choose from. That's
  this page.

## Open the site‑wide settings

1. Log in as a user with the **Administer ckeditor_bs_grid** permission.
2. Go to **Configuration → Content authoring → CKEditor BS Grid**, or navigate
   directly to `/admin/config/content/ckeditor_bs_grid`.

## What this page defines

This page is the master list of **breakpoints** and, within each, the **layouts**
offered for every column count. Think of it as answering "when an editor picks a
2‑column row and the *Medium* screen size, which preset splits should they be able
to choose?" — for example *Equal Width*, *25% / 75%*, or *Full Width*.

The form shows one collapsible section per breakpoint. Bootstrap's six breakpoints
are all present out of the box:

| Breakpoint | Default label |
|------------|---------------|
| `xs` | Default (Extra Small) |
| `sm` | Small |
| `md` | Medium |
| `lg` | Large |
| `xl` | Extra Large |
| `xxl` | Extra Extra Large |

For each breakpoint you can:

- **Rename the label** editors see — for example change "Extra Small" to "Phone"
  or "Medium" to "Tablet" so the dialog speaks your team's language. (The
  Bootstrap *prefix* — the `md` in `col-md-6` — is fixed and shown read‑only, since
  those are Bootstrap's own class infixes.)
- **Edit the layouts** offered for each column count (1 through 12). Each column
  count has a draggable table of named layout options. A layout has a **label**
  (what the editor sees) and a set of column widths — each column gets a Bootstrap
  width from 1 to 12, or the special values *equal* (a plain `col`) or *auto*
  (`col-auto`). So a "25% / 75%" layout for two columns stores widths 3 and 9.
- **Add or remove layouts** — add a new preset (say a "20% / 80%" split) or drop
  ones you never use, and drag to reorder them.
- **Set a default layout** per column count, so a sensible option is pre‑selected
  in the dialog.

## How this relates to the per‑format settings

Keep the two layers straight:

- **This page defines *what layouts exist*** across the whole site.
- **The per‑format settings define *which of them an editor may pick*** in a given
  text format — the "Allowed Columns" and "Allowed Breakpoints" checkboxes on the
  text‑format screen are built from the breakpoints and labels you define here.

So if you rename a breakpoint here, that new label is what appears in the
per‑format checkboxes and in the insertion dialog. And if you remove a breakpoint's
layouts here, editors have nothing to choose for that breakpoint even if it's
allowed on the format.

## Save

Click **Save configuration**. Changes apply to the insertion dialog immediately
(you may need to clear caches for CKEditor to pick up new layout options).
