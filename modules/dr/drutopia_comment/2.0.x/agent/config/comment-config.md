<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shipped comment configuration + role grants

Everything this module does is exported config. Two directories: `config/install/` (installed
once at enable, then owned by active config) and `config/actions/` (config_actions that mutate
existing role config at install). Cited paths are relative to the module root.

## Install / enable

`drush en drutopia_comment` (or via the Drutopia install profile). Dependencies from info.yml:
`comment`, `drutopia_core`, `field`, `node`, `rdf`, `text`. The `config/actions/` permission
grants are applied by the **`config_actions`** module (README: `drupal/config_actions ^1.1`);
`composer.json` itself declares no `require`. On a bare (non-Drutopia) site, enable fails
because `drutopia_core` and its chain are missing — expected; these docs are source-derived.

## `config/install/` — the comment type, field, displays, RDF

- **`comment.type.comment.yml`** — comment type `id: comment`, `label: 'Default comments'`,
  `target_entity_type_id: node`, description *"Allows commenting on content"*. `dependencies: {}`.
- **`field.storage.node.comment.yml`** — field storage `node.comment`, `field_name: comment`,
  `type: comment`, `settings.comment_type: comment`, `cardinality: 1`, `translatable: true`,
  `locked: false`. This is the field that turns on commenting per node bundle (attach the field
  to a content type to enable comments there; the module ships only the storage, not per-bundle
  `field.field.node.*.comment` instances).
- **`field.field.comment.comment.comment_body.yml`** — the comment body field on the comment
  bundle: `field_name: comment_body`, `field_type: text_long`, `label: Comment`,
  `required: true`, `translatable: true`. Depends on `text` + `field.storage.comment.comment_body`
  (the latter is core-provided by the Comment module, not shipped here).
- **`core.entity_form_display.comment.comment.default.yml`** — comment entry form: `author`
  (weight -2), `subject` as `string_textfield` (size 60, weight 10), `comment_body` as
  `text_textarea` (5 rows, weight 11).
- **`core.entity_view_display.comment.comment.default.yml`** — comment display: `comment_body`
  as `text_default` with `label: hidden` (weight 0), `links` (weight 100); `hidden:
  search_api_excerpt: true`. No non-core formatter — the body uses the standard text formatter.
- **`rdf.mapping.comment.comment.yml`** — maps comment to `types: ['schema:Comment']`; field
  mappings: `subject`→`schema:name`, `created`→`schema:dateCreated`, `changed`→`schema:dateModified`
  (both via `Drupal\rdf\CommonDataConverter::dateIso8601Value`), `comment_body`→`schema:text`,
  `uid`→`schema:author` (`mapping_type: rel`). Pure metadata markup; needs core `rdf`.

## `config/actions/` — role permission grants (config_actions)

Five files, one per Drutopia role. Each uses the config_actions `add` plugin twice: it appends
`comment` to the role's `dependencies.module`, and appends permission strings to the role's
`permissions` list (additive — it does not replace whatever the role already has). Exact,
verbatim permission strings granted:

| Role (`user.role.<id>.yml`) | Permissions added |
| --- | --- |
| `anonymous` | `access comments` |
| `authenticated` | `access comments`, `post comments` |
| `contributor` | `edit own comments`, `skip comment approval` |
| `editor` | `administer comments`, `skip comment approval` |
| `manager` | `administer comments`, `skip comment approval` |

Notes on the grant design (all standard core Comment permissions):

- **anonymous** is read-only: `access comments` (view) only — no posting, no bypass of approval.
- **authenticated** may `post comments` but does **not** get `skip comment approval`, so
  logged-in users' comments enter the moderation queue by default.
- **contributor / editor / manager** get `skip comment approval` (their comments publish
  immediately); editor and manager additionally get `administer comments` (moderate/edit/delete
  any comment); contributor instead gets `edit own comments`.

## Operating / overriding

- Comment types: `/admin/structure/comment`. Moderate: `/admin/content/comment`.
  Permissions: `/admin/people/permissions` (core Comment section).
- To enable comments on a content type, add a `comment`-type field instance to that node bundle
  (Structure → Content types → Manage fields), since only the field *storage* is shipped.
- The install config is active-config once imported; override displays/fields like any config and
  re-import module defaults if needed. Uninstalling removes the shipped config per normal rules.
