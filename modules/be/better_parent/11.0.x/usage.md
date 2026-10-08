Better Parent replaces the long, flat "Parent item" `<select>` in the node menu-settings section with a collapsible, browsable tree, making it easier to pick a parent menu link on sites with deep menus.

---

This is a tiny, front-end-only module: no config, no permissions, no PHP API, no dependencies beyond core `jquery`. Its single `hook_form_alter()` attaches the `better_parent/better_parent` asset library (a JS file `js/better_parent.menu.js` plus `css/better_parent.css`). The JavaScript looks for the core menu parent select (`#edit-menu-menu-parent`) on the page; if present, it adds a "(browse)" toggle link next to it that hides the native select and renders its `<option>` list as a nested, expandable/collapsible `<ul>` tree (indentation is inferred from the leading dashes core adds to nested option labels). Clicking a node in the tree selects the matching option and the toggle flips back to "(select)" to reveal the standard control again. Because it only progressively enhances an existing form element on the client side, there is nothing to configure — enabling the module is the entire setup. (Note: the form-alter attaches the library via the form's `scheduler_settings` key, so the enhancement effectively applies wherever that runs; the JS itself no-ops unless the `#edit-menu-menu-parent` select exists on the page.)

---

- Turn the flat menu "Parent item" dropdown into a browsable, collapsible tree.
- Make choosing a parent menu link easier on sites with large or deep menus.
- Expand and collapse menu branches to find the right parent quickly.
- Show the currently selected parent pre-expanded in the tree.
- Keep the native `<select>` available via a "(select)" toggle for accessibility/fallback.
- Enhance the node add/edit form's menu settings with no configuration.
- Improve editorial UX for menu placement without changing menu data.
- Preserve core behavior (the underlying select still holds the value).
- Provide a lightweight, dependency-free (jQuery only) menu-parent picker.
- Avoid scrolling through hundreds of indented options in a single dropdown.
- Give content editors a clearer view of the menu hierarchy while placing a page.
- Reduce mis-selection of the wrong parent in long menus.
- Drop-in enhancement: enabling the module is the whole setup.
- Fall back gracefully (does nothing) on forms without a menu parent select.
- Style the tree via the module's `better_parent.css`.
