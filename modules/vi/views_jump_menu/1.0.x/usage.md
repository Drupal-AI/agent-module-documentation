Views Jump Menu adds a Views display **style** plugin (id `jump_menu`) that renders view results as a single `<select>` dropdown; choosing an option navigates the browser to that row's URL.

---

The module provides one Views style plugin, `Jump Menu` (class `JumpMenu` extending `StylePluginBase`, theme `views_jump_menu`), selectable as the display **Format** on any view that uses the Fields row style. In the style options you pick a **Label field** (the text shown for each `<option>`) and a **URL field** (the destination), plus a wrapper class, a select-element class, a pre-selected placeholder text (default `-- Select --`), an ARIA label for accessibility, and an "open link in new window" toggle. At render time `template_preprocess_views_jump_menu()` renders both chosen field handlers per row, decodes the label to plain text, and resolves the URL — using `toUrl('canonical')` on the row entity when the URL field is an unaltered `EntityLink`, otherwise the field's rendered output. The `views_jump_menu/views-jump-menu` JS library attaches a `change` listener that reads the selected option's `data-url` and either sets `window.location` or calls `window.open(..., '_blank', 'noopener')` when new-window mode is on. Each menu gets a unique HTML id so multiple jump menus can coexist on one page with independent `drupalSettings`. The module has no admin settings form, no permissions, no services, and no Drush commands — all configuration lives in the view. An update hook (`views_jump_menu_update_8101`) backfills the `new_window` key into pre-existing jump-menu displays.

---

- Turn a view of nodes into a compact dropdown navigator instead of a long list of links.
- Let editors "jump" to any entity in a taxonomy/content list via a single select box.
- Provide a space-saving alternative to a table or grid for long result sets.
- Build a quick "go to page" chooser in a sidebar block from a view.
- Create a jump-to-section menu for a set of landing pages.
- Offer a mobile-friendly navigation control that collapses many links into one select.
- Redirect to an aliased canonical entity URL by choosing the Rendered/Entity link URL field.
- Link to external or altered URLs by using a rewritten field as the URL source.
- Open the chosen destination in a new browser tab via the "Open link in new window" option.
- Present a screen-reader-labelled dropdown by setting the Select label (ARIA) option.
- Show a custom placeholder prompt (e.g. "Choose a report…") via the Select text option.
- Style the dropdown with a custom class on the `<select>` element.
- Wrap the menu in a container with a custom wrapper class for theming/layout.
- Place multiple independent jump menus on the same page (each gets a unique id).
- Combine with exposed filters so users narrow the list, then jump to a result.
- Build an A–Z or archive selector from a sorted view of content.
- Use a view of users to jump to profile pages via a dropdown.
- Drive navigation from a view of menu-link or webform entities.
- Replace a manually maintained HTML `<select>` navigation with a data-driven view.
- Expose a category picker that routes to term pages.
- Add the style to any existing view display by switching its Format to Jump Menu.
- Override the dropdown markup by providing a `views-jump-menu.html.twig` template in your theme.
- Migrate legacy D7 "jump menu" navigations to Drupal 8/9/10/11 with a simple style plugin.
- Keep configuration entirely in exportable Views config (schema `views.style.jump_menu`).
