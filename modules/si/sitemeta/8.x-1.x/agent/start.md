<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Meta (sitemeta) — agent index

Sets a page's `<title>`, `<meta name="description">` and `<meta name="keywords">` from **`Site meta`
content entities** matched by **internal system path**, with **node/term token** support. Version
**8.x-1.7**. Core `^9.3 || ^10 || ^11`. Requires core **`token`**. No config form, no config schema.

## What it actually does
- **Storage**: a `sitemeta` **content entity** (`base_table: sitemeta`) with fields `path`, `name`
  (title), `description`, `keywords`, plus `user_id`, `langcode`, `created`, `changed`. Managed at
  `admin/content/sitemeta` (list / add / edit / delete) — see `src/Entity/SiteMeta.php`,
  `src/Form/SiteMetaForm.php`, `src/SiteMetaListBuilder.php`.
- **Emission**: `sitemeta_preprocess_html()` in `sitemeta.module` runs on every page. It resolves the
  current internal path + langcode via `SitemetaGenerator::getSiteMeta()`, then:
  - sets `head_title['title']` (replaces the default title),
  - appends a `description` meta tag to `#attached['html_head']`,
  - appends a `keywords` meta tag.
  Each value is passed through `\Drupal::token()->replace($value, $types, ['clear' => TRUE])` where
  `$types` holds the current `node` and/or `taxonomy_term`.
- **Matching** (`src/SitemetaGenerator.php`): (1) exact `path` + `langcode` `loadByProperties`; then
  (2) `wildcardCheck()` over rules whose `path` contains `%` — the substring before the first `%` is
  a prefix matched with `str_contains` against the internal path and its alias. **Quirk:** the loop
  has an unconditional `return FALSE` after the first iteration, so only the first wildcard rule is
  ever reliably considered. Treat exact per-path rules as the dependable mode.
- **Node form**: `sitemeta_form_node_form_alter()` adds a "Custom meta" details group (advanced
  sidebar) to node edit forms; its submit handler saves/updates a `sitemeta` entity for that node's
  `/node/{nid}` path. The path field is `#disabled` and forced to the node's own path (Drupal resets
  disabled values to the default, so it cannot be pointed at another path).

## Permissions (`sitemeta.permissions.yml`)
`administer site meta entities` (restrict access), `add site meta entities`, `edit site meta
entities`, `delete site meta entities`. Entity routes in `sitemeta.routing.yml` are each gated by the
matching permission.

## Output safety
Values are emitted through the render system: the title via Twig `safe_join`, and the meta `content`
as an `html_tag` attribute — both **attribute-escaped**, not printed raw. No `|raw`, no string
concatenation into `<head>`.

## Scope / limits — read before recommending
- **Only** title + description + keywords. **No** Open Graph, Twitter cards, canonical, robots, or
  Schema.org. `metatag` remains the comprehensive option; running both means two systems writing the
  same `<head>` with no arbitration (duplicate tags).
- No config form and **no config schema** (`provides_config_schema: false`); rules are content
  entities, not exported configuration.
- `composer.json`'s `description` is a copy-paste error (mentions SMTP email) — ignore it; the
  `.info.yml` description is authoritative.

## Docs in this set
- `../usage.md` — short / dense / use-case bullets.
- `config/site-meta-entities.md` — how to create and match a rule (fields, wildcard, tokens).
