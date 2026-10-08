# CKEditor Layouts — manual setup guide

**CKEditor Layouts** (`ckeditor_layouts`) adds an **Insert layout** button to
the CKEditor 5 toolbar, letting editors drop multi-region layouts straight into
rich-text body content. The layouts come from Drupal core's **Layout API** (the
same definitions Layout Builder uses), and they are inserted as nested `<div>`
structures — so editors can build two-column bands, call-to-action sections, and
similar arrangements inside an ordinary body field, without Layout Builder and
without hand-writing grid markup.

It is a single CKEditor 5 plugin. You enable it per text format by dragging the
Insert layout button onto that format's toolbar, and a settings tab lets you
limit which of the site's registered layouts are offered in that editor. The
module takes care of the fiddly parts: it renders each layout (with every region
present so editors can fill any of them), loads the layout's CSS into the editor
so the regions look right while editing, and auto-configures CKEditor 5's General
HTML Support so the layout's `<div class>` wrappers survive text-format
filtering.

Two things stay your responsibility: the text format must *allow* the layout
markup (practically, `<div class>` in the allowed-HTML list), and your front-end
theme must style the layout classes so the columns actually render as columns on
the page. Because the whole thing is configured on the text editor and format —
there's no standalone settings page — this guide folds the "how to use it"
details into this page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs, especially
[`agent/configure/editor.md`](../agent/configure/editor.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside CKEditor 5 and Layout Discovery.

## How to use it

Everything happens under **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).

1. **Add the toolbar button.** Edit a format that uses CKEditor 5 (e.g. *Full
   HTML*). In the toolbar configurator, drag the **Insert layout** button from
   *Available buttons* onto the active toolbar. This switches the plugin on.
2. **Choose which layouts are offered.** A **Layouts** settings tab now appears
   below the editor, listing every registered core layout as a checkbox. Tick
   only the layouts you want editors to have (for instance, just one-column and
   two-column). You must enable at least one.
3. **Let the markup through the filter.** If the format uses *Limit allowed HTML
   tags and correct faulty HTML*, add `<div class>` (and any element/class your
   custom layouts emit) to the allowed tags. Full HTML formats need nothing
   extra.
4. **Style it in your theme.** On the rendered page only your front-end theme's
   CSS applies — target the layout's CSS classes there so the regions display as
   intended. The module styles the layouts *inside* the editor automatically,
   but does not inject front-end layout CSS.

Any layout registered through the core Layout API is picked up automatically, so
custom layouts you define in a module or theme `*.layouts.yml` file appear in the
checklist after a cache clear.

## Where it lives in the admin menu

There is no dedicated settings page. Configuration is on each text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).
