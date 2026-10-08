# Configuration

Claro Extras is configured from a single settings form. Everything it does is
optional and off until you turn it on.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission (an
   administrator by default).
2. Go to **Appearance → Settings → Claro Extras**, or navigate directly to
   `/admin/appearance/settings/claro_extras`. It is also linked from the theme
   settings.

The form itself uses vertical tabs to group its options.

## Options

### Show the node meta block as vertical tabs

When enabled, the node "meta" block — author, published status, and the other
sidebar details — is moved into **vertical tabs beneath the main node form**,
rather than sitting to the side. This gives editors a cleaner, more focused editing
layout.

- **Content types** — a set of checkboxes lets you choose **which content types**
  this applies to. Tick only the types where you want the vertical-tabs layout;
  leave others as Claro's default.

This behaviour only takes effect when the active admin theme is **Claro**.

### Fix the node-edit breadcrumb

When enabled, this removes the misleading `node` breadcrumb link that Claro shows
on node edit pages — a small correctness fix so the breadcrumb no longer points at
an unhelpful `node` listing.

### Enhance Paragraph titles

When enabled, Paragraph titles are shown more prominently in the main node form,
making nested Paragraphs easier to scan while editing. This is most useful on sites
using the Paragraphs module, and (like the vertical-tabs option) applies when Claro
is the admin theme.

## Save

Click **Save configuration** at the bottom of the form. Settings are stored in the
`claro_extras.settings` configuration. Reload a node edit page to see the changes —
remembering that they only appear when Claro is your active admin theme.
