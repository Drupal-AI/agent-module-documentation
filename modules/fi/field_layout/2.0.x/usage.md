Field Layout adds a per-view-mode layout selector to entity "Manage display" and "Manage form display" screens, so configurable fields can be arranged into the regions of a Layout Discovery layout plugin (e.g. two- or three-column layouts) instead of a single flat list.

---

Field Layout swaps core's `EntityViewDisplay` and `EntityFormDisplay` entity classes for enhanced subclasses that carry a layout plugin ID and its settings as third-party config on each display. On the Field UI display and form-display edit forms it injects a "Layout settings" fieldset with a layout `<select>` (AJAX-refreshed) plus any configuration form the chosen layout plugin exposes; each field's Region column then lists that layout's regions. At render time it groups fields into their assigned regions and wraps them with the layout plugin's own template — for view displays it moves the fields into a `_field_layout` render section, and for forms it uses `#group` so field structure (and `hook_form_alter`) is preserved. It depends only on core's `layout_discovery` module and works with any discovered layout, including those from core, contrib, or a theme. It is the contrib continuation of the former experimental core module; on sites where Layout Builder is enabled, install-time logic converts existing field-layout displays into Layout Builder sections. There are no routes, permissions, services, or Drush commands of its own.

---

- Arrange node fields into a two-column layout on the default view display.
- Give the article "teaser" view mode a different multi-region layout than the full view.
- Lay out user-profile fields into columns on the user view display.
- Reorganize the node edit form into regions on the "Manage form display" screen.
- Use a core Layout Discovery layout (one/two/three column) to structure any entity's display.
- Apply a custom layout plugin defined by a contrib module to an entity display.
- Apply a theme-provided layout to a content type's field display so markup matches the theme.
- Move a field into a specific region by choosing that region in the field's Region dropdown.
- Configure a layout plugin's own settings (such as extra CSS classes) directly from Manage display.
- Set distinct layouts per view mode (full, teaser, RSS) for the same bundle.
- Structure taxonomy-term display fields into regions.
- Structure media-entity display fields into a chosen layout.
- Structure comment display fields into regions.
- Keep the one-column layout as an unobtrusive default on displays that need no columns.
- Migrate a Drupal 8 site that used the experimental core Field Layout to Drupal 9+ via this contrib module.
- Transition field-layout displays into Layout Builder by enabling the `layout_builder` module (auto-conversion on install).
- Export field-layout choices as configuration (stored under each display's `third_party_settings.field_layout`) for deployment.
- Build region-based displays without needing the full per-entity override power of Layout Builder.
- Programmatically set a display's layout via `setLayoutId()` / `setLayout()` on the display entity in an update hook or install code.
- Read a display's current layout with `getLayoutId()` / `getLayoutSettings()` when writing display-aware code.
- Ensure every display has a layout after install (the module backfills `layout_onecol` on all displays).
- Provide a consistent columned form layout for editors across multiple content types.
- Reset displays to a plain one-column arrangement by uninstalling the module (it rewrites displays to `layout_onecol`).
