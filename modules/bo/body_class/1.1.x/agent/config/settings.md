<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body Class — configuration, storage & the body-tag pipeline

Everything the module does is in `body_class.module`, `body_class.install`, one form and one
controller. There is no field type, no entity, no plugin, no service.

## Install / enable

- `drush en body_class` (or the UI). Depends on core `node`. `hook_install` shows a status message
  pointing at README; `hook_schema` creates the `body_class` table.
- **Uninstall drops the `body_class` table** (`body_class_uninstall`) — all per-node classes are lost
  and unrecoverable.
- `hook_update_9001` rebuilds the table (backs up rows, drops, recreates, restores with `nid` cast to
  int and `css_class` truncated to 255) — safe/idempotent-ish migration for older installs.

## Storage: the `body_class` table

Defined in `body_class_schema()` (`body_class.install`):

- `nid` — int, unsigned, not null, **primary key** (also indexed).
- `css_class` — varchar(255), not null, default `''`. Holds the raw space-separated class string.

One row per node that has a class; the row is deleted when the class is cleared or the node is deleted.

## Config object `body_class.settings`

- Single key **`enabled_content_types`** — a `sequence` of content-type machine names (schema:
  `config/schema/body_class.schema.yml`).
- Install default (`config/install/body_class.settings.yml`): `['_all']`.
- Sentinel **`_all`** (or an empty list) means "every content type, including future ones".
- Managed by `BodyClassSettingsForm` (extends `ConfigFormBase`, `getEditableConfigNames()` =
  `['body_class.settings']`). The form has an "Enable for all content types" checkbox plus a
  per-type checkboxes element; on submit it stores either `['_all']` or the filtered list of checked
  type ids, then invalidates cache tag `config:body_class.settings`.

Example export:

```yaml
# body_class.settings.yml
enabled_content_types:
  - article
  - page
```

## Routes & permission

- Permission **`administer body class`** — `body_class.permissions.yml`, `restrict access: true`
  (i.e. flagged as security-sensitive in the UI).
- `body_class.settings` → `/admin/config/development/body_class`, `_form` =
  `BodyClassSettingsForm`. Requirement `_permission: administer body class`.
- `body_class.admin_list` → `/admin/config/development/body_class/list`, `_controller` =
  `BodyClassListController::listPage`. Same permission.

Both admin routes are gated by the single restricted permission; there is no anonymous or
`access content` surface.

## The node-form field (who can set the class)

`body_class_form_node_form_alter()`:

1. Returns immediately unless `\Drupal::currentUser()->hasPermission('administer body class')`.
2. Returns unless the form object is a `ContentEntityFormInterface` and the entity is a `NodeInterface`.
3. Adds the field only if the node's bundle is in `enabled_content_types` (or `_all`).

The field is a plain `textfield`, maxlength 255, in the `additional_settings` group, with
`#element_validate => ['body_class_validate_css_classes']` and a submit handler appended to
`$form['actions']['submit']['#submit']`. `body_class_entity_field_access()` additionally returns
`allowedIfHasPermission(..., 'administer body class')` for `edit` on a field named `body_class`.

So the class value is set only by users holding the access-restricted `administer body class`
permission — a site-builder/trusted-editor level right, not a low-privilege content role.

## Validation (input) → what is allowed to be stored

`body_class_validate_css_classes()` splits the value on whitespace and errors on any token failing
`/^-?[_a-zA-Z]+[_a-zA-Z0-9-]*$/`. Message lists the invalid tokens. This rejects spaces-as-markup,
angle brackets, quotes, etc. before the value is stored.

## Persistence

- Submit handler `body_class_node_form_submit()` → `body_class_upsert($nid, $class)`.
- `body_class_upsert()` wraps a `startTransaction()`; empty class → delete existing row; else
  insert or update `css_class`. Errors are logged to the `body_class` channel and re-thrown (submit
  handler catches, shows a messenger error). All statements use the query builder.
- `hook_node_insert` / `hook_node_update` also persist a **programmatic** value if
  `$node->body_class_value` is set (bypasses the form/permission path — for code-driven node
  creation).
- `hook_node_delete` deletes the row and invalidates `node:<nid>`.

## Output: reaching the `<body>` tag

`body_class_preprocess_html(&$variables)`:

1. Gets the `node` route parameter; **does nothing unless the current route is a node page** (so the
   class appears only on that node's canonical page, not on listings or other nodes).
2. Reads `css_class` for that nid.
3. `explode(' ', $class)`, and for each non-empty token runs `Html::getClass($single_class)` and
   appends the result to `$variables['attributes']['class'][]`.

Because tokens go through `Html::getClass()` and into the `attributes.class` array (rendered by
core's `Attribute` object), the value is emitted as sanitized CSS class tokens — there is no raw
string interpolation into the markup.

## Usage list

`BodyClassListController::listPage()` selects `nid`, `css_class` where `css_class <> ''`, extended
with `TableSortExtender` + `PagerSelectExtender` (limit 50). For each row it loads the node, links
title (`entity.node.canonical`) and an Edit link (`entity.node.edit_form`), prints the type, and
renders the class cell as `['#plain_text' => $record->css_class]`. DB errors are logged and surfaced
as a messenger error.

## Operate it

1. Enable the module; grant `administer body class` to trusted roles only.
2. At `/admin/config/development/body_class` choose all types or a subset.
3. Edit a node → *Additional settings* → "CSS Class(es)" → enter space-separated class tokens.
4. The class(es) appear on the `<body>` of that node's page; target them in your theme CSS/JS.
5. Review/maintain via `/admin/config/development/body_class/list`.
