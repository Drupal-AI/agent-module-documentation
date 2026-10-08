<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media OpenGraph provides a media entity type with metadata fetched from a link's OpenGraph tags.

---

Media OpenGraph provides a media type built from a link — fetching the target URL's OpenGraph metadata
(title, description, image) to create a rich media entity representing that link (a link preview/card). It
depends on core Media, in the Media package.

Use it to create link-preview media from OpenGraph tags. The module fetches the remote URL server-side to
read its OpenGraph metadata. It has no access-control role. Configure the OpenGraph media type.

---

- Create media from a link's OpenGraph tags.
- Fetch title/description/image metadata.
- Build link previews/cards.
- Depend on core Media.
- Fetch the remote URL server-side.
- Have no access-control role.
- Configure the OpenGraph media type.
- Build link cards.
- Handle OG metadata.
- Create link media.
- Fetch link previews.
- Configure the media type.
- Read OpenGraph tags.
- Handle remote fetch.
- Create previews.
- Fetch OG data.
