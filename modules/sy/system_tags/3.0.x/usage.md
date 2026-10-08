System Tags bridges content and code: you tag an entity (via a reference field to the `system_tag` config entity) with a stable machine name like `homepage`, then look it up in code, Twig, tokens, or block visibility conditions without hard-coding the entity's ID.

---

The module defines a `system_tag` config entity (managed at `/admin/structure/system_tags`, route
`entity.system_tag.collection`) and ships three default tags: `homepage`, `access_denied`,
`page_not_found`. You add an `entity_reference` field targeting `system_tag` to any bundle, then mark
entities with a tag. A pluggable `SystemTagFinder` plugin type (managed by
`plugin.manager.system_tags.system_tag_finder_manager`, one plugin per entity type — `node` and
`block_content` ship built in) resolves "the entity tagged X" by querying every reference field that
points at `system_tag`; queries run with access checks, published-status filtering, and language
fallback, newest-changed first. A `SystemPageConfigOverrider` (a `config.factory.override`) reads the
three special tags and overrides `system.site` so the tagged nodes become the site's front page, 403,
and 404 pages. A Twig function `system_tag_url(tagId, entityType='node', options)` returns the tagged
entity's URL; per-entity-type tokens `[system_tags:ENTITYTYPE--TAGID]` return its (aliased) path; and a
`system_tags` block-visibility Condition matches when the current route's entity carries a selected
tag. Three permissions gate administering, viewing, and assigning tags, enforced on the entity and on
system-tag reference fields via `hook_entity_field_access`. The optional `system_tags_theme` submodule
adds `node--system-tag--<tag>` template suggestions (and body classes) for tagged nodes. No Drush.

---

- Mark a node as the site's homepage by tagging it `homepage` (no need to set a front-page path).
- Designate custom 404 and 403 pages by tagging nodes `page_not_found` / `access_denied`.
- Reference "the news overview page" in code by tag instead of storing its node ID in config.
- Build a Pathauto pattern that prefixes article aliases with the overview page's alias via a token.
- Link to a tagged page from a Twig template with `system_tag_url('homepage')`.
- Print the URL of the tagged contact page in a footer template regardless of its node ID.
- Show a sidebar block only on the page tagged "News overview" using the System Tags condition.
- Tag a custom block (`block_content`) and resolve it by tag in code.
- Keep environment-portable references to key pages across dev/stage/prod (tags, not IDs).
- Add a `system_tag` reference field to multiple content types and query across them by one tag.
- Get the most recently changed node bearing a tag (finder sorts by `changed` DESC).
- Resolve tags in a specific language with translation fallback for multilingual sites.
- Create your own tags (e.g. `terms_of_service`, `search_page`) for app-specific landmark pages.
- Restrict who can assign tags to content with the "assign system tags" permission.
- Restrict who can see tag references with the "view system tags" permission.
- Provide theme overrides per tag (`node--system-tag--homepage.html.twig`) via the theme submodule.
- Add body classes for the current node's tags for CSS targeting (theme submodule).
- Implement a `SystemTagFinder` plugin for a new entity type (e.g. `media`, `taxonomy_term`).
- Swap which node is the homepage by moving the `homepage` tag, with no config export needed.
- Use tokens in emails or metatags that resolve to a tagged landmark page's path.
- Centralize "well-known pages" so integrations and code never break on content re-creation.
