<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using Simple Icons in fields and Twig

## The field
`simple_icons_icon` is a `FieldItemBase` string field (max_length 255,
case-insensitive) with:
- widget `simple_icons_icon` — pick an icon,
- formatter `simple_icons_icon` (`SimpleIconsIcon`) — render it.

Add it like any field via Field UI to any fieldable entity, then set the
formatter on the entity's display.

## Twig usage
`simple_icons.twig.extension` registers `SimpleIconsTwigExtension`, and
`simple_icons.icon_markup` provides `IconMarkup` for building the markup. This
lets a theme print an icon by its Simple Icons slug directly in a template
without needing a field, e.g. inside a component or block template.

## Notes
- No configuration beyond field/display settings.
- Icons are emitted as SVG/markup; no external requests are required at render
  time.
