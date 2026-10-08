# layout_paragraphs_restrictions — agent start

Controls which Paragraph (component) types are **allowed or prohibited** inside
[Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs) layouts and regions.
Rules are authored as **YAML** in one admin settings form; enforcement is server-side via an
event subscriber plus a JS drag-and-drop guard. Depends only on `layout_paragraphs`. Config
schema present. No permissions of its own (settings form uses core `administer site configuration`).

- Write restriction rules (YAML format, contexts, allow/deny lists, settings form) → [configure/restrictions.md](configure/restrictions.md)
- How enforcement works + extend it (the allowed-types event, transform controller, JS) → [extend/api.md](extend/api.md)

Settings route: `layout_paragraphs_restrictions.settings` → `/admin/config/content/layout-paragraphs/restrictions`
(added as a "Restrictions" local task under Layout Paragraphs label settings).
