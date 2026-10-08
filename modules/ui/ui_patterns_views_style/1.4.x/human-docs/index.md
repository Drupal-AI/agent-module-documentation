# UI Patterns Views Style — manual setup guide

**UI Patterns Views Style** (`ui_patterns_views_style`) lets you render a View's results
through a **UI Patterns component** instead of a stock Views style. If your site already
has a design system built with UI Patterns — a cards grid, a slider, a set of tabs — you
can point any View at one of those components and have the listing come out in your
design system's markup, with no bespoke `views-view--*.html.twig` template to write.

It works by adding a single **Pattern** option to a View display's *Format* setting. When
you pick it, you choose which pattern (and variant) to render, then map two sources — the
View's **title** and its rendered **rows** — onto that pattern's slots. At render time
each Views group becomes an instance of your component, with the title flowing into the
heading slot and the rows flowing into the main content slot.

There is **no settings page, no permissions, and no Drush commands** — everything is
configured directly on the View. The module depends on core **Views** and on
**UI Patterns**, and optionally uses **UI Patterns Settings** to expose per-pattern
settings on the View.

> **Version note:** this 1.4.x branch targets the **UI Patterns 1.x** API. Make sure the
> UI Patterns version on your site matches.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

The module adds no page of its own. It surfaces entirely inside the **Views** UI at
**Structure → Views** (`/admin/structure/views`) — specifically in a display's **Format**
setting, where **Pattern** becomes a selectable style.

## How to use it

### 1. Choose the Pattern style on a View

1. Go to **Structure → Views**, edit a View, and pick the display you want to style.
2. Under **Format**, click the current style and choose **Pattern**, then open its
   *Settings*.

### 2. Configure the pattern and mapping

In the style settings:

- **Pattern** — the component you want to render each group of results with.
- **Variant** — the component's variant, if it has more than one.
- **Field mapping** — map the two available sources onto the pattern's slots:
  - **title** → the slot where the heading should go (this uses the group title, or falls
    back to the View's title).
  - **rows** → the slot where the list of rows should go.
  - Set either source to **`_hidden`** if you don't want it passed to the pattern.
- **Pattern settings** — only appears if the optional **UI Patterns Settings** module is
  enabled; lets you set per-pattern options right on the View.

### 3. Configure the Row style too

Because the Pattern style still uses a row plugin, set the **Row style** (Fields, or an
entity row such as teasers) the way you normally would. Those rendered rows are exactly
what gets passed into the pattern as the **rows** source.

### 4. Save and preview

Save the View. Each Views group is now rendered as its own instance of your chosen
component. To change the look, just switch to a different pattern or variant — no theme
overrides needed. Advanced themers can override the `view--pattern.html.twig` template to
change how the pattern is invoked.

> **Upgrading from an older release?** If you have Views that used an earlier version of
> this style, run database updates (`drush updatedb`) after upgrading — a built-in update
> hook migrates the old pattern-style configuration to the current shape.
