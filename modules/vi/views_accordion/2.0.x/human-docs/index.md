# Views Accordion — manual setup guide

**Views Accordion** (`views_accordion`) adds a **jQuery UI accordion** display
style to Views, so you can render a view's rows as a collapsible accordion without
writing a line of JavaScript. Each result row becomes one accordion section: the
first field of the row is used as the clickable header (the trigger), and the
remaining fields make up the panel that expands when you click it. It is perfect
for FAQs (question as header, answer in the panel), team member lists (name and
bio), product features, schedules, changelogs, and any "click to expand" list
driven by a view.

Everything is configured **inside the view itself** — there is no separate admin
settings page, and the module adds no permissions, routes, or services of its own.
You set a view's **Format** to *jQuery UI accordion*, use the **Fields** row style
with at least two fields, and then tune the accordion's behavior in the style's
options: which section starts open, whether all sections can close at once, an
animation effect and duration, panel height behavior, the trigger event
(click or hover), header icons, and more. When Views grouping is enabled, you can
even use the group header as the accordion trigger.

It depends on core's **Views** module plus the contributed **jQuery UI Accordion**
module, which supplies the underlying jQuery UI Accordion library. The accordion
markup renders through a Twig template you can override, and the style's
configuration exports as part of the view's config like anything else in Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its jQuery UI
   Accordion dependency with Composer and enable it.

## Where it lives in the admin menu

There is no dedicated settings page. The accordion style appears as a **Format**
option inside any view you edit, under **Structure → Views**.

## How to use it

### Set up the accordion on a view

1. Enable the module and its `jquery_ui_accordion` dependency (see
   [Installation](installation/index.md)).
2. Edit a view and set **Format → Style** to **jQuery UI accordion**.
3. Set **Format → Row style** to **Fields** — this is required, and the style will
   error without it.
4. Add **at least two fields**. The **first field** becomes the accordion header /
   trigger; the rest form the panel that expands.
5. Open the style's settings and configure the options below.

### Accordion style options

- **Row to start open** *(default: Row 1)* — which section is open when the
  accordion first loads: a specific row number, **None** (all closed), or
  **Random** (a random section each load). Choosing **None** requires **Collapsible**
  to be on.
- **Collapsible** *(off by default)* — allow every section to be closed at once, so
  clicking the open header collapses it.
- **Disable if only one result** *(off by default)* — don't render the accordion
  when the view returns fewer than two results.
- **Animation effect** — the easing used when opening/closing (for example *swing*,
  *linear*, or a jQuery UI easing like *easeInOutQuart*), or **None** to disable
  animation.
- **Animation duration** *(default: 300 ms)* — how long the open/close animation
  takes.
- **Height style** *(default: auto)* — how panels are sized: **auto**, **fill**, or
  **content**.
- **Event** *(default: click)* — whether sections expand on **click** or on
  **mouseover** (hover).
- **Header icons** *(on by default)* — show jQuery UI icons on headers, and
  customize the closed‑ and open‑header icon classes (defaults
  `ui-icon-triangle-1-e` and `ui-icon-triangle-1-s`). Uncheck to hide icons.
- **Use group header as trigger** — when the view uses grouping, use the Views
  group header as the accordion trigger instead of the first field. This requires
  that grouping to have "Use rendered output to group rows" enabled.

By default only one section is open at a time (standard jQuery UI accordion
behavior) unless Collapsible lets the active one close. Nested or multiple
accordion views on one page are scoped by each view's DOM id, so they don't
collide. To change the markup, override the `views-accordion-view.html.twig`
template.
