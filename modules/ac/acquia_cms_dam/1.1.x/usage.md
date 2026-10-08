Configuration-only glue module that wires Acquia DAM (Widen) asset media into an Acquia CMS / Acquia Drupal Starter Kit site.

---

Acquia CMS DAM is a thin, config-first companion to the `acquia_dam` contrib module. It does not talk to the DAM API itself and adds no routes, permissions, services, or PHP classes. Instead it ships opinionated default configuration for an Acquia CMS site: media view displays for the `acquia_dam_image_asset` and `acquia_dam_video_asset` media bundles across Acquia CMS image styles, a Site Studio (Cohesion) sync package plus content templates for rendering those DAM assets, and an install-time hook that updates Acquia CMS content-type image fields (article, event, page, person, place) so editors can pick DAM image assets in addition to local images. It also repoints the Site Studio image browser at DAM media types. All authentication, the media source plugin, embed formatters, and the actual Widen API integration come from `acquia_dam`; this module only glues that integration into the distribution's content model and theming.

---

- Add Acquia DAM image and video assets to an Acquia CMS site without hand-building media view displays.
- Ship ready-made `acquia_dam_image_asset` view displays for default, teaser, embedded, full, and Acquia CMS image styles (small, medium, large, landscape/super-landscape variants, x_small_square).
- Ship ready-made `acquia_dam_video_asset` view displays for embedded, full, and video_component modes.
- Let content authors reference DAM image assets from the standard Acquia CMS content types (article, event, page, person, place) image fields.
- Automatically extend each Acquia CMS content type's `field_<type>_image` to allow the `acquia_dam_image_asset` target bundle on install.
- Provide Site Studio (Cohesion) content templates for embedding DAM image and video assets in Site Studio layouts.
- Install a Cohesion sync package (`pack_acquia_cms_dam`) bundling all DAM-related templates for import/export across environments.
- Make the Site Studio image browser offer DAM image assets alongside local image media.
- Standardize how DAM assets render across an Acquia CMS site's view modes.
- Serve as the media-layer piece of the Acquia CMS distribution's DAM story.
- Keep DAM display configuration in code so it can be deployed via config management.
- Onboard a marketing team's centralized Widen asset library into Drupal editorial workflows.
- Reuse brand-approved DAM assets directly in article hero images and body embeds.
- Present DAM video assets through a dedicated video_component view mode in Site Studio components.
- Provide consistent embed styling (original embed style) for DAM image assets in the embedded view mode.
- Give a distribution-based site a turnkey DAM integration by enabling one module.
- Avoid manually adding the `acquia_dam_image_asset` bundle to every content type image field.
- Support digital asset governance by sourcing images from a DAM rather than local uploads.
- Bootstrap a DAM-enabled content model for a new Acquia CMS build.
- Flush caches automatically after applying DAM field/config changes so editors see the new options immediately.
- Act as an example of layering distribution-specific media configuration on top of a generic media-source module.
