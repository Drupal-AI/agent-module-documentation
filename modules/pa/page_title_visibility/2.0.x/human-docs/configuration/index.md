# Configuration

Page Title Visibility has no central settings form. You configure it in two places:
on each node, and (for defaults) on each content type. A single permission controls
who can touch either one.

## The permission

**Administer page display visibility config** (marked as a restricted/trusted
permission) is required to change the per-node checkbox or the per-type default.
Grant it at **People → Permissions**. Users *without* it still see the checkbox on
the node form, but it is **disabled** and shows the note "Your account does not have
permission to set the page title visibility."

## Per-node: the Display page title checkbox

When adding or editing a node, open the **Page display options** section (it sits in
the advanced/vertical tabs on the node form) and you'll find a **Display page title**
checkbox:

- **Ticked** (the default) — the page title shows normally.
- **Unticked** — on that node's page, the Page Title block gets core's
  `visually-hidden` class, so the `<h1>` remains in the HTML (good for screen readers
  and SEO) but is hidden from view.

The field is revisionable and translatable, so the setting is preserved across
revisions and per translation. For a brand-new node, the checkbox's starting state is
seeded from the content-type default below.

## Per-content-type: the default

To set what new nodes of a given type start with:

1. Go to **Structure → Content types → *(your type)* → Edit**.
2. Find the **Page display defaults** section.
3. Set whether the page title should display by default for this type.
4. Save.

This default is stored in a small config object
(`page_title_visibility.content_type.<bundle>`) and seeds the per-node checkbox for
new nodes whose own value hasn't been set. For example, you can default new **Basic
page** nodes to a hidden title while keeping **Article** titles visible.

## When the title stays visible regardless

The title is deliberately left visible on:

- node **edit**, **delete**, and **revision (version history)** routes, and
- **non-node** pages — Views listings, taxonomy term pages, the front page, etc.

So the hiding only ever applies to the canonical view of a node whose flag resolves
to hidden.

## Setting a default from the command line

```bash
ddev drush config:set page_title_visibility.content_type.page display_page_title 0 -y
```

(That example makes new **Basic page** nodes default to a hidden title.)
