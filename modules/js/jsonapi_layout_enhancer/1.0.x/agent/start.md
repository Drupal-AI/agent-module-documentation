<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API layout enhancer — agent index

Adds a JSON:API **field enhancer** inlining Layout Builder `block_content`, plus an **alias→node JSON:API redirect** route. Version **1.0.0**. Core `^9.2 || ^10`.

- `LayoutBlockContentEnhancer` (`src/Plugin/jsonapi/FieldEnhancer/`) inlines block data via jsonapi_extras EntityToJsonApi.
- Route `/jsonapi/page/{langcode}/{alias}/{alias_2}` (`access content`) → **redirects** to `/jsonapi/node/{bundle}/{uuid}`; target JSON:API enforces access (no direct disclosure).
- Deps: layout_builder, jsonapi, jsonapi_extras.
