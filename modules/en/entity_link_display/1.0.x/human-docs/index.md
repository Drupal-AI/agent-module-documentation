# Entity Link Display — manual setup guide

**Entity Link Display** (`entity_link_display`) gives you a simple, reusable field
formatter that renders a link to the **current entity's own page** (its canonical
URL) — the "view content" or "read more" link you so often want in a teaser, a
report, a dashboard, or a Layout Builder display. It works just like the "Link to
content" field you can add in Views, but for display modes, and without writing any
custom Twig or overriding templates.

It works by attaching a computed **"Display Link"** field to every entity type that
has a canonical URL template (nodes, users, taxonomy terms, and so on). The field is
added automatically and appears on **Manage Display**, but it is **hidden by default**
— you enable it on the specific view modes where you want the link. Because it targets
ordinary link fields too, you can also select its formatter on a normal link field.

The formatter builds the link through Drupal's render system, so the link text is
auto‑escaped and the URL comes from the entity itself (not from user input), and it
follows the correct **translated** URL on multilingual sites. You can customize the
link text (or fall back to the entity label), add CSS classes to style it as a button,
add `rel` attributes (nofollow / noopener / noreferrer / external), and choose the
link target (`_self`, `_blank`, `_parent`, `_top`).

One thing to know: the formatter renders the canonical link **regardless of whether
the current viewer can access the target entity** — it is a presentation helper, not
an access filter. It requires nothing outside Drupal core and adds no routes,
permissions, or services.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no central settings form. All setup happens on a bundle's **Manage Display**,
described in "How to use it" below.

## How to use it

After enabling the module:

1. Go to the **Manage Display** tab of any fieldable entity type — a content type,
   taxonomy vocabulary, user, and so on — and pick the view mode you want the link in
   (for example *Teaser*).
2. Find the **Display Link** field (it starts in the disabled/hidden region) and move
   it into a visible region so it renders.
3. Configure the formatter options:
   - **Link text** — e.g. "View", "Read more", or a custom string; leave it empty to
     fall back to the entity's label.
   - **Link target** — `_self` to stay in the same tab, `_blank` to open a new tab
     (or `_parent` / `_top`).
   - **`rel` attributes** — add `nofollow`, `noopener`, `noreferrer`, or mark the link
     `external` as needed (pair `noopener noreferrer` with `_blank`).
   - **CSS class(es)** — add classes to style the link, e.g. as a call‑to‑action
     button.
   - Optionally control whether the URL scheme (`https://`) is included.
4. **Save** the display settings. The link now appears on that view mode. Configure
   each view mode independently, and leave the field hidden on the ones where you
   don't want a link.
