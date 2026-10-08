<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Frontify Integration connects Drupal to the Frontify DAM platform, letting editors browse and use Frontify-hosted assets as Drupal media.

---

Frontify Integration connects Drupal's media system to Frontify, a digital-asset-management (DAM)
and brand platform. Editors can browse Frontify-hosted assets and use them within Drupal media,
keeping a single source of brand-approved images and assets in Frontify while referencing them from
content. It integrates with core Media, Media Library and Block Content, and configures the Frontify
connection at `frontify.admin_config_frontify`. It ships a `frontify_colorbox` submodule for lightbox
display.

Use it where an organisation manages assets centrally in Frontify and wants editors to pull from that
library rather than uploading locally. The connection uses Frontify credentials/API access, so store
those as secrets and scope them appropriately. It provides permissions for administering the Frontify
configuration. It governs asset sourcing and display, not content access.

---

- Use Frontify DAM assets in Drupal.
- Browse Frontify-hosted assets as media.
- Reference brand-approved assets from content.
- Integrate with core Media and Media Library.
- Configure the Frontify connection.
- Store Frontify credentials as secrets.
- Keep a single asset source in Frontify.
- Add a Frontify media source.
- Use frontify_colorbox for lightbox display.
- Administer Frontify config via permission.
- Pull images from the DAM.
- Avoid local re-uploads of brand assets.
- Scope Frontify API access appropriately.
- Depend on media, media_library, block_content.
- Embed Frontify assets in content.
- Manage assets centrally.
- Connect Drupal to Frontify.
- Govern asset sourcing, not access.
- Present Frontify assets in the media library.
- Handle Frontify authentication securely.
