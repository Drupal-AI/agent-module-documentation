# Dropdown Pager — manual setup guide

**Dropdown Pager** (`dropdown_pager`) gives Drupal Views an accessible,
space‑saving pager option. Instead of a long row of numbered page links, it shows
a compact dropdown button displaying the current position (for example "5 / 6")
together with First, Previous, Next, and Last controls. On a listing with many
pages, that's far tidier than a wall of numbers — and it's built to be usable by
everyone.

Accessibility is the point: the pager is WCAG 2.1 AA–oriented, with ARIA labels
and full keyboard navigation. It also offers an optional **search field** so a
visitor can jump straight to a specific page number, and **customizable text
templates** for the button and page links so you can word them to match your site.
It depends only on core's **Views** module, and it's fully themeable through a
`views-dropdown-pager.html.twig` template.

Importantly, this only changes how pages are *navigated* — it doesn't touch which
results appear or who can see them. Your View's own access and filtering apply
exactly as before.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** — you choose the dropdown pager
directly in a View's pager settings, described in "How to use it" below.

## Where it lives in the admin menu

Dropdown Pager adds no admin settings page of its own. You select it per View
under **Structure → Views** (`/admin/structure/views`), in that View's **Pager**
settings.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Views** (`/admin/structure/views`) and edit the View you
   want to change.
3. In the **Pager** settings, choose **"Paged output, dropdown pager"**.
4. Configure the options — items per page, the button and page‑link text templates,
   and whether to show the search field for jumping to a page.
5. **Save** the View. The dropdown pager appears automatically on the front end.

> **Tip:** Because it's a standard Views pager, everything else about the View —
> its filters, access, and results — stays exactly as you had it; only the pager
> presentation changes.
