<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor InfoCard — usage

CKEditor InfoCard adds an **InfoCard** button to CKEditor 5. An InfoCard is an
inline, accordion-style control: a short "hint" phrase that a site visitor clicks
(or focuses and presses Enter) to reveal a hidden block of explanatory content.
It is stored as a single `<span class="js-infoCard" data-content="…">hint</span>`
— no entity, block, or config is created.

## Enable the button on a text format

1. Install and enable the module (`drush en ckeditor_infocard`). It depends only on
   core's CKEditor 5.
2. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`) and configure a format that uses
   **CKEditor 5**.
3. Drag the **InfoCard** button from *Available buttons* into the *Active toolbar*.
4. If the format uses *Limit allowed HTML tags and correct faulty HTML*, allow the
   InfoCard markup — the `<span>` tag with the `class="js-infoCard"` class and the
   `data-content` attribute — so it is not stripped on save/output.
5. Save the format.

There is **no dedicated settings page**; configuration is entirely per text format.

## Authoring an InfoCard

- Select the text that should be the visible hint, click **InfoCard**, type the
  hint and its explanation in the balloon, and click **Save**.
- To edit, place the cursor inside an existing InfoCard and click the button again.
- To remove it, open the balloon and click **Remove**.

## How it renders for visitors

The module attaches its frontend library on every page. On load, its behavior
turns each `.js-infoCard` span into an expandable card: the hint is shown with a
chevron, and clicking it toggles the hidden explanation (taken from the
`data-content` attribute). Styling comes from `css/infocard.frontend.css` and can
be overridden by your theme.

## Notes

- Fork of *CKEditor Abbreviation*; minimally maintained, with the maintainer
  noting the WYSIWYG editing experience still has rough edges — test before
  relying on it in production.
- No permissions, config schema, services, or Drush commands are provided.
