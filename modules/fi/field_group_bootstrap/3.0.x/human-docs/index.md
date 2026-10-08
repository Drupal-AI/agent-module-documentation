# Field Group bootstrap — manual setup guide

**Field Group bootstrap** (`field_group_bootstrap`) adds a large set of
Bootstrap 5 formatters to the **Field Group** module. Field Group lets you gather
several fields into a named group on an entity's form or display; this module
gives those groups a Bootstrap look — accordions, tabs, cards, modals, offcanvas
panels, popovers, toasts, multistep wizards, and more — without you having to
write any templates by hand.

You use it exactly like any other Field Group formatter. On **Manage form
display** or **Manage display**, you create a field group, drag fields into it,
and choose one of this module's formatters as the group's *Format*. Most of the
formatters work in both contexts — the edit form *and* the rendered page — so you
can, for example, present a long node edit form as tabs and also wrap the same
fields in a card when the content is viewed.

The formatters emit Bootstrap 5 markup and CSS classes, so the module is intended
for a **Bootstrap 5‑based theme**. Without one, the groups still render but won't
pick up the Bootstrap styling. There is no admin settings page and no
permissions — everything is configured per field group, right in the Field Group
UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the Bootstrap 5 theme requirement.

## Where it lives in the admin menu

There is no dedicated settings page. You reach every formatter through the
Field Group UI on an entity's **Manage form display** or **Manage display** tab —
for example **Structure → Content types → *(your type)* → Manage display**.

## How to use it

1. Make sure the **Field Group** module is enabled and you're using a Bootstrap 5
   theme (see [Installation](installation/index.md)).
2. Go to **Manage form display** or **Manage display** for the entity you want to
   style.
3. Click **Add group**, give it a label, and choose one of the Bootstrap
   formats — for instance **Bootstrap Accordion**, **Bootstrap Tabs**, or
   **Bootstrap Card**.
4. Drag the fields you want into the new group.
5. Click the group's gear/settings icon to adjust its options (see below), then
   save.

### The available formats

- **Bootstrap Accordion** — collapsible panels. Options include which panel is
  open by default, an "always open" mode, a "flush" style that removes the
  background, and Bootstrap icon classes for the headers. It remembers which panel
  was open across page loads using a cookie.
- **Bootstrap Tab / Tabs** — organise a group into tabbed sections.
- **Bootstrap Card** — wrap the group in a Bootstrap card.
- **Bootstrap Modal** — show the group's contents inside a modal dialog.
- **Bootstrap Offcanvas** — slide the group in from the side of the screen.
- **Bootstrap Popovers** — attach popovers to the grouped content.
- **Bootstrap Toast** — present the group as a toast notification.
- **Bootstrap Toggle** — a simple collapse/expand around the fields.
- **Bootstrap Horizontal Form** — lay a form group out horizontally.
- **Bootstrap Floating Labels** — use floating labels on grouped form fields.
- **Bootstrap Grid** — arrange the fields in a Bootstrap grid.
- **Bootstrap Multistep** — turn field groups into a step‑by‑step form wizard.
- **Bootstrap ScrollSpy** — add scrollspy navigation across grouped sections.
- **Bootstrap Table** — render the group as a table, vertical or horizontal.
- **Twig element** — wrap the group's contents in an inline Twig template you type
  into the settings. This is powerful but sensitive: it runs Twig on the server,
  so keep the "administer … display" permissions restricted to trusted roles and
  don't build the template out of untrusted field values.

Each formatter has its own small settings form (reached via the gear icon) with a
short summary of the current choices. Save the display and the Bootstrap
component appears wherever the group renders.
