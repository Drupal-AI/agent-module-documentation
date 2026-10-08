# Field Group Link — manual setup guide

**Field Group Link** (`field_group_link`) adds a new **"Link"** display format to the
[Field Group](https://www.drupal.org/project/field_group) module. It wraps every
field inside a group in a single `<a>` tag, so a whole block of output — a teaser, a
card, an image plus caption — becomes one clickable link. It's the clean,
exportable way to build a "clickable card" without hand-writing an `<a>` wrapper in a
Twig template.

You use it entirely through the standard **Manage display** screen: create a Field
Group of type **Link**, drop the fields you want wrapped inside it, and choose where
the link points. The destination can be the entity's own page (perfect for teasers),
a URL held in a field on the content (a link, file, image, or entity-reference
field), or a custom URL you type — with token support, so you can build something
like `https://shop.example.com/p/[node:field_sku]`. You can also send the link to a
new tab and add your own CSS classes to the generated anchor.

Because it only makes sense for output, the Link format appears on **Manage
display** and never on the form-display screen. Everything is stored as part of the
view display's configuration, so it exports cleanly with `drush cim`/`cex`. There is
no settings form and no permission of its own; it requires the Field Group module
(version 3 or 4).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and Field Group).

## Where it lives in the admin menu

There's no dedicated settings page. You work on the content type's (or other
entity's) **Manage display** screen — for example **Structure → Content types →
Article → Manage display** (`/admin/structure/types/manage/article/display`), or a
specific view mode such as *Teaser*.

## How to use it

1. Go to the **Manage display** screen for the bundle and view mode you want (e.g.
   Article → Teaser).
2. Click **Add group**, choose **Link** as the format, give it a label, and **Save
   and continue**.
3. Configure the group's settings:
   - **Link target** — where the anchor points:
     - **Full page** *(the entity)* — the canonical URL of the item being rendered.
       The usual choice for teasers and cards. (Nothing is rendered for an
       unsaved/new entity.)
     - **Custom URL** — a URL you type. Tokens are supported (a token browser appears
       if the Token module is enabled). It must be a full URI, e.g.
       `https://…`, `internal:/…`, or `entity:node/1`. An invalid URL simply
       produces no link.
     - **A field on this bundle** — pick a `link`, `file`, `image`, or
       `entity_reference` field and the group links to that field's destination (the
       link's URL, the file's URL, or the referenced entity's page). Only non-base
       fields of those types are offered.
   - **Custom URL** — the URL used when you chose *Custom URL* above.
   - **Target attribute** — set to *_blank* to open the link in a new tab, or leave
     it at *default* to open in the same tab.
4. Back on the Manage display screen, **drag the fields you want wrapped** so they
   sit underneath the Link group row.
5. Save the display.

The group now renders as a single anchor with the CSS class `field-group-link` (plus
any classes you added in the group's settings), wrapping all of its child fields.

### Important: keep the contents link-safe

Because the output is a real `<a>` element, don't nest anything that produces its own
link inside the group — a link field, a rich-text/formatted-text field, or another
Link group. Nesting a link inside a link produces invalid HTML. Keep the wrapped
fields to plain output like images, plain text, and titles.

### Handy tips

- Add a design-system class (for example `card-link stretched-link`) via the group's
  **CSS classes** setting to style the clickable card.
- Configure different destinations per view mode — a teaser can link to the node
  while the full view links to an external source.
- Only the first value of a multi-value target field is used.
