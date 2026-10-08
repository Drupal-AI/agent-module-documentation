# Timeline Styles — manual setup guide

**Timeline Styles** (`timeline_styles`) provides Views **style plugins** that render
a view's rows as a vertical, chronological timeline of events — with an
image-enabled variant — plus a ready-made content type, vocabulary, and demo view so
you can get a timeline running quickly.

It registers two Views formats: **Timeline Styles** and **Timeline Styles With
Image**. You switch any view's *Format* to one of them, then choose which field acts
as each event's title (and, in the image variant, which field is the image); the
remaining fields render in the event body. Because it builds on Views, the timeline
inherits Views' filtering, sorting, access handling, and language support, and it
updates itself as content changes — which is usually what you want for a company
history, a roadmap, or an events page.

On enable, the module also installs starter configuration: a `timeline_styles`
content type with fields for date, colour, icon, image, and tags (using a
`timeline_styles_tags` vocabulary), matching display modes, an image style, and a
demonstration `timeline_styles` view you can clone. You can use that out of the box
or apply the format to any view of your own dated content.

This is a front-end display module: it adds no routes, permissions, controllers, or
custom forms beyond the Views style options, so there is no anonymous, mutating, or
external surface. Field values render through Views' own field handlers and standard
Twig templates, so output escaping follows core Views and Twig. It depends on core
**Views** plus the contrib **Color Field** and **Color Picker** modules (for the
per-event colour field), and works on Drupal 9.3, 10, and 11. Note that this release
is not covered by drupal.org's security-advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Color
   Field / Color Picker dependencies) with Composer and enable it.

## How to use it

There is no central settings page; you configure a timeline through the Views UI:

**Option A — use the shipped starter.** After enabling, you already have a
`timeline_styles` content type and a demo `timeline_styles` view. Create a few nodes
of that type (each with a date, and optionally colour, icon, image, and tags) and
visit the demo view to see them on a timeline. Clone the view as a starting point
for your own.

**Option B — convert any view.**

1. Create or edit a **View** of the content you want to show.
2. Set **Format → Timeline Styles** (or **Timeline Styles With Image**).
3. In the format settings, pick the **title field** for each event — and the
   **image field** if you are using the image variant.
4. Add whatever other Views fields you want to appear in each event's body.

The module's `timeline_styles/global-styling` CSS library is attached automatically
when the view renders. To restyle, override `timeline-styles.html.twig` (or
`timeline-styles-image.html.twig`) in your theme. The plugins also support Views row
CSS classes and grouping.
