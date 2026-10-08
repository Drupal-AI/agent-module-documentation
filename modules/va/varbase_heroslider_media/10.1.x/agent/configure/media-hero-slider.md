<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up / understanding the hero slider

There is **no settings form and no `configure` route**. The feature is a bundle of shipped config
delivered as a Drupal **recipe**, plus editorial workflow (create slides → add to a queue).

## Applying the feature (recipe)

Config lives in `recipes/default/` — **not** in `config/install`, so enabling the module alone
does **not** create the content type. `recipes/default/recipe.yml` declares the modules to install
(`node`, `field`, `media`, `image`, `entityqueue`, `rabbit_hole`, `slick`, `slick_views`, `ds`,
`varbase_media`, `varbase_heroslider_media`, …) and imports everything under
`recipes/default/config/`. Apply it with core's recipe runner, e.g.:

```bash
drush recipe web/modules/contrib/varbase_heroslider_media/recipes/default
```

(`hook_install()` in `varbase_heroslider_media.install` only enables the `install:` list from
`info.yml` via `Vardot\Installer\ModuleInstallerFactory::installList()` and runs
`EntityDefinitionUpdateManager::applyUpdates()`; it does not create the node type.)

## What the recipe creates

| Config | Machine name | Notes |
| --- | --- | --- |
| Content type | `node.type.varbase_heroslider_media` | label "Hero slider", `new_revision: true`, `preview_mode: 1`, `display_submitted: false` |
| Fields | `field_media_single`, `field_brief`, `field_link` | see [../fields/slide-fields.md](../fields/slide-fields.md) |
| Form display | `node.varbase_heroslider_media.default` | fields grouped by field_group into a **"Slide information"** fieldset; Maxlength + Length Indicator on title/text; Media Library widget for media |
| View display | `node.varbase_heroslider_media.default` | uses Display Suite (`ds`); media rendered via view mode `varbase_media_hero_slider` |
| View | `views.view.varbase_heroslider_media` | Slick style + block display (below) |
| Entityqueue | `entityqueue.entity_queue.varbase_heroslider_media` | ordering (below) |
| Slick optionset | `slick.optionset.varbase_slick` | carousel behaviour (below) |
| Rabbit Hole | `rabbit_hole.behavior_settings.node.varbase_heroslider_media` | slide-node redirect (below) |
| Media view mode | `core.entity_view_mode.media.varbase_media_hero_slider` | + media view displays for image/remote_video/video |
| Tour | `tour.tour.media_hero_slider_creation` | 4-step tour on the node-add form |

## Ordering: the Entityqueue

`entityqueue.entity_queue.varbase_heroslider_media` — handler `simple`, `act_as_queue: true`,
`min_size: 0`, `max_size: 6`, target `node:varbase_heroslider_media`. Editors add slide nodes to
this queue (the node-add form embeds the queue widget; the tour points at
`#edit-entityqueue-form-widget`). The view sorts and filters by this queue via an `entity_queue`
relationship (`limit_queue: varbase_heroslider_media`) and the `entity_queue_position` sort — so
**queue order = slide order**, and only queued, published slides appear.

## Display: the view & its block

`views.view.varbase_heroslider_media` (base table `node_field_data`):
- **Style** `slick`, `optionset: varbase_slick`, `vanilla: true`, `current_view_mode:
  varbase_heroslider_media`.
- **Row** `ds_entity:node` (Display Suite), view mode `default`.
- **Filters** published (`status = 1`) + bundle `varbase_heroslider_media`.
- **Access** `perm: 'access content'` (standard published-content access).
- **Displays**: `default` (Master) + a **block** display `varbase_heroslider_media` — place that
  block (e.g. in the homepage/hero region) to render the slider.
- Empty text (admin-authored, `full_html`) shows an "Add One Now" link to
  `node/add/varbase_heroslider_media`.

## Carousel behaviour: the Slick optionset

`slick.optionset.varbase_slick` key `options.settings` — notable defaults: `autoplay: true`,
`autoplaySpeed: 5000`, `fade: true`, `infinite: true`, `arrows: true`, `dots: false`,
`slidesToShow: 1`, `speed: 500`, `pauseOnHover: true`, `lazyLoad: ondemand`, `mobileFirst: true`.
Edit this optionset (Slick UI or config) to change transition/autoplay behaviour.

## Slide-node URLs: Rabbit Hole

`rabbit_hole.behavior_settings.node.varbase_heroslider_media` — `action: page_redirect`,
`redirect: '<front>'`, `redirect_code: 301`, `no_bypass: false`. Visiting an individual slide node
301-redirects to the front page, so slides are not reachable as standalone pages.

## Requirement: the Slick JS library

`hook_requirements` (`includes/helpers.inc`) hard-fails install if
`/libraries/slick/slick/slick.js` (or the same path under the install profile) is absent. Install
the Slick carousel library (npm-asset `slick-carousel`) into `/libraries/slick`.
