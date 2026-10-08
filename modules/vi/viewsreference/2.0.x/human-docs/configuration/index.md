# Configuration

Views Reference has no global settings screen — you configure it entirely on the
**field** you add to an entity. That happens in four familiar places: adding the
field, setting how it behaves, choosing its editing widget, and choosing how it
renders. This page walks through each.

## 1. Add the Views reference field

Go to the entity you want to embed Views into — most often a content type at
**Structure → Content types → … → Manage fields** — and click **Add field**.
Choose the **Views reference** field type, give it a label (for example "Embedded
view"), and set how many values it may hold. A single‑value field embeds one View;
a multi‑value field lets one node embed several different Views on the same page.

## 2. Field settings — what editors may choose

On the field's settings you control which Views and displays are on offer:

- **Allowed display plugin types** (`plugin_types`) — restrict which kinds of View
  display an editor may pick, such as **block** or **page**. By default only
  **block** displays are selectable. Widen this if you want editors to embed page
  displays too.
- **Preselect views** (`preselect_views`) — optionally provide a curated
  allow‑list of Views, so editors choose only from Views you've approved rather
  than every View on the site.
- **Enabled settings** (`enabled_settings`) — choose which per‑embed controls
  appear on the widget (see the list below). Turn on only the ones this field
  needs.

## 3. Per‑embed controls (ViewsReferenceSetting plugins)

The **Enabled settings** option decides which extra controls an editor sees each
time they pick a View. The module ships these built‑in controls:

- **Argument** — contextual filter values passed to the View, separated by `/`.
  These are token‑aware, so you can feed in something like the current node's ID
  and have one View serve many pages.
- **Title** — override the View's title for this placement.
- **Header** — inject custom header markup above the embedded View.
- **Pager** — override the View's pager behavior.
- **Limit** — override the number of items shown.
- **Offset** — override where in the result set the View starts.

Enable just the controls that make sense for the field — for a simple "pick a
listing" field you might expose none of them; for a flexible landing‑page section
you might enable argument, title, and pager. (Developers can add their own controls
as ViewsReferenceSetting plugins; see the sibling [`agent/`](../agent/start.md)
docs.)

## 4. Choose the editing widget

On the entity's **Manage form display** tab, the field uses the
**Views reference (autocomplete)** widget — an autocomplete where the editor types
to find a View, then picks a display. Any per‑embed controls you enabled in step 3
appear here alongside the autocomplete.

## 5. Choose how it renders

On the **Manage display** tab, pick the formatter:

- **Views reference formatter** — renders the selected View display inline where
  the field appears.
- **Views reference (lazy) formatter** — renders the View through a lazy‑builder
  placeholder, which keeps the host entity's cache tags cleaner and shows a loading
  placeholder while the View resolves. Prefer this on pages where cacheability
  matters.

## Save

Save each screen as you go. Once the field is in place, editors configure each
embed simply by editing content — choosing a View, a display, and any per‑embed
settings you exposed. Because the field builds on entity reference, its values are
revisionable, translatable, and exportable like any other field.
