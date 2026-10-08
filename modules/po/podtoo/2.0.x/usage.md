<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity PodToo registers an oEmbed media source (`oembed:podtoo`) so editors can embed PodToo podcast/audio content as standard Drupal media entities.
---
The module reuses core's oEmbed video source machinery but points it at PodToo's oEmbed API. A decorated provider repository (`Drupal\podtoo\ProviderRepository`, replacing `media.oembed.provider_repository`) hard-codes the provider endpoint `https://embed.podtoo.com/api/oEmbed` and the accepted URL schemes `https://embed.podtoo.com/*` and `https://podcasts.podtoo.com/*` — there is no discovery of arbitrary providers, so the fetch target is fixed. A custom resource fetcher (`PodTooResourceFetcher`) appends site-wide display options (color, compact) to the request.

Site-wide options live at `/admin/config/media/podtoo` behind the `administer site configuration` permission. Note the settings form can also be told to forward the current user's username, email and/or uid to the PodToo endpoint as query parameters (see `PodTooResourceFetcher::fetchResource`, podtoo/src/PodTooResourceFetcher.php:31-48) — that is an admin opt-in privacy consideration, not a default. Creating/editing/deleting PodToo media follows the normal per-media-type Drupal permission model.

Typical setup: enable the module, configure display size/colour, add a Media field (or use the Media Library) that allows the PodToo media type, then paste a PodToo embed URL.
---
- Enable the module to register the `oembed:podtoo` media source.
- Create a PodToo media type mapped to the source.
- Embed a `https://embed.podtoo.com/*` URL as media.
- Embed a `https://podcasts.podtoo.com/*` URL as media.
- Add PodToo media through the Media Library.
- Insert PodToo audio via a CKEditor media embed.
- Add a dedicated PodToo media reference field to a content type.
- Set a site-wide player background colour at `/admin/config/media/podtoo`.
- Switch the player to compact display mode.
- Optionally forward the viewing user's username to PodToo.
- Optionally forward the user's email to PodToo.
- Optionally forward the user's uid to PodToo.
- Grant media create/edit/delete permissions per role.
- Restrict site-wide config to trusted admins.
- Display PodToo media in a view.
- Use PodToo thumbnails generated from oEmbed metadata.
