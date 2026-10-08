<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Styleguide builds a single living-styleguide page at `/simple-styleguide` that shows a chosen set of built-in HTML patterns, a colour palette, and any custom HTML patterns you add — so a theme's components render with the site's real CSS in one place.

---

The module renders one styleguide page (route `simple_styleguide.controller`, path `/simple-styleguide`, permission **access style guide**) using the `simple_styleguide` theme hook and per-section Twig includes. A settings form (`/admin/config/styleguide/settings`, config object **`simple_styleguide.styleguidesettings`**) lets you tick which of eleven **default patterns** appear — `headings`, `text`, `lists`, `blockquote`, `rule`, `table`, `alerts`, `breadcrumbs`, `forms`, `buttons`, `pagination` — and define a **colour palette** as newline-separated `#hex|class|description` lines (`default_colors`). Beyond the built-ins you create **custom patterns** as `styleguide_pattern` **config entities** (label, raw-HTML `pattern`, rich-text `description`, `weight`), managed through a draggable list at `/admin/config/styleguide/patterns` (admin permission **administer style guide**); each renders through the `simple_styleguide_pattern` theme hook with a per-id template suggestion (`simple_styleguide_pattern__<id>`). The page ships a CSS/JS library (`simple_styleguide.default`) and is forced `noindex, nofollow` via `hook_page_attachments_alter`. Because custom patterns are config entities, they are exportable and deployable like any other config. The module has no Drush commands and defines no new plugin types.

---

- Publish a living styleguide of your theme's base HTML elements at `/simple-styleguide`.
- Let front-end devs preview headings, text, lists, tables and buttons with the site's real CSS.
- Toggle which built-in patterns (headings, buttons, forms, pagination, …) appear on the page.
- Document a project colour palette with hex value, CSS class name and usage note per colour.
- Add a custom HTML pattern (e.g. a card or hero component) as a reusable styleguide entry.
- Reorder custom patterns via the draggable weight-based list.
- Give each custom pattern a rich-text description explaining when to use it.
- Export custom `styleguide_pattern` entities to config and deploy them across environments.
- Provide designers a single reference URL for approved components.
- QA CSS regressions by eyeballing all patterns on one page after a theme change.
- Restrict styleguide access to specific roles via the `access style guide` permission.
- Restrict who can edit patterns via the `administer style guide` permission.
- Override a single pattern's markup with a `simple_styleguide_pattern__<id>` template suggestion.
- Theme the whole styleguide by overriding `simple-styleguide.html.twig`.
- Keep the styleguide out of search engines automatically (forced noindex/nofollow).
- Onboard new team members with a visual catalogue of the design system.
- Show alerts/messages styling variants in one place.
- Preview breadcrumb and pagination styling without building real content.
- Demonstrate form-element styling (inputs, buttons) to stakeholders.
- Maintain a component inventory that lives in code (config) rather than a separate tool.
- Add brand colours as classes and confirm their computed values (hex + derived RGB).
- Use the module's CSS/JS library as a base for styleguide-specific styling.
- Build a lightweight alternative to heavier pattern-library tools for small sites.
- Keep default patterns and custom components side by side for a complete reference.
