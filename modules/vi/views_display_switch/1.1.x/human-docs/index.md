# Views Display Switch — manual setup guide

**Views Display Switch** (`views_display_switch`) adds a small "switcher" to a
view so visitors can flip between two or more of that view's displays — a grid
page and a table page, "Upcoming" and "Past" events, a map view and a list view
— without losing where they were. When someone switches, their exposed-filter
selections and current pager page are carried across to the new display, so the
results they were looking at stay put.

You add it as a Views **area handler** called *Display switch*, dropped into a
view's header or footer. In its options you tick the displays you want links
for and give each one a friendly label. Only **page (path-based) displays** and
**block displays** are eligible — attachment, feed and embed displays are left
out. Page displays link to their own path; block displays (which have no path of
their own) are switched in place on the current page using a `?mode=<display_id>`
query parameter that the module reads and applies.

The module has no global settings page and adds no permissions — everything is
configured per view in the Views UI. It depends only on core's **Views** module.
One thing to keep in mind: it assumes a single view per page, and mixing page and
block displays on the same page can behave unexpectedly. If two linked displays
use different filter, sort or pager settings, the module shows a warning at
configuration time (it does not block saving) because switching would then give a
different set of results.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no admin settings page. You work entirely inside the **Views UI**
(*Structure → Views*, `/admin/structure/views`) when editing an individual view.

## How to use it

1. Edit a view that has at least two eligible (page or block) displays.
2. In the **Header** or **Footer** section, click **Add** and choose **Display
   switch** (it is in the *Global* group).
3. In the handler's options, tick each display you want a link for under
   **Displays**, and set a **Label** for each enabled display (a label is
   required when a display is enabled).
4. Save the view.

The switch links render wherever you placed the area, on every display that
includes it. The link for the currently active display gets a
`views-display-switch__link--active` CSS class so you can highlight it. To change
the markup — for example to render the links as buttons or a segmented control —
override the `views-display-switch.html.twig` template in your theme.

For results to stay consistent after a switch, make the linked displays share the
same filter, sort, pager and contextual-filter configuration. If they differ,
the module warns you when you save but still lets the configuration through.
