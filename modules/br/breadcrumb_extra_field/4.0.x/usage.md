Breadcrumb Extra Field exposes the site's breadcrumb as a display "extra field" on entities, so you can drag it into any position on an entity's Manage display — printing the breadcrumb *between* fields instead of only in the theme's fixed breadcrumb region.

---

The module adds a pseudo-field called **Breadcrumb** to the *Manage display* of selected entity
types/bundles via `hook_entity_extra_field_info()`. Which entity types and bundles get the
field is chosen on a single settings form (`/admin/config/system/breadcrumb-extra-field`,
permission *administer breadcrumb extra field*) that writes to
`breadcrumb_extra_field.settings:breadcrumb_extra_field_admin` — a nested map of
`entity_type → { bundle → bundle|0 }`. Once a bundle is enabled there, the "Breadcrumb" row
appears (hidden by default) on that bundle's display; drag it into the content region at the
weight you want. At render time `hook_entity_view()` checks whether the display has the
`breadcrumb` component and, if so, builds the output from Drupal's core `breadcrumb` service
(`\Drupal::service('breadcrumb')->build(...)`), so it uses the site's normal breadcrumb builder
and honours any breadcrumb alterations from other modules. It is themeable like any field. The
module has no field storage, no plugins, services, or Drush; it only needs core `system` and
`field`, and requires clearing/invalidating the `entity_field_info` cache after changing which
bundles are enabled (the form does this for you).

---

- Print the breadcrumb below the node title but above the body on an Article.
- Place the breadcrumb between two paragraphs/fields in a landing-page layout.
- Show the breadcrumb inside the rendered entity rather than the theme's header region.
- Enable the breadcrumb field only for specific content types (e.g. Article, not Basic page).
- Add the breadcrumb to a taxonomy term page's display at a custom position.
- Add the breadcrumb to a user profile display.
- Control the breadcrumb's weight/position per view mode via Manage display.
- Reuse the site's existing breadcrumb builder output (no separate breadcrumb logic).
- Respect breadcrumb changes made by other modules (it calls the core breadcrumb service).
- Theme the breadcrumb field independently from the header breadcrumb.
- Hide the breadcrumb field in some view modes and show it in others.
- Move the breadcrumb into the content column for a design that has no header breadcrumb.
- Enable breadcrumbs-as-field across several entity types from one settings screen.
- Give editors a breadcrumb they can reorder among fields without theme code.
- Add breadcrumb output to a media entity's display.
- Position the breadcrumb between a hero field and the main content.
- Turn the breadcrumb field on/off for a bundle by toggling one checkbox in settings.
- Keep breadcrumb markup consistent with the site default while relocating it.
- Restrict who can change which entities expose the field via the module's permission.
- Export the enabled-entities configuration for deployment (schema-backed).
