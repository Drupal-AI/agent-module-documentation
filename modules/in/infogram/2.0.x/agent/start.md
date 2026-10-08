<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Infogram graphs — agent index

Embeds **Infogram** charts/infographics via an **oEmbed media source** and a WYSIWYG **filter**. Version **2.0.3**. Core `^9 || ^10`.

- `infogram.module`: `hook_media_source_info_alter()` (oEmbed source) + `hook_oembed_resource_data_alter()` (thumbnail fetch, default TLS).
- `FilterInfogram` filter → `Infogram` service → `templates/infogram.html.twig` (autoescaped `data-` attrs).
- No routes/permissions. Security: escaped output, TLS-verified fetch to Infogram provider only. Sound.
