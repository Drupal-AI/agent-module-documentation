<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TOC Filter — agent index

Text-format filter (`toc_filter`, "Display a table of contents") that replaces a `[toc]` token
with a hierarchical table of contents built from `<h1>`–`<h6>` tags. Rendering is delegated to the
**TOC API** module (dependency). Also ships a "Table of contents" block. Adds a config schema, no
permissions, no Drush, no public plugin types.

- **Enable the filter, its settings, the `[toc]` token + inline options, the block** →
  [configure/filter.md](configure/filter.md)
- **Alter or suppress a generated TOC from your own module** →
  [hooks/toc-filter-alter.md](hooks/toc-filter-alter.md)

Key facts:
- Filter id `toc_filter`; settings keys `type`, `auto` (`''`|`top`|`bottom`), `block` (bool),
  `exclude_above` (bool). Stored in `filter.format.<id>` under `filters.toc_filter`.
- Token: `[toc]` with inline attributes, e.g. `[toc type="simple" title="Contents"]`.
- `configure` route is `entity.toc_type.list` (*Structure → Table of contents*), owned by TOC API;
  TOC **types** (Default/Simple/Full/…) are `toc_type` config entities from TOC API.
