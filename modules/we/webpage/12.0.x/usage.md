Webpage is a recipe-driven module that installs a ready-to-use "Webpage" content type for building publicly accessible site pages with the Display Builder.

---

Webpage is a thin, config-bundle module in the Webship `web*` suite. It ships almost no PHP: `webpage_install()` applies the bundled `recipes/default` recipe, which enables a stack of core and contrib modules and imports the configuration that makes up a general-purpose page type. The recipe creates a `webpage` node type (with revisions and preview enabled, submitted-by info hidden, and its links placed in the `main` menu), a `body` text-with-summary field, `teaser` and `full` view modes whose displays are rendered through Display Builder, a `promote` base-field override, the standard `editorial` content-moderation workflow (Draft/Published/Archived, defaulting new content to Draft), and a Pathauto alias pattern based on the node's parent menu link and title. Alongside the page type it also brings in core content plumbing (Image, Datetime, Options, Menu link content, Views), the core content views, the large/thumbnail image styles, and a Webform + Webform UI install with a ready-made contact form at `/form/contact`. Editors work with it exactly like any core content type: create Webpage nodes, move them through the editorial workflow, and let Pathauto generate clean nested URLs.

---

- Install a general-purpose "Webpage" content type in one step via the bundled default recipe.
- Add publicly accessible, editor-authored web pages to a Drupal 11.4+/12 site.
- Provide a `body` (text with summary) field on every Webpage node for the main content.
- Render Webpage teaser and full displays through the Display Builder instead of the classic field UI.
- Use the `full` view mode to lay out the complete page body with Display Builder.
- Use the `teaser` view mode to show a Smart Trim (300-char) excerpt with a "More" link in listings.
- Moderate page content with the standard Editorial workflow (Draft → Published → Archived).
- Start every new Webpage as an unpublished Draft by default until an editor publishes it.
- Restore or re-draft archived pages using the workflow's Restore / Restore to Draft transitions.
- Generate clean nested URL aliases automatically from the page's parent menu link and title (Pathauto).
- Place Webpage nodes into the `main` menu and build a nested site-section navigation hierarchy.
- Promote selected pages to the front page via the `promote` field.
- Keep revisions on every Webpage (new_revision enabled) for content history and rollback.
- Preview pages before saving (preview enabled on the content type).
- Get a working contact form out of the box at `/form/contact` (Webform contact template).
- Bootstrap a new site's core content setup (content/frontpage/archive/glossary/recent views, image styles, people views).
- Serve as the base page type for a Webship / UI Suite (UIkit + HTMX) site build.
- Extend the page type with additional fields via the normal Manage fields UI on `webpage`.
- Customize per-page layout in the Display Builder for advanced site-section pages.
- Reuse the recipe as a dependency of a larger site-install recipe rather than installing the module standalone.
