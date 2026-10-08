<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Paragraphs (localgov_paragraphs) — agent index

The shared paragraph component library for the LocalGov Drupal distribution. It is almost entirely
**installed config**: five `paragraph` bundles (Text, Image, Link, Numbered text, Contact) with their
fields and default form/view displays. The only PHP is one role-defaults hook. No routes, no forms,
no settings page (`configure` null), no permissions of its own, no config schema, no Drush, no plugins.

Not a plain field module: `info.yml` pulls a full stack — core `field`, `link`, `options`, `taxonomy`,
`telephone`, `text`, `views`; contrib `address`, `entity_browser`, `entity_usage`, `field_group`,
`geolocation` (+ `geolocation_google_maps`, `geolocation_leaflet`), `office_hours`, `paragraphs`,
`paragraphs_library`; and LocalGov `localgov_core`, `localgov_media`, `localgov_topics`. So it only enables
inside (or alongside) a LocalGov site with those present. See [paragraphs](../../../../pa/paragraphs) and
[localgov_core](../../../localgov_core).

- **The paragraph types, their fields, widgets, formatters and the Contact tab layout** →
  [fields/paragraph-types.md](fields/paragraph-types.md)
- **Default paragraph-library permissions granted to LocalGov roles** → [hooks/roles.md](hooks/roles.md)

Key facts:
- Bundles (`paragraphs.paragraphs_type.*`): `localgov_text`, `localgov_image`, `localgov_link`,
  `localgov_numbered_text`, `localgov_contact`. Ordinary paragraph types — extend with Field UI.
- `localgov_contact` sets `paragraphs_library.allow_library_conversion: true` (reusable library items);
  its form display uses `field_group` vertical tabs.
- Fields of note: `localgov_contact_office_hours` (`office_hours`, multi), `localgov_contact_address`
  (`address`), `localgov_contact_location` (`geolocation`), `localgov_image` → media reference (`image`).
- Update hooks in `.install`: `_9002` forces Contact form to vertical tabs, `_9003` re-saves the
  office_hours field storage, `_9004` (re)installs the `localgov_numbered_text` type if missing.
- One hook: `localgov_paragraphs_localgov_roles_default()` grants `create/edit paragraph library item` and
  `view unpublished paragraphs` to Author/Contributor/Editor (only when `localgov_roles` — a soft dep — is on).
- Submodules ship the richer components and all JS/CSS (they have their own dependencies):

  | Submodule | Purpose |
  |---|---|
  | `localgov_paragraphs_layout` | Layout Paragraphs sections — 1/2/3/4-column layouts (`localgov_layout_*`) |
  | `localgov_paragraphs_views` | Embed a view as a component (`viewsreference`) |
  | `localgov_homepage_paragraphs` | Council-homepage components (newsroom teaser, labelled icon, IA block) |
  | `localgov_subsites_paragraphs` | Subsite page-builder set — accordion, tabs, quote, key facts, box links, media-with-text, table; the JS accordion/tabs behaviours live here |
