<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media standalone URL permission adds an `access standalone media url` permission requirement onto the core `entity.media.canonical` route so that the standalone `/media/{id}` page can be enabled without making it world-readable.
---
Enabling Drupal core's *standalone media URL* fixes a Linkit workflow (media links keep their entity/UUID metadata) but also makes `/media/123` publicly viewable. This module's `RouteSubscriber::alterRoutes()` re-adds a `_permission: 'access standalone media url'` requirement to the media canonical route, so only roles granted that permission can open the standalone page while Linkit continues to resolve media references correctly.

The permission is defined in `media_standalone_url_permission.permissions.yml` and applied via an event-subscriber route alter (no routes, forms or config of its own). Note this is a route-level access gate layered **on top of** normal media entity access — it only tightens the canonical URL. Setup: turn on standalone media URLs in the Media settings, enable this module, then grant `access standalone media url` to the roles that should reach `/media/{id}`.
---
- Enable standalone media URLs without exposing `/media/{id}` publicly.
- Fix Linkit media links that break without standalone media URLs.
- Grant `access standalone media url` to editor roles only.
- Keep the standalone media page hidden from anonymous users.
- Preserve Linkit entity/UUID metadata on re-edit of media links.
- Restrict media canonical pages while keeping media embeds working.
- Layer an extra permission gate over the core media canonical route.
- Allow trusted roles to preview media at its standalone URL.
- Combine with Linkit media profiles for correct direct-download URLs.
- Audit which roles can reach standalone media pages.
- Remove public access to `/media/{id}` after enabling standalone URLs.
- Support the core issue #3308515 workaround as a contrib module.
- Apply the gate site-wide via a route subscriber (no per-page config).
- Prevent leaking media metadata through the canonical media page.
- Give content teams standalone media previews without opening them to the public.
