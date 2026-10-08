<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View Modes Inventory installs a ready-made inventory of node view modes — impressed, featured, text, overlay and hero cards at several sizes — and, when you enable one on a content type's display, auto-wires it to a matching Display Suite / UI Patterns card layout with fields pre-placed.

---

Every project reinvents the same view modes: a card at several sizes, a text teaser, an overlay, a hero for a landing page. This module ships that vocabulary as configuration so a new site starts with a known set of displays instead of building each one by hand. On install it creates 17 node view modes across five families — `impressed_card_*`, `featured_card_*` (xsmall→xlarge), `text_card_*` (small→large), `overlay_card_*` (medium→xlarge) and `hero_card`.

The operable part is the form alter. When you tick one of these view modes as a custom display on a content type's *Manage display* screen and save, `vmi_form_entity_view_display_edit_form_alter` runs `ViewModesInventoryFactory::mapViewModeWithLayout()`: it reads a per-mode template in `src/assets/config_templates/`, substitutes the bundle machine name and the site's default theme, filters out any of the supported fields (`field_image`, `field_video`, `field_media`, `body`) that the bundle does not actually have, and writes a complete `core.entity_view_display.node.<bundle>.<mode>` config — DS regions, a UI Patterns card component, `node_title`, and a `smart_trim` body.

The layouts come from `varbase_components` via UI Patterns (`ui_patterns:<theme>:card_impressed|card_featured|card_text|card_overlay|card_hero`), which is why 4.0 hard-depends on it. That is the meaning of the dependency list: DS + `ds_extras` for the layout plumbing, `field_group` for grouping, `smart_trim` for truncated teaser body, and `varbase_components` for the card patterns. Adopting the inventory means adopting that stack.

**This is the 4.0 new major and it is Drupal 11 only** — `core_version_requirement: ~11.4.0`, a single pinned minor (distribution-style, arriving with Varbase). It drops the Drupal 10 support the 1.x line carried and adds the hard `varbase_components` dependency. Note the module ships no config schema, no permissions, no Drush commands and no admin settings form; its whole surface is the install-time view modes plus the display-form auto-mapping.

---

- Start a site with a standard set of node card / teaser / hero view modes.
- Use a consistent card and teaser vocabulary across projects.
- Get impressed, featured, text, overlay and hero displays without building them.
- Provide several sizes (xsmall→xlarge) of the same card family.
- Auto-configure a Display Suite / UI Patterns card layout by ticking a view mode on Manage display.
- Pre-place `node_title`, body and media fields into DS regions automatically.
- Truncate teaser body text with smart_trim (300-word trim by default).
- Skip media/body fields a content type does not have when generating the display.
- Give a component library known view modes to target.
- Standardise displays across a team's sites and distributions.
- Reduce setup time on a new build.
- Align editors and developers on display names.
- Reuse the generated view modes in Layout Builder or listings.
- Seed a feature module's `config/install` from `src/assets/config_templates/CONTENT_TYPE_NAME/`.
- Audit which of the 17 view modes a site actually uses.
- Standardise media aspect-ratio view modes (media_21_09) across cards.
- Adopt the Varbase card component set on a non-Varbase site.
- Remove unused view modes after adoption.
