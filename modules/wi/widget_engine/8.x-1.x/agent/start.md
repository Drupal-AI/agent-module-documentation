<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget Engine — agent index

Reusable **"widget" content system** — build content components (widgets) once and place them (structured
page building). Depends on `inline_entity_form`, core `node`, `path`, `text`, `image`. Submodules:
custom-page node type, domain-access, entity-form. Provides permissions. Version **8.x-1.6**. Core
`^9.3||>=10`.

Content-editing/site-building — widgets are authored content; access via permissions + entity access. If
using the domain-access submodule, verify widgets are scoped to intended domains.
