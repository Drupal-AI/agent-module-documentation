# Configuration

Every Layout Builder Extras feature is opt‑in and lives on one settings form.
If you never open it, the module does nothing — so this page is where you make
the module actually do its work.

## Open the settings form

1. Log in as a user with the **Manage layoutbuilder_extras settings** permission
   (`manage layoutbuilder_extras settings`).
2. Go to **Configuration → Content authoring → Layout Builder Extras settings**,
   or navigate directly to
   `/admin/config/content/layout-builder-extras-settings`.

Tick the features you want and click **Save configuration**. Each option is
independent — turn on only what suits your team.

## The settings, one by one

- **Section actions position** — choose whether each section's action buttons
  sit to the **left** (default) or on **top** of the section. This only affects
  the position of the icon‑only buttons below.

- **Redirect on save** — after you save a Layout Builder‑enabled node, jump
  straight back to its Layout Builder edit page instead of viewing the node.
  Handy when you're doing several rounds of layout tweaks. The redirect only
  happens if the current user actually has access to that edit page, so it never
  exposes the Layout Builder screen to someone who couldn't already reach it.
  *(Off by default.)*

- **Configure AJAX save** — enable live AJAX changes on the section configure
  form, so edits apply without a full page reload. *(Off by default.)*

- **Remove empty divs** — strip empty region wrappers from the rendered
  front‑end page, so layout templates don't leave behind empty `<div>`s. This
  only affects the public‑facing output, not the Layout Builder editing screen.
  *(Off by default.)*

- **Drag handle icon** — add a clearly visible drag‑handle icon to the Layout
  Builder off‑canvas sidebar, making it obvious where to grab items to reorder
  them. *(Off by default.)*

- **Admin CSS / icon‑only buttons** — replace the text add/configure/remove
  links in the Layout Builder UI with compact icon‑only buttons, and apply the
  module's admin restyling. This is also what positions the section‑action
  buttons according to your **Section actions position** choice above.
  *(Off by default.)*

- **Contextual links only in Layout Builder** — hide the little contextual‑link
  pencils everywhere on the site *except* on Layout Builder pages. This is a
  cosmetic visibility preference to reduce clutter for content editors — it does
  **not** change access control, since each contextual link's target still
  enforces its own permissions. *(Off by default.)*

- **Contextual links roles** — when the option above is on, pick the roles that
  should keep seeing contextual links everywhere. Anyone in a selected role is
  exempt from the hiding; everyone else only sees contextual links inside Layout
  Builder. *(Empty by default.)*

## The layout‑swap flow (the headline feature)

This one needs no toggle — it's available structurally once the module is
enabled. When you open a section's **Configure section** form in Layout Builder,
you'll see a **Change layout** list offering every available layout. Pick a
different one and the module rebuilds the section with the new layout while
carrying over the section's existing blocks, settings, and third‑party settings,
reordering the components across the new layout's regions. No more deleting a
section and re‑placing all its blocks just to change from one column to two.

Developers can narrow which layouts appear in that Change layout list with the
`hook_layoutbuilder_extras_allowed_layouts_alter()` hook — see the
[`agent/`](../../agent/hooks/alter.md) docs for details.

## Section‑actions dialog

The module combines core's "Choose section" picker with Section Library's "From
library" picker (when the optional `section_library` module is enabled) into a
single off‑canvas "add section" dialog. If Section Library isn't installed, you
simply get core's "Choose section" on its own. When the icon‑only buttons are
turned on, the `+` add button opens this combined dialog.

## A note on access

Layout Builder Extras does not change who may edit a layout. Its custom routes
(the layout swap and the section‑actions dialog) use the same access check core
Layout Builder applies to its own section routes, and the settings permission
above only governs this cosmetic settings object — it grants no ability to edit
content or other configuration.
