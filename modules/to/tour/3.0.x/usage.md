Tour displays guided, step-by-step tooltip tours of the site interface, driven by `tour` config entities whose tips are pinned to page routes and DOM selectors.

---

Tour is the contrib successor to Drupal core's Tour module (core Tour is deprecated/removed for D11+); this project provides the same capability as a maintained contrib module for Drupal 11.3+/12. Each tour is a `tour` **config entity** that lists the **routes** it should appear on (e.g. `entity.node.add_form`, `entity.taxonomy_term.edit_form`, `<front>`, with optional route parameters like node id, bundle, or taxonomy vocabulary) and an ordered, weighted list of **tips**. Tips are plugins of the `tour_tip` plugin type (namespace `Plugin/tour/tip`, discovered via the `#[Tip]` attribute); the module ships one tip plugin, `text`, and each tip carries a label, body, a CSS/DOM `selector` to attach to, and a Popper.js `position`. When a user with the **`access tour`** permission visits a matching route, a Tour button appears in the toolbar (or via the `tour_button_block` block / navigation top-bar item), and clicking it walks them through the tips using the Shepherd.js library; the `?tour` URL parameter or the `alt+t` hotkey also triggers it. Tours can be defined in a module's `config/optional` folder (`tour.tour.<id>.yml`) or authored in the admin UI at **Admin → Configuration → User interface → Tours** (`/admin/config/user-interface/tour`), where you can add, clone, enable/disable, and delete tours and their tips. Global behavior lives in the `tour.settings` config object (custom button labels, hiding the button when no tour is available, and an optional tour "recap" page). Developers can alter tips, tip plugin definitions, or the final build via `hook_tour_tips_alter()`, `hook_tour_tips_info_alter()`, and `hook_tour_build_alter()`. The bundled **tourauto** submodule auto-opens tours for users who have not yet seen them.

---

- Give first-time editors a guided walkthrough of the node add/edit form.
- Explain the fields on a custom content type the moment an author opens its form.
- Point out UI controls on an admin configuration page with anchored tooltips.
- Onboard new site administrators to the modules/permissions/config pages.
- Attach a tour to the front page (`<front>` route) for a public product tour.
- Target a specific node, bundle, or taxonomy vocabulary via route parameters.
- Highlight a specific button or region using a CSS selector and Popper position.
- Ship tours with a custom module by dropping `tour.tour.<id>.yml` into `config/optional`.
- Author and edit tours entirely in the admin UI without writing YAML.
- Clone an existing tour as a starting point for a similar page.
- Enable or disable a tour without deleting it (AJAX toggle in the list).
- Order tip steps with weights so the walkthrough flows logically.
- Let users replay a tour any time via the toolbar Tour button.
- Trigger a tour on demand with the `?tour` URL parameter or the `alt+t` hotkey.
- Place a Tour launch button anywhere on the page with the `tour_button_block` block.
- Show a Tour item in the Navigation top bar (with the Navigation module).
- Restrict who can see tours with the `access tour` permission.
- Customize the toolbar button labels for available vs. unavailable tours.
- Hide the Tour button entirely on pages that have no tour.
- Offer a "recap" page listing a tour's steps as static text (enable_recap).
- Write a custom tip plugin type (e.g. video or formatted-text tips) via the `tour_tip` plugin.
- Alter an existing tour's tip bodies programmatically with `hook_tour_tips_alter()`.
- Swap the class behind the `text` tip plugin with `hook_tour_tips_info_alter()`.
- Attach extra libraries or styling to every rendered tour with `hook_tour_build_alter()`.
- Auto-start tours for users who have not seen them yet (tourauto submodule).
- Migrate off deprecated core Tour to the maintained contrib Tour for D11/D12.
- Provide multilingual tours (tour config entities support config translation).
