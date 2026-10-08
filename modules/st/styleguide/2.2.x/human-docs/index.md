# Style guide — manual setup guide

**Style guide** (`styleguide`) generates a live preview page that renders all the
common HTML elements a theme has to style — typography, headings, tables, forms,
buttons, links, lists, blockquotes, images, menus, breadcrumbs and more — using
sample content, in each of your active themes. It's the front-end developer's
proofing sheet: one page where you can confirm everything is styled consistently
and catch unstyled or broken elements before launch.

Visit **/admin/appearance/styleguide** and you'll see the style guide for your
default theme. The module also generates a route (and a tab) for every enabled,
non-hidden theme, plus a maintenance-page preview per theme, and it uses a theme
negotiator to render each page *in that actual theme* — so you're looking at real,
themed output, not an approximation. That makes it easy to compare how the same
elements look across multiple themes, or to QA a theme upgrade by diffing the guide
before and after.

The list of previewed elements is built from **Styleguide plugins**. The module
ships several (covering default HTML, comments, text-format filters, images,
layouts, search, and Views output), and other modules can add their own elements by
providing a plugin or implementing `hook_styleguide_alter()`. Themers can override
the module's theme hooks to change how the guide itself is laid out. Style guide
stores no configuration of its own — there's no settings form — but it does define
one permission to control who can see the guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the "view style guides" permission.

## Where it lives in the admin menu

The style guide lives under **Appearance → Style guide**
(`/admin/appearance/styleguide`), with a tab for each enabled theme. There is no
separate settings page.

## How to use it

1. After enabling, grant the **View style guides** permission to your themer /
   front-end developer roles at **People → Permissions**
   (`/admin/people/permissions`) — see [Installation](installation/index.md).
2. Go to **Appearance → Style guide** (`/admin/appearance/styleguide`) to view the
   default theme's guide.
3. Use the tabs at the top to switch to any other enabled theme's guide, rendered in
   that theme. If a theme you just enabled doesn't appear as a tab yet, rebuild
   caches (`drush cr`) so its route is registered.
4. Scroll through to proof typography, tables, forms, links, images and the rest.
   There's also a maintenance-page preview per theme so you can check that state
   too.

Because the guide uses generated sample content (including edge-case lengths), it's
a handy reference for onboarding new developers and for validating that a CSS
refactor didn't regress any common element.
