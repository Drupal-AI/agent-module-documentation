<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up an Atom feed on a View

## Install / enable

`drush en atom -y` (or Extend UI). Only requirement is core `views`. Nothing else to configure —
the module just registers two Views plugins and their templates.

## Wire it up on a View

1. Create/edit a View. Add a **Feed** display (Displays → Add → Feed). A Feed display has a feed
   **path** and is usually "attached to" a page/block display.
2. In **Format → Show**, choose **Atom Feed** (the `atom` style plugin). This replaces the default
   RSS format for that Feed display.
3. In the row settings choose **Atom fields** (the `atom_fields` row plugin). It uses View fields,
   so add the fields you want to expose (title, a link field, a date field, a body/summary field, …)
   under **Fields** first.
4. Map fields in the row plugin's options form (`AtomFields::buildOptionsForm()`):
   - **Title field** (required) → entry `<title>`.
   - **Link field** (required) → entry `<link href>` and `<id>`. Must be an internal unprocessed
     path like `node/123`, or a processed root-relative URL as produced by a "Link to content" field.
   - **Publication date field** (required) → entry `<updated>`. Expected in a date/RFC-style format.
   - **Summary field** (required) → entry `<summary>`.
   - **Author name field**, **Author email field**, **Content field** — all optional.
   `AtomFields::validate()` enforces that title, link, date and summary are all set, otherwise the
   View fails validation with "Row style plugin requires specifying which views fields to use for
   Atom entry."
5. Set feed-level metadata in the **style** options form (`Atom::buildOptionsForm()`), all optional
   textfields (max length 1024): **Subtitle**, **Description URL** (rendered as `<link rel="related">`,
   only when subtitle is set), **Author name**, **Author email**, **Category**, **Logo**, **Icon**.

## What gets emitted

`Atom::render()` iterates `$this->view->result`, calling the row plugin per row, and hands the
collected `#rows` to the `views_view_atom` theme. `AtomFields::render()` builds a `\stdClass` item
whose properties are render arrays (`['#markup' => …]` or the field's own render array) pulled from
`getField()` (which delegates to `style_plugin->getField()` — the standard, field-handler-sanitized
Views field output).

`template_preprocess_views_view_atom()` (in `atom.module`) then sets:
- `title` from the display's own title option; `subtitle`, `link_related`, `author_name`,
  `author_email`, `category`, `logo`, `icon` from the style options.
- `langcode` from the current language; `link_alternate` = absolute `<front>` URL;
  `link_self` = absolute URL of the feed display; `updated_date` = now, formatted `DATE_ATOM`;
  `year` = current year.
- The response `Content-Type` header to `application/atom+xml; charset=utf-8` — **skipped during
  live preview** (`$view->live_preview`) so the preview renders inside the admin HTML page.

`template_preprocess_views_view_row_atom()` copies `title`, `link`, `date` (and optional
`author_name`, `author_email`, `content`) from the item, and — when `summary` is a render array —
renders it to a string via the `renderer` service so Twig can output it.

The `views-view-atom.html.twig` template emits the `<feed>` with `<title>`, optional `<subtitle>`,
`rel=alternate`/`rel=self` links, `<id>`, `<updated>`, an `<author>`/`<rights>` block (only when both
author name and email are set), and optional `<category>`, `<logo>`, `<icon>`, then the joined
entries. Each entry (`views-view-row-atom.html.twig`) is an `<entry>` with `<title>`, `<link>`,
`<id>`, `<updated>`, a `<summary type="xhtml">`, and optional `<author>` and `<content>` blocks.

## Notes / gotchas

- Feed rows come straight from the View, so all normal filters, sorts, pager, contextual filters and
  **access checks** apply — only rows the View permits are syndicated.
- The two plugins are hard-scoped to `display_types = {"feed"}`; they will not appear on page/block
  displays.
- This module ships **no config schema of its own**; the plugin options persist inside the View
  config entity via Views' own style/row option storage.
- Minor known quirk in `AtomFields::buildOptionsForm()`: the *Author email field* select's
  `#default_value` references `$this->options['author_name_email']` (a key that is never defined) —
  a harmless typo, so that select simply doesn't preselect a saved value. The stored option key is
  `author_email_field` and it still saves/renders correctly.
- The suggested contrib **Syndication** module exposes additional Atom capabilities if you need more
  than this style provides.
