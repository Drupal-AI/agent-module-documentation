<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Render Context is a developer/API-only module: a single service (`entity_render_context.renderer`) that renders any entity to an HTML string under a fully controlled context — chosen theme, acting user account, language, and view mode — always restoring the original context afterwards.

---

The module exposes no UI, routes, permissions, or config; it is pure code. Its `EntityRenderContext`
service (`entity_render_context.renderer`, interface `EntityRenderContextInterface`) renders an entity
with `renderEntity($entity, $viewMode = 'full', $theme = NULL, $account = NULL, $langcode = NULL)` and a
bulk `renderEntities(array $entities, ...)`. Under the hood it uses core's `AccountSwitcher` to render
as the given user (default: anonymous), a `ThemeSwitcher` helper (`theme.manager` + `theme.initialization`)
to render in any installed theme, and — only when the core `language` module is enabled — a
`LanguageNegotiatorSwitcher`/`StaticLanguageNegotiator` pair to force a language. Rendering goes through
core `renderInIsolation()` (falling back to `renderPlain()` on older cores via `DeprecationHelper`).
Results are cached per request in a static keyed by
`{entity_type}:{id}:{revision}:{view_mode}:{langcode}:{theme}:{account_id}`, clearable with
`clearCache()`. Context (theme/user/language) is always restored via `finally`, even when a render throws;
errors are logged and the method returns `NULL` for that entity. Language services are wired optionally
(`@?entity_render_context.language_negotiator_switcher`) so the module works without the language module.

---

- Render a node to an HTML string from custom code with one service call.
- Render an entity as the anonymous user to get exactly what a visitor would see.
- Render an entity as a specific account to preview access-controlled output.
- Render an entity in a non-default theme (e.g. an email/admin theme).
- Render an entity in a specific language regardless of the current request language.
- Render an entity in a chosen view mode (teaser, full, or a custom mode).
- Bulk-render many entities in one call with `renderEntities()`.
- Build an HTML email body from a rendered node without leaking the admin theme.
- Generate a PDF/snapshot from entity HTML rendered in a print theme.
- Pre-render teasers for a search index using consistent context.
- Render content for a decoupled/JSON payload as anonymous, avoiding admin markup.
- Avoid manual theme/account/language switching boilerplate (and the bugs of forgetting to switch back).
- Guarantee context restoration even when a render throws, via the service's `finally` handling.
- Cache repeated renders of the same entity/context within a request for performance.
- Clear the render cache after a large bulk operation to free memory.
- Render a taxonomy term or user entity (non-node) with the same API.
- Produce previews of an entity in multiple themes side by side.
- Render content as a privileged user for a scheduled report generated on cron.
- Drop-in replacement for ad-hoc `entity_mesh`/`search_api` rendering patterns without their dependencies.
- Render entities for a Views field/preprocess where you need a specific view mode + language.
