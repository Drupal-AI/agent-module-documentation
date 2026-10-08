<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Core is the required base feature of the Drutopia distribution: it declares the shared component dependencies and ships the site-wide default configuration (roles, media types, paragraph types, fields, image styles, view modes, taxonomy, pathauto and a search server) that every other Drutopia feature assumes is present.

---

It is a *feature* module, not a settings-driven module — it has no controllers, services, routes or permissions of its own, and no `src/` directory. Its two jobs are (1) declaring a large dependency set in `drutopia_core.info.yml` (core CKEditor 5, Media, Media Library, Image, Responsive Image, Taxonomy, plus contrib Crop, Automated Crop, Focal Point, Image Widget Crop, the media contextual-crop adapters, Display Suite, Exclude Node Title, FAQ Field, Metatag, Paragraphs, Pathauto, Search API + Search API DB, Video Embed Field and Config Perms), and (2) shipping ~155 files under `config/install/` plus five config-action files under `config/actions/` that build the distribution's baseline configuration. That baseline includes the site roles and their permission sets, five media types, seven paragraph types, node/media/paragraph field storages and instances, image styles and responsive image styles, crop types, entity view/form modes, two taxonomy vocabularies, pathauto URL patterns and a Search API database server. The only executable code is `drutopia_core.install`, whose update hooks (`_8101`–`_10201`) install newly added dependencies when a site is upgraded from an older Drutopia release. You normally never touch it directly: the Drutopia install profile enables it first so downstream features have their components and configuration in place.

---

- Bootstrap a Drutopia site with all shared base components and configuration.
- Establish the distribution's site roles (anonymous, authenticated, contributor, editor, manager, administrator) and their default permissions.
- Provide five media types out of the box: image, document, audio, video and remote video (oEmbed).
- Ship seven paragraph types (text, image, file, faq, slide, video, update) for structured content building.
- Install media + media library + responsive thumbnail support.
- Pull in crop, automated_crop, focal_point and image_widget_crop for image cropping, with square/wide/extra-wide crop types.
- Wire the media contextual-crop focal-point and IWC adapters.
- Provide a large set of drutopia_* and focal_point_* image styles plus responsive image styles (card, main, wide, narrow, short, square, tall).
- Provide Display Suite (ds) as a layout/display dependency.
- Ship Metatag as an SEO metadata dependency.
- Provide Pathauto with generic content and taxonomy-term URL alias patterns.
- Enable Search API + search_api_db and ship a "Database Server" search server.
- Add node view modes (box, card, tile, media, micro, search_index, simple_card, small_card) used across features.
- Provide two taxonomy vocabularies: Tags and Topics (with RDF mappings).
- Include FAQ Field and Video Embed Field content tooling.
- Provide `exclude_node_title` behaviour and the "use exclude node title" permission on roles.
- Depend on config_perms for permission-driven configuration (two custom-permission entities shipped).
- Guarantee CKEditor 5 and the media editing stack are present.
- Run update hooks that install newer dependencies automatically on version upgrade (`drush updatedb`).
- Serve as the required base for drutopia_article, drutopia_blog, drutopia_comment, drutopia_event and other features.
- Act as a single Composer/install unit for the distribution's core baseline.
- Keep the component and configuration baseline consistent across Drutopia sites.
- Support Drupal 10.2, 11 and 12.
