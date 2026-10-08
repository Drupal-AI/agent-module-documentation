<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Clone Multiple — agent orientation

Admin tooling to clone entities multiple times, driven by `entity_clone_entity_setting` config entities.

- Version 1.1.x, core ^9.4||^10.
- Routes under `/admin/config/content/entity-clone` gated by `administer entity clone settings` (restricted); settings form by `administer site configuration`; delete via `_entity_access`.
- Dynamic permissions via `EntityCloneMultiplePermissions::entityClonePermissions`.
- No anonymous routes or unauthenticated mutation surface. Access looks sound.
