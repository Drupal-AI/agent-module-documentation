<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Calaméo provides a Calaméo media source backed by the Calaméo API.

---

Media Entity Calaméo adds a **Media source for Calaméo** — the online document/publication platform — so a
Calaméo publication can be added as a Drupal media entity and embedded as a flipbook/document viewer. An
editor supplies a Calaméo **ID (shortcode)** or a full `calameo.com/read/…` URL; the module extracts the
shortcode, calls the Calaméo API (`API.getBookInfos`) to load publication metadata (title, pages, cover, etc.),
copies the cover thumbnail into `public://calameo-thumbnails/…`, and renders the embed with the `calameo_embed`
field formatter. It depends on core Media, provides its own permission (`administer media_entity_calameo
settings`), a `CalameoManager` service, and a settings page at `/admin/config/media/media_entity_calameo`, in
the Media package.

Set up: enter your Calaméo **API Key** and **API Secret Key** on the settings page (both required; a runtime
requirements error is shown until they are set), create a media type whose source is **Calaméo**, then on
**Manage display** set the source field format to **Calaméo embed** and configure mode / view / width / height.
Editors add publications from the media add form or the Media Library. The publication stays hosted by
**Calaméo** and is embedded (third-party content); media access follows core media/file access, with no
access-control role beyond the admin permission.

## Diff 1.0.x → 2.0.x (major bump — read before upgrading)

- **Core requirement narrowed:** `^10.6 || ^11` (was `^9.3 || ^10 || ^11`). Drupal 9 and Drupal 10 below 10.6
  are no longer supported — a hard BC break for those sites.
- **Calaméo API credentials are mandatory at runtime.** `hook_requirements` raises a `REQUIREMENT_ERROR` until
  both **API Key** and **API Secret Key** are configured; without them the source cannot fetch metadata. Sites
  upgrading must obtain and enter Calaméo API credentials.
- **New settings form / configure route** `media_entity_calameo.admin_form`
  (`/admin/config/media/media_entity_calameo`) with API credentials, global **mode** / **view** display
  options, and a **Force domain** toggle (`data_name` `configure` moves from null to this route).
- **New permission** `administer media_entity_calameo settings` (restrict access) gating that form.
- **New service** `media_entity_calameo.manager` (`CalameoManager` / `CalameoManagerInterface`) wrapping the
  Calaméo API call; new `calameo` media source metadata attributes (ID, Name, Pages, PosterUrl, PublicUrl, …).
- **Local thumbnails:** the publication cover (PosterUrl) is downloaded to `public://calameo-thumbnails/YYYY/MM/`
  (base folder configurable via `local_images`).
- **New `calameo_embed` formatter settings** (mode, view, width default 480, height default 640) plus a Media
  Library add form.
- **Config schema additions:** `api_key`, `api_secret`, `force_domain`, `mode`, `view`, `local_images`.
- Subcategories corrected to **Media sources / Media embedding** (the 1.0.x doc's "Embeds" is not a valid
  taxonomy value).

---

- Embed a Calaméo publication as a Drupal media entity.
- Add a Calaméo publication by its ID (shortcode).
- Add a Calaméo publication by pasting its full `calameo.com/read/…` URL.
- Let the module extract the shortcode automatically from a Calaméo URL.
- Render a Calaméo flipbook / document viewer via an `<iframe>` embed.
- Pull publication metadata (title, pages, cover) from the Calaméo API.
- Use the Calaméo publication title as the default media name.
- Store a local copy of the publication cover thumbnail.
- Configure Calaméo API Key and API Secret Key on the settings page.
- Set a global default display mode (Automatic / Viewer / Mini).
- Set a global default display view (Automatic / Book / Slide / Scroll).
- Override mode and view per field-formatter display.
- Set the embed iframe width and height per display.
- Enable **Force domain** to work around X-Frame / xframe-neterror embed issues.
- Add Calaméo items through the core Media Library.
- Create a media type whose source provider is Calaméo.
- Reference and reuse Calaméo publications like any other media.
- Restrict who can configure the module with a dedicated admin permission.
- Show a setup requirements error until API credentials are entered.
- Keep publications hosted on Calaméo while surfacing them in Drupal.
- Follow core media/file access for Calaméo media.
- Organise Calaméo thumbnails under a configurable public files folder.
- Log Calaméo API errors to the Drupal logger.
