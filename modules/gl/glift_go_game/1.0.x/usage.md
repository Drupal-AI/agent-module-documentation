<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Glift Go Game is a text-format filter that turns `[glift]...[/glift]` tags into an interactive Go (Weiqi/Baduk) board rendered by the bundled Glift JS library.
---
The filter plugin (`FilterGliftGoGame`, id `filter_glift`, TYPE_TRANSFORM_IRREVERSIBLE) uses a regex to find `[glift]ARGS[/glift]` blocks and replaces each with a `<div>` plus an inline `<script>` that calls `glift.create({...})`. A single argument is treated as raw SGF data or an SGF URL; multiple space-separated `key=value` arguments override defaults (`sgf`, `divId`, `theme`, `disableZoomForMobile`, `drawBoardCoords`). Each board gets a unique div id derived from an md4 hash of the arguments. The Glift library itself is bundled in `js/glift_1_1_2.min.js` and attached via the `glift_go_game/glift` library.

There are no routes, permissions, services, or config forms — you enable the filter on a text format and author `[glift]` tags in content. `glift_renderer()` builds the `<div>`, inline `<script>` and a download `<a href>` from the tag arguments. Because this is a text filter, only users permitted to use that text format can insert the tags.
---
- Enable the "Glift Go Game Filter" on a text format.
- Embed an SGF game by URL: `[glift]http://example.com/game.sgf[/glift]`.
- Embed raw SGF data inline within a node body.
- Set the board theme via a `theme=` argument.
- Toggle mobile zoom with `disableZoomForMobile=`.
- Show/hide board coordinates with `drawBoardCoords=`.
- Display multiple Go boards on one page.
- Offer a "Download SGF" link alongside each board.
- Publish game commentaries/tsumego on a Drupal site.
- Keep the Glift viewer self-hosted (bundled JS, no CDN).
- Restrict authoring of boards by controlling text-format permissions.
- Set a custom board height/width via the surrounding div styling.
- Reference SGF files hosted elsewhere by URL.
- Teach Go openings/joseki with interactive diagrams.
- Provide a fallback "enable JavaScript" message for no-JS visitors.