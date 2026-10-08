# Captcha Riddler — agent index

Adds a **Riddler** challenge type to the CAPTCHA module: site-defined question/answer riddles.
Riddles are **`riddle` config entities** (`riddler.riddle.<id>`). Depends on `captcha`. No configure
route of its own (`configure: null`); riddles are managed at
`/admin/config/people/captcha/riddler-riddle` and the challenge is attached via CAPTCHA points.
Admin gated by CAPTCHA's `administer CAPTCHA settings` permission.

- **Create/manage riddles, entity fields, routes, multiple answers, caching caveat, wiring to a
  CAPTCHA point, and the validation mechanism** → [configure/riddles.md](configure/riddles.md)

Key facts: each riddle has `question`, `solution` (comma-separated allowed answers), `hint`,
`status`. Answer matching honours `captcha.settings: default_validation` (case sensitivity). With
**>1** enabled riddle, page cache is disabled on protected forms; with exactly one it stays
cacheable. No plugin types, no Drush.
