<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Carousels gives a Varbase site a carousel **block type** (`varbase_carousel_block`), so an editor builds a carousel as a piece of block content — a list of image-media slides — and places it in any region. There is no settings form and no custom code; slides render through the Slick library using a shipped option set.

---

The module is pure configuration in the Varbase style. `config/install` defines the `varbase_carousel_block` block-content type, its unlimited-cardinality media reference field `field_media_carousel_slide` (limited to the `image` media type), a media-library edit widget on the form display, and a view display that renders the field with Slick's `slick_media` formatter bound to the `slick.optionset.varbase_carousel` option set (autoplay, center mode, three slides, responsive breakpoints at 480px and 766px). `config/optional` adds a `media.slick` view mode and turns on Slick's CSS. A `config/permissions` directory grants the block-content permissions to Varbase's `content_admin`, `site_admin`, and `seo_admin` roles at install. Its info-file dependencies are core plus `ctools:ctools_block`, `varbase_media:varbase_media`, and `slick:slick`; composer additionally pulls Vardot's `module-installer-factory` and `entity-definition-update-manager`, which the install/update hooks use to import config, apply entity-definition updates, and add the permission grants. The shipped view display also depends on the `ds` (Display Suite) module that the Varbase distribution supplies, so a bare non-Varbase site needs `ds` (and Varbase Media + Slick) present before enabling. Compared with the other carousels in this campaign, `varbase_heroslider_media` is the deprecated homepage-specific slider, `ebt_slideshow` is the FlexSlider block type from the Extra Block Types family, and `diba_carousel` is the standalone Bootstrap one — this is the general-purpose Varbase-native option.

---

- Let editors create a carousel as reusable block content.
- Place a carousel in any block region.
- Build a homepage slider without a developer.
- Reuse one carousel on several pages.
- Add slides from the Varbase media library.
- Give a campaign page a rotating banner.
- Manage carousels alongside other block content.
- Standardise carousel markup across a Varbase site.
- Show partner or client logos in a carousel.
- Create a testimonial slider.
- Control slide order from the block edit form.
- Export carousel configuration with the site's config.
- Add a carousel to a sidebar or footer.
- Tune autoplay, center mode, and slide count via the Slick option set.
- Adjust responsive behavior at the 480px and 766px breakpoints.
- Restrict who can create or edit carousels to admin/editor roles.
- Replace a hand-built jQuery slider with a configured block type.
- Add a product-highlights carousel.
- Provide a consistent slider component to a content team.
- Point a carousel's display at a different Slick option set.
