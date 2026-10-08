# Gin Everywhere — manual setup guide

**Gin Everywhere** (`gin_everywhere`) extends the polished edit-form layout from
the **Gin** admin theme — the sticky action bar at the bottom and the "advanced"
meta sidebar on the right — to *every* content entity's forms, not just nodes.

Out of the box, Gin gives node add/edit forms that nice two-column treatment, but
only for a fixed list of routes. So media forms, taxonomy term forms, user profile
forms, custom block forms, and your own custom entity forms miss out and look
plain by comparison. Gin Everywhere closes that gap: it tells Gin to apply its
content-form layout to the add, edit, revision, and translation forms of all
content entity types, and it builds the structure those templates expect — the
advanced vertical-tabs sidebar, a Status / last-saved / author meta panel, an
Authoring information group, the published checkbox moved into the sticky footer,
and the URL-alias widget relocated into the sidebar.

Best of all, it does this automatically and dynamically: because it derives the
routes from your site's entity types, newly added custom entity types get Gin's
layout too, with no per-entity theming work on your part.

**There is no configuration at all** — enabling the module *is* the entire setup.
It only has an effect while Gin (or a Gin sub-theme) is your active admin theme,
and it requires the Gin theme to be present before it will install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the Gin theme and this module
   with Composer, then enable them.

## Where it lives in the admin menu

Nowhere — Gin Everywhere has **no settings page and no configuration**. Once it's
enabled (with Gin set as your admin theme), just open any content entity's add or
edit form — a taxonomy term, a media item, a user, a custom entity — and you'll
see Gin's two-column layout with the advanced sidebar and sticky action bar
applied.

## How to use it

1. Make sure the **Gin** theme is installed and set as your **administration
   theme** at **Appearance** (`/admin/appearance`). Gin Everywhere only transforms
   forms while Gin (or a sub-theme of Gin) is the active admin theme.
2. Enable Gin Everywhere (see [Installation](installation/index.md)).
3. That's it. Visit any content entity form — for example **Structure → Taxonomy →
   (a vocabulary) → Add term**, or a media item's edit form — and it now uses
   Gin's content-form layout, complete with the Status/author meta sidebar and the
   published checkbox in the sticky footer.
