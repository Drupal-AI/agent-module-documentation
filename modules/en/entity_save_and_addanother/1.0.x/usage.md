Adds a "Save and Add Another" button to entity *add* forms so a content editor can save the current item and immediately land back on a fresh add form of the same type.

---

The module is pure `hook_form_FORM_ID_alter()` glue — it ships no config, no permissions, no schema, and no services. For each supported add form it clones the existing primary submit button into a new action `entity_save_and_addanother_<type>` labelled "Save and Add Another", removes any `destination` query parameter, and appends a submit handler that (after the normal save) redirects back to the current add path via `Url::fromUserInput($current_path)`. Supported forms are hard-coded: `node_form` (path contains `/node/add/`), `media_form` (`/media/add/`), `taxonomy_term_form` (`/admin/structure/taxonomy/manage/<vid>/add`), `menu_link_content_form` (`/admin/structure/menu/manage/<menu>/add`), `block_content_form` (`/block/add`), and `commerce_product_form` (`/product/add/`). The button only appears on the *add* route, not on edit, because each alter checks the current path. Because it reuses core's own submit button and access, it inherits the entity's create permission — no new access surface. It works for any bundle of those entity types without configuration; the redirect always returns to the same add URL (bundle preserved). There is nothing to configure and no admin UI.

---

- Speed up repetitive content entry by saving a node and returning straight to a blank node add form of the same content type.
- Bulk-create many media items in one sitting without navigating back to the add page each time.
- Rapidly enter a long list of taxonomy terms into the same vocabulary.
- Add several menu links to the same menu in succession.
- Create multiple custom (block content) blocks back-to-back.
- Add a batch of Commerce products of the same product type quickly.
- Give data-entry staff a lower-friction workflow when importing content by hand.
- Keep the editor on the same bundle's add form so they don't lose their place.
- Avoid the extra clicks of "Save" then re-opening *Content → Add content → <type>*.
- Provide a "save and continue" pattern familiar from other CMSes/admin frameworks.
- Reduce mis-clicks by preserving the bundle in the redirect URL automatically.
- Enable the button site-wide simply by installing the module (no per-form setup).
- Use alongside default entity permissions so only users who can create the entity see the button.
- Add the feature for editors without writing any custom form_alter code.
- Support onboarding sessions where many example terms/nodes are created quickly.
- Let catalogue managers add many products in a single focused session.
- Streamline creating repetitive event or listing nodes.
- Populate a new vocabulary with dozens of terms efficiently.
- Build out a navigation menu with many links quickly.
- Seed a demo site with content faster during setup.
