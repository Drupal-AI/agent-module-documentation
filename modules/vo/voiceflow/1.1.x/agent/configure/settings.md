<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Voiceflow — configuration

## Base module: `voiceflow.settings`
Form at `/admin/config/system/voiceflow` (`administer site configuration`).

| Key | Default | Meaning |
|---|---|---|
| `enable_voiceflow` | `false` | Master switch for attaching the widget |
| `project_id` | `''` | Voiceflow project ID passed to `drupalSettings` |
| `exclude_paths` | `/admin`, `/admin/*`, `/batch`, `/node/add*`, `/node/*/*`, `/user/*/*` | Newline-separated path patterns where the widget is suppressed |

`voiceflow_page_attachments()` resolves the current path alias, and if `enable_voiceflow` is on and no exclude pattern matches (via `path.matcher`), attaches the `voiceflow/voiceflow` library and sets `drupalSettings.voiceflow.project_id`.

## Submodule `voiceflow_index`
- Settings form `/admin/config/system/voiceflow/index` (`administer site configuration`).
- Adds a per-node **Voiceflow index** flag (field `voiceflow_index`).
- Route `voiceflow_index.xml` → `/voiceflow.xml`, `_access: 'TRUE'` (public).

### `/voiceflow.xml` feed
`VoiceflowIndexController::generateIndex()` runs an entity query with `status = 1` AND `voiceflow_index = 1` AND `accessCheck(TRUE)`, then emits a `urlset` XML document with, per published translation: `<loc>` canonical absolute URL, `<link rel="alternate" hreflang>` for each translation, and `<lastmod>`. It is a read-only, sitemap-style public feed of already-public content — no private data is exposed.
