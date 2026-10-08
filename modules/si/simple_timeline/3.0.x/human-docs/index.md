# Simple Timeline — manual setup guide

**Simple Timeline** (`simple_timeline`) adds a Views **style** that renders the
rows of any view as a vertical timeline, with each item shown as a marker on a
central line. It is a clean way to present anything chronological — a company
history or milestones page, an events list, a résumé or work history, a changelog
or release history, a project roadmap, or a person's activity feed — without
writing custom Twig or CSS from scratch. Because it is a Views style, you get all
of Views' power for free: exposed filters so visitors can filter the timeline,
contextual filters for a per-term or per-author timeline, pagers, and any row
plugin (fields or rendered entity).

There is no admin settings page. You use it by choosing **Simple Timeline** as the
*Format* of a view, then setting a few options in the style settings: where items
sit relative to the line (alternating left/right, all left, or all right), where
the marker sits vertically on each item (top, center, or bottom), and two CSS
class hooks for your own styling. All of this is stored in the view's
configuration, so it exports and deploys like any other view.

The timeline's line color and marker appearance are meant to be finished off with
a few CSS rules in your own theme — the module ships a base stylesheet and gives
you class hooks to override. Simple Timeline requires core's **Views** module,
works on Drupal 10.4+, 11, and 12, and defines no permissions, Drush commands, or
global configuration of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

(There is no separate configuration page — the module has no settings form. You
configure it per view in the Views UI, described below.)

## Where it lives in the admin menu

There is no admin page of its own. You apply and configure the style inside the
Views UI at **Structure → Views** (`/admin/structure/views`), on whichever view
you want to display as a timeline.

## How to use it

1. Create or edit a view of the content you want to show chronologically (for
   example, add a sort on the post/created date).
2. In the view, set **Format** to **Simple Timeline**.
3. Click the format's **Settings** and choose:
   - **Item position** — *alternate* (items alternate left and right around the
     line, the classic timeline look), *left* (all items on the left for a
     compact single column), or *right* (all on the right).
   - **Marker position** — *marker-top*, *marker-center* (the default), or
     *marker-bottom* — where the marker sits vertically on each entry.
   - **Wrapper class** and **List class** — optional CSS class names (defaults
     `wrapper-list` and `item-list`) you can use to scope your own styling.
4. Pick a **Row style** as usual (Fields, or Rendered entity) to control what each
   timeline item contains, and save the view.

### Styling the timeline

The module attaches a base stylesheet, but the line color and marker look are
meant to be overridden in your own theme. The markup uses `ul.timeline-list` with
`li.timeline-item` items and a `span.timeline-marker` per item, so a few CSS rules
finish the look, for example:

```css
/* Timeline line color */
ul.timeline-list:after {
  background-color: #555555;
}

/* Marker color / shape */
ul.timeline-list li.timeline-item .timeline-item-wrapper span.timeline-marker {
  background: #fff;
  border: 3px solid #555555;
}
```

The **Wrapper class** and **List class** options let you add your own hook classes
so you can scope overrides to a specific timeline. For deeper customization the
module also provides a template (`views-view-simple-timeline.html.twig`) with
view/display-specific theme suggestions.
