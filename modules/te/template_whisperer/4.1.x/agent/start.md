<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Template Whisperer (template_whisperer) — agent index

Editors pick a named **suggestion** from a field on an entity; the module turns that choice into
extra **Twig theme suggestions** so a theme can render the content with an alternate template.
Version **4.1.1**. Core requirement **`^11.1 || ^12`** (Drupal 11.1+ only). Depends on core
`field` and `views`. Package "Fields types". License GPL-2.0-or-later. Sponsored by Antistatique.

## Mechanism in one pass
1. A **suggestion** is a config entity (`template_whisperer_suggestion`) = a human `name` + a
   machine-name `suggestion` (validated `[a-z0-9_]`, unique; the entity id IS the machine name).
   Managed at `admin/structure/template-whisperer`.
2. The **Template Whisperer field type** (widget: a single `select`; cardinality forced to 1;
   formatter outputs nothing) stores the chosen suggestion's id on the entity.
3. `hook_theme_suggestions_alter()` (in `inc/suggestions/page.inc` + `inc/suggestions/entity.inc`)
   appends the suggestion, **always prefixed** with entity type / bundle / id / view mode — never
   bare. See [theming](theming/suggestions.md) for the exact strings.
4. The theme provides the matching `*.html.twig`. **No matching file → silent fallback to the
   default template** (the commonest support question this pattern generates).

## What it provides
- **Config entity + admin UI + usage tracking** → [config/suggestion-entity.md](config/suggestion-entity.md)
- **Field type / widget / formatter + field access** → [fields/field.md](fields/field.md)
- **Theme-suggestion injection (the core), Tokens, Twig fn, block Condition** → [theming/suggestions.md](theming/suggestions.md)

## Permissions (`template_whisperer.permissions.yml`)
- `administer template whisperer suggestion entities` — suggestion CRUD + all admin routes + entity `admin_permission`.
- `administer the template whisperer field` — edit the TW field on content (via `hook_entity_field_access`; also allowed for `bypass node access` / `administer content types`).
- `administer template whisperer` — declared but only referenced by the update hook that migrated to the field permission.

## Notes worth attaching
- The template choice is stored on the entity: it **exports, translates, revisions and migrates**
  with the content. Deleting a suggestion cleans its usage rows but leaves stale `target_id`s on
  content — decide what happens to referencing entities.
- Uninstall is blocked while any TW field or any suggestion entity still exists.
- No Drush commands. Provides config schema. Provides plugin *instances* (FieldType/Widget/
  Formatter, Condition) but no new plugin *types*.
