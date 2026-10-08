<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Add Content by Bundle provides a Views area handler (`add_content_by_bundle`) that renders a "add content" link/button in a view's header or footer, pointing directly at the add-form for a chosen bundle (content type, vocabulary, ECK type, or group content).

---

The module improves on core's empty-area "add content" behavior for views that list a narrow set of bundles. You add the **Add Content by Bundle link** area to a display's header or footer, then configure which entity type and bundle the link targets, its label, CSS classes (defaulting to `button button--action button--primary`), and optional dialog behavior. The single area plugin (`Drupal\add_content_by_bundle\Plugin\views\area\AddContentByBundle`) resolves the correct add route per entity type: `node.add` for nodes, `entity.taxonomy_term.add_form` for terms, `eck.entity.add` for ECK entities, and the entity's `add-form`/`add-page` link template otherwise. It performs an access check with the access manager, so the link only shows to users who can create that bundle. Optional features include opening the form in a modal or off-canvas tray (with a configurable width), appending extra query parameters (with Views argument token support like `{{ arguments.user_id }}`), redirecting anonymous users to the login page instead of hiding the link, integrating with the Group module to create group content, and using the Form Mode Control module to pick a specific form mode. It defines no configuration UI, permissions, services beyond the views-data hook, or Drush commands; all state lives inside the view's configuration.

---

- Add a "Add article" button to the footer of an article listing view.
- Give editors a one-click link to create the exact content type a view displays.
- Render the add link as a Drupal button by keeping the default `button button--action button--primary` classes.
- Open the node add form in a modal dialog directly over the view.
- Open the add form in an off-canvas (off-screen) tray instead of a full page.
- Set a custom dialog width in pixels for the modal/tray.
- Add multiple add-content buttons to one view, one per content type shown.
- Link to add a taxonomy term of a specific vocabulary from a term listing view.
- Link to add an ECK entity of a specific bundle.
- Link to the add-form of any custom content entity that declares an `add-form`/`add-page` link.
- Show the link even when the view returns no results (empty behavior).
- Hide the link automatically from users who lack "create" access for that bundle.
- Redirect anonymous users to the login page ("Login to add your …") instead of showing nothing.
- Suppress the `destination` query parameter so the user is not returned to the view after saving.
- Pass extra query parameters to the add form (e.g. prepopulate values) via the params textarea.
- Use Views argument tokens (e.g. `{{ arguments.user_id }}`) inside those extra parameters.
- Create Group content by linking to `entity.group_relationship.create_form` when the Group module is installed.
- Choose a specific entity form mode for the add form when Form Mode Control is installed.
- Provide contextual editorial "add" links on dashboards built from views.
- Replace core's generic empty-text add link with a bundle-targeted, styleable button.
- Add a "Create event" call-to-action to a calendar/events view header.
- Localize/customize the link label per display.
- Keep site maintenance intuitive by surfacing add links in the context where content is listed.
- Combine a modal add form with a view so editors never leave the listing page.
