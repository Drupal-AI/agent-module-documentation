<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Image Style URL provides a route to generate the chosen media in the chosen image style.

---

Media Image Style URL provides a **route that returns a media item's image in a chosen image style** — so
you can build a URL to get, say, a media entity rendered through the "thumbnail" or "large" image style,
useful for decoupled/front-end consumers or dynamic image links. It depends on core Image and Media, provides
its own permissions.

Use it to get style-processed media images by URL. It is a media/integration feature. Security note: the route
resolves a **media item + image style** — ensure the route respects **media access** (a user should only get
images for media they can view) and note the endpoint can trigger image-style derivative generation; its
permission gates who may use it. It has no broad access-control role beyond that permission. Configure/use the
media image-style route.

---

- Get a media image in a chosen style by URL.
- Provide an image-style route for media.
- Serve decoupled/front-end consumers.
- Depend on core Image and Media.
- Provide its own permissions.
- Build dynamic image links.
- Ensure the route respects media access.
- Note it can trigger derivative generation.
- Gate who may use the route.
- Have no broad access-control role.
- Use the media image-style route.
- Handle media image URLs.
- Return styled images.
- Configure the route.
- Get media images.
- Handle the route.
- Render media in a style.
- Provide image URLs.
- Restrict the route.
- Provide media style URLs.
