Smart Title turns a content entity's label (e.g. the node title) into a configurable pseudo-field on the *Manage display* form, so you can hide it, reposition it among other fields, wrap it in a chosen HTML tag with CSS classes, and optionally link it to the entity — per entity type, per bundle, and per view mode.

---

Normally an entity's label is rendered by the theme template, not the view display, so site builders cannot move or restyle it without custom code. Smart Title fixes this by exposing the label as an extra field named `smart_title`. First a bundle is opted in (its `entity_type:bundle` string is added to the `smart_title.settings` config, usually via the Smart Title UI submodule). Then, on each view mode's *Manage display* form, a *Smart Title* section offers a "Make entity title configurable" checkbox; ticking it stores `enabled: true` as a third-party setting on that `entity_view_display` config entity and makes the `smart_title` extra field draggable like any other field. When rendered, `hook_entity_view()` builds the label into `$build['smart_title']`, and a preprocess hook suppresses the theme's original title so it is not printed twice. The element's format settings — HTML tag (`h1`–`h6`, `div`, `span`), CSS classes, and whether to link to the entity — are stored under `third_party_settings.smart_title.settings` (`smart_title__tag`, `smart_title__classes`, `smart_title__link`) and rendered through the `smart-title.html.twig` wrapper. Because everything is driven by the view display config, choices are per view mode and export cleanly. The optional Smart Title UI submodule adds the admin page that toggles which bundles are eligible; the core module is all that a production site needs once configured.

---

- Hide the node title on the teaser view mode while keeping it on the full page.
- Move the title so it renders *after* an image field in a card layout.
- Wrap the title in an `h1` on the full view and an `h3` on teasers.
- Add custom CSS classes to the title markup for styling without a template override.
- Render the title as a plain (unlinked) heading on the canonical page but linked in listings.
- Reposition the label within a Field Layout region.
- Give each view mode of a content type a different title presentation.
- Show a configurable label on custom entity types that expose a *Manage display* form.
- Turn a taxonomy term or media entity name into a movable, styleable field.
- Suppress a duplicate title on nodes rendered inside a paragraph or block.
- Present the title as a `span` inline with other metadata.
- Standardize heading levels for accessibility across content types.
- Link the title to the entity in a listing view mode while unlinking it on the detail page.
- Restyle the article title without editing `node.html.twig`.
- Export title-display choices as config so they deploy across environments.
- Let site builders control title markup without front-end/theme access.
- Combine with Layout Builder-free displays to keep the label editable per view mode.
- Drop the title entirely from a "minimal" view mode used in aggregations.
- Apply consistent title classes site-wide via the CSS classes setting.
- Toggle the title's link on/off depending on context.
- Reorder title relative to fields that the theme would otherwise force above it.
- Use `div`/`span` wrappers when a heading tag is semantically wrong for the context.
- Enable Smart Title only for the specific bundles that need it, leaving others untouched.
- Prepare a clean uninstall path (removing the smart_title component from all displays) via the module's uninstall hook.
