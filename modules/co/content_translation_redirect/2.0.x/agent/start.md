<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Translation Redirect — agent index

Redirects requests for a content entity in a **language it has not been translated into** to the
original content (or a chosen path) with a configurable HTTP status. Depends on
`content_translation`. Behaviour only fires on **multilingual** sites.

- **The `content_translation_redirect` config entity: ids, status codes, modes, path, the
  Default redirect, admin UI** → [configure/redirects.md](configure/redirects.md)
- **How the redirect happens: request subscriber, storage matching, manager, event** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config entity type **`content_translation_redirect`** (`config_prefix: entity`), config names
  **`content_translation_redirect.entity.<id>`**. Admin collection
  `/admin/config/regional/content-translation-redirect` (permission
  **`administer content translation redirects`**).
- Id scheme: **`default`** (locked, all types), **`<entity_type>`**, or
  **`<entity_type>__<bundle>`**. Exported keys: `id`, `label`, `code`, `path`, `mode`.
- `code` ∈ {300,301,302,303,304,305,307} or null (disabled). `mode` ∈
  {`translatable`, `untranslatable`, `all`}. `path` blank = redirect to original content.
- Ships a Default redirect (`content_translation_redirect.entity.default`, `code: null`,
  `mode: translatable`).
- Provides config schema; no Drush, no plugin types.
