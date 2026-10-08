# Views Jump Menu — manual setup guide

**Views Jump Menu** (`views_jump_menu`) adds a new display **format** to Views that
renders a view's results as a single `<select>` dropdown. When the visitor picks an
option, the browser navigates straight to that row's URL. It is a compact,
space‑saving "jump to" navigator — a tidy alternative to a long list of links or a
big table — that works well for archive selectors, A–Z pickers, category choosers,
"go to page" controls in a sidebar, and mobile‑friendly navigation that collapses
many links into one control.

The module provides one Views style plugin, **Jump Menu**, selectable as the
**Format** on any view that shows **Fields**. In the format's settings you pick a
**Label field** (the text shown for each option) and a **URL field** (where that
option leads), plus optional touches: a placeholder prompt, an ARIA label for
screen readers, wrapper and select CSS classes, and an "open link in new window"
toggle. A small JavaScript behaviour reads the chosen option's URL and navigates —
or opens a new tab — accordingly. Each menu gets a unique ID, so several jump menus
can live on the same page independently.

Everything is configured inside the view itself — there is **no admin settings
page, no permission, and no Drush command** — and the configuration exports with
your Views config like any other. You can also override the dropdown markup by
providing a `views-jump-menu.html.twig` template in your theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module adds no menu items or settings page. Its **Jump Menu** format appears in
the Views UI when you edit a view's **Format**, at
`/admin/structure/views/view/<view-id>`.

## How to use it

1. Edit or create a view at **Structure → Views**
   (`/admin/structure/views`).
2. Set **Show** to **Fields** (the Jump Menu format requires fields), and add at
   least two fields: one to use as each option's **label** (for example the title)
   and one to provide each option's **URL** (for example a rendered entity link or
   the content's path).
3. Set **Format** to **Jump Menu**.
4. Open the Jump Menu **format settings** and configure:
   - **Label field** — the field whose text becomes each option label. The menu
     shows no options until this is set. (Fields that render HTML are converted to
     plain text for the label.)
   - **URL field** — the field that supplies each option's destination.
   - **Select text** — the placeholder shown as the first, pre‑selected option
     (default "-- Select --").
   - **Select label (ARIA)** — an accessible label announced to screen readers.
   - **Open link in new window** — open the chosen destination in a new tab instead
     of the same window.
   - **Class / Wrapper class** — extra CSS classes on the `<select>` element and its
     wrapping container, for theming and layout.
5. Save the view. The results now render as a dropdown that jumps to the selected
   row's URL.

Pair it with exposed filters to let visitors narrow the list first and then jump to
a result, and remember you can place several independent jump menus on one page.
