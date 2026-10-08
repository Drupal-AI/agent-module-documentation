# Menu vs URL Alias — manual setup guide

**Menu vs URL Alias** (`menu_vs_url_alias`) connects the two vertical tabs on a
node edit form that normally sit apart: the **Menu settings** tab and the **URL
alias** tab. Its goal is to enforce cleaner, more consistent URL conventions by
making content editors choose *one* approach per page rather than letting the two
drift out of sync.

When the feature is enabled for a content type, the form behaves like this: if the
editor enables a **menu item** for the node, the URL alias tab and its fields are
hidden (the path comes from the menu, most likely via
[Pathauto](https://www.drupal.org/project/pathauto)); conversely, if no menu item
is enabled, a **custom URL alias becomes required**. That way every page has a
deliberate path — either menu‑based or explicitly custom — and never an accidental
mismatch between the two.

The module depends on **Pathauto**. It adds no settings form of its own; you switch
the behaviour on per content type. For the tidiest result the project suggests also
hiding the URL alias tab (with a module such as
[Simplify](https://www.drupal.org/project/simplify)) on content types that always
follow a fixed pattern — but that is optional and not a dependency. This is an
editorial content‑quality tool with no security surface; confirm the validation
matches your site's own menu/alias conventions before rolling it out.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** — the module has no settings form. You
enable the behaviour per content type, as described below.

## How to use it

1. Go to **Structure → Content types** (`/admin/structure/types`) and edit the
   content type you want to govern.
2. Open the **Menu vs URL Alias** vertical tab on the content type settings form.
3. Enable the feature there and save the content type.

From then on, add/edit forms for that content type enforce the menu‑or‑alias
choice: enabling a menu item hides the alias fields, and leaving the menu item off
makes a custom alias required.
