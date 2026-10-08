View Modes Inventory installs a ready-made inventory of node view modes — impressed, featured, text, overlay and hero cards at several sizes — and, when you enable one on a content type's display, auto-generates both a core view display and a matching Canvas SDC card content template with the node's title, media and body pre-wired.

---

Every project reinvents the same view modes: a card at several sizes, a text teaser, an overlay, a hero for a landing page. This module ships that vocabulary as configuration so a new site starts with a known set of displays instead of building each one by hand. On install it creates 17 node view modes across five card families — `impressed_card_*`, `featured_card_*` (xsmall→xlarge), `text_card_*` (small→large), `overlay_card_*` (medium→xlarge) and `hero_card`.

The operable part is the display-form alter. When you tick one of these view modes as a *custom display* on a content type's *Manage display* screen and save, `VmiHooks::entityViewDisplayEditFormSubmit` runs `ViewModesInventoryFactory::mapViewModeWithLayout()` for each newly-ticked mode. That method reads two per-mode templates in `src/assets/config_templates/CONTENT_TYPE_NAME/`, substitutes the bundle machine name, the site's default theme, and the bundle's resolved media/description field names, prunes any supported field the bundle does not have, and writes a full `core.entity_view_display.node.<bundle>.<mode>` **and** a `canvas.content_template.node.<bundle>.<mode>`.

The 5.0 major is a full re-platform onto **drupal/canvas** (Single Directory Components / the Experience Builder–style Canvas builder). The generated `canvas.content_template` binds the active theme's SDC card component (`sdc.<theme>.card`, `card-featured`, `card-impressed`, `card-overlay`, `card-text`, plus `heading`, `rich-text`, `date`, `image`) to the node's fields through Canvas dynamic-source expressions. This replaces the Display Suite / UI Patterns / Varbase Components stack that the 4.x line hard-depended on: the only declared dependencies now are `user` and `node` (info.yml) plus `drupal/canvas` (composer). It is Drupal 11 only — `core_version_requirement: ~11.4.0`.

Field wiring is now dynamic. `getMediaFieldName()` picks the first existing field from a candidate list (`field_featured_image`, `field_main_image`, `field_image`, `field_media`, `field_video`, `field_hero_image`, `field_banner_image`, `field_thumbnail`, `field_cover_image`, `field_photo`, `field_media_image`; default `field_featured_image`); `getDescriptionFieldName()` picks from `body`, `field_body`, `field_content`, `field_description` (default `field_description`). Missing fields are pruned by `filterConfigsForExistingFields()`. The module ships no config schema, no permissions, no Drush commands and no admin settings form; its whole surface is the install-time view modes plus the display-form auto-mapping.

---

- Start a site with a standard set of node card / teaser / hero view modes.
- Use a consistent card and teaser vocabulary across projects.
- Get impressed, featured, text, overlay and hero displays without building them.
- Provide several sizes (xsmall→xlarge) of the same card family.
- Auto-generate a display by ticking a view mode on Manage display and saving.
- Emit a matching Canvas `content_template` bound to the theme's SDC card component.
- Wire node title, media and body into the card via Canvas dynamic-source expressions.
- Auto-detect the bundle's media field from a candidate list (featured/main/image/media/…).
- Auto-detect the bundle's description field (body / field_body / field_content / field_description).
- Skip supported fields a content type does not have when generating the display.
- Give a component library (SDC card set) known view modes to target.
- Standardise displays across a team's sites and distributions.
- Reduce setup time on a new build.
- Align editors and developers on display names.
- Reuse the generated view modes in listings, references or Canvas pages.
- Seed a feature module's `config/install` from `src/assets/config_templates/CONTENT_TYPE_NAME/`.
- Audit which of the 17 view modes a site actually uses.
- Adopt the Canvas SDC card component set on a fresh Drupal 11 site.
- Generate the display for a bundle in code via the `vmi.factory` service.
- Remove unused view modes after adoption.
