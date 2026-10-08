<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image and Media Delta Formatter — agent index

Provides field formatters that render only **specific deltas** (positions) of a multi-value
image / responsive-image / media field. No config route, no settings form, no permissions, no
Drush. Persistent state is the formatter `type` + `settings.deltas` on a field component in an
`entity_view_display` config entity.

- **Which formatter id per field, the `deltas` / `deltas_reversed` settings, where stored,
  and the conditional (media / responsive_image) registration** →
  [configure/delta-formatters.md](configure/delta-formatters.md)

Key fact: on **Manage display** pick `image_delta_formatter` ("Image delta", image fields),
`responsive_image_delta_formatter` ("Responsive image delta", image fields, needs
`responsive_image`), or `media_delta_formatter` ("Media delta", media entity_reference fields,
needs `media`). Then set `settings.deltas` (e.g. `[0]` or `[0,2]`) and optional
`settings.deltas_reversed`. Only the listed deltas are rendered.
