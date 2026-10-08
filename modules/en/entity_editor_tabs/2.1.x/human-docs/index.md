# Entity Editor Tabs — manual setup guide

**Entity Editor Tabs** (`entity_editor_tabs`) tidies up the primary tabs and
operation links on content entities so the editorial workflow reads clearly when
**Layout Builder** and/or **Content Moderation** are in use. On a stock Drupal
site those tabs — *View*, *Edit*, *Layout*, *Latest version* — can be confusing:
"Edit" and "Layout" both edit the page in different ways, and "View" gives no hint
about whether you are looking at the published version or a draft. This module
relabels and reorders them to make the difference obvious, with **no configuration
required**.

When a bundle has **Layout Builder overrides** enabled, the module retitles the
**Layout** tab to the clearer "Edit content" and reframes the core **Edit** tab as
editing *metadata* (the entity operation links become "Edit metadata" and "Edit
&lt;content item&gt;" too). When a bundle is **moderated by Content Moderation**, it
makes the **View** tab show the current moderation state — for example "View Draft"
— so editors immediately know which revision they are looking at, rather than
guessing. It also re-weights the View, Latest version, Edit, Layout, and Delete
tabs so that view-oriented and edit-oriented tabs group together sensibly, while
never moving the canonical View tab out of its position.

All of this is driven automatically, per bundle, from whether that bundle is
moderated or Layout-Builder-overridable — there is **no settings page, no
permissions, and no Drush commands**. The effect simply appears once the module is
enabled (and only where Layout Builder or Content Moderation is actually in play).
The module recommends the companion
[`layout_builder_operation_link`](https://www.drupal.org/project/layout_builder_operation_link)
module if you also want a direct "jump to Layout Builder" link from content lists.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no admin page. The changes appear directly on the tabs and
operation links of your content entities (nodes, media, taxonomy terms, and so on),
on bundles that use Layout Builder overrides or Content Moderation.

## How to use it

There is nothing to configure. After you install and enable the module:

- On **moderated** bundles, the **View** tab shows the current moderation state
  (for example "View Draft") when you are looking at a forward/draft revision rather
  than the live one.
- On **Layout Builder** bundles, the **Layout** tab reads **"Edit content"** and the
  **Edit** tab is reframed as editing metadata; the matching entity operation links
  are relabelled the same way.
- The tabs are reordered into a logical **View → Latest version → Edit → Layout →
  Delete** grouping, with the View tab kept in place.

If a bundle uses neither Layout Builder overrides nor Content Moderation, the module
leaves its tabs unchanged.
