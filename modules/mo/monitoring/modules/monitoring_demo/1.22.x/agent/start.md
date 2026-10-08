# Monitoring Demo — agent index

Demo/onboarding submodule (for simplytest.me). On install it seeds sample content, comments and a
Search API demo index, and adds a landing page, so Monitoring's sensors have data. Fixture — not for
production. Depends on `monitoring`, `node`, `comment`, `search_api`, `search_api_db`, `rest`,
`basic_auth`, `dblog`, `file`.

Key facts:
- `monitoring_demo_modules_installed()` creates demo nodes/comments and installs the
  `search_api.server.demo` / `search_api.index.demo` config.
- Landing page: route `monitoring_demo.front_page` → `/monitoring-demo`
  (`\Drupal\monitoring_demo\Controller\FrontPage::content`, permission `access content`).
- No config UI, permissions, services or plugins of its own.
- Parent module: `../../../1.22.x/agent/start.md`.
