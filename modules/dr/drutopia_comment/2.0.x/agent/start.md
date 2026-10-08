<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Comment (drutopia_comment) — agent index

A **config-only** Drutopia distribution feature. It ships a default node comment type, the
comment body field, form/view displays, an RDF mapping, and `config_actions` that grant core
Comment permissions to Drutopia roles. **No PHP**: no `src/`, routes, services, hooks or
permissions of its own — commenting logic and access are core Comment's.

- **Version:** `2.0.x` (dev checkout — info.yml has no `version:` line; directory is the branch).
- **Core:** `^10.2 || ^11 || ^12`. **Package:** Drutopia. **License:** GPL-2.0-or-later.
- **info.yml dependencies:** `comment`, `drutopia_core`, `field`, `node`, `rdf`, `text`.
  The `config/actions/` permission grants are applied by the **`config_actions`** module, so
  the project needs it too (README lists `drupal/config_actions ^1.1`; note `composer.json`
  ships no `require` block of its own).
- **`features.yml`:** `bundle: drutopia` (Features export marker only).
- **Provides:** no permissions, no config schema, no drush, no plugin types, no settings route.

## Solution docs

- **The shipped comment config (type/field/displays/RDF) and the five role permission grants** →
  [config/comment-config.md](config/comment-config.md)

## What it installs (from `config/install/`)

- `comment.type.comment` — comment type `comment`, label *"Default comments"*, `target_entity_type_id: node`.
- `field.storage.node.comment` — `comment`-type field on nodes, `cardinality: 1`, translatable.
- `field.field.comment.comment.comment_body` — required `text_long` `comment_body` field on the comment bundle.
- `core.entity_form_display.comment.comment.default` — author, `subject` (string_textfield), `comment_body` (text_textarea, 5 rows).
- `core.entity_view_display.comment.comment.default` — `comment_body` (text_default, label hidden) + links; hides `search_api_excerpt`.
- `rdf.mapping.comment.comment` — maps comment to `schema:Comment` (subject/created/changed/body/uid).

## Role permission grants (from `config/actions/`, applied by config_actions)

Each file `add`s to `permissions` (and adds `comment` to the role's module deps). Exact grants:

- **anonymous** → `access comments`
- **authenticated** → `access comments`, `post comments`
- **contributor** → `edit own comments`, `skip comment approval`
- **editor** → `administer comments`, `skip comment approval`
- **manager** → `administer comments`, `skip comment approval`

## Operating it

Enable the module (normally via the Drutopia profile). Manage comment types at
`/admin/structure/comment`, moderate at `/admin/content/comment`, adjust who can comment at
`/admin/people/permissions`. Nothing is configured in code. Enabling on this bare site fails
because the Drutopia dependency chain (`drutopia_core`) is absent — expected; these docs are
from on-disk source, not a running install.
