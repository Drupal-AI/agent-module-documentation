<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ad_inserter` content entity

Defined in `src/Entity/AdInserter.php` (`@ContentEntityType id = "ad_inserter"`), interface
`src/Entity/AdInserterInterface.php`. It is a normal Drupal content entity — SQL storage, base
fields, forms, list builder, canonical/edit/delete links — with a couple of custom touches.

## Entity definition

- `base_table = "ad_inserter"`, `data_table = "ad_inserter_field_data"` (translatable).
- `admin_permission = "administer ad inserter"`.
- entity_keys: `id`, `label`/`name` = `name`, `uuid`, `uid`, `published`/`status` = `status`.
- Traits: `EntityChangedTrait`, `EntityPublishedTrait`, `EntityOwnerTrait`.
- `preCreate()` sets `uid` to the current user.
- Annotation `links` declare `/ad-inserter/...` paths, but `ad_inserter.routing.yml` **overrides**
  the actual paths (see Routes below) — the routing file wins.

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `name` | string (255) | Required. Entity label. Textarea/textfield weight -10. |
| `machine_name` | string (255) | Optional. Stable code used by the machine-name block (e.g. `ad_inserter_sidebar_top`). **Not** a real `machine_name` field type and **not uniqueness-validated** in code. |
| `body` | `string_long` | Optional. "Add HTML or script tag to be rendered." A plain long-string field — **no text format / filter**. Displayed with `text_default`, but the preprocess forces raw output (below). |
| `screen` | `list_string` | Required, default `all`. Allowed: `all`, `mobile`, `desktop`. |
| `status` | boolean | Default TRUE. Uses `user\StatusItem`. Inactive ads render nothing. |
| `uid` | entity_reference→user | Author/owner, set on create. |
| `created` / `changed` | created/changed | Timestamps. |
| `data` | map | Serialized extra data (unused by shipped code). |

## Handlers

- **Access** `src/AdInserterAccessControlHandler.php`: `checkAccess()` returns
  `AccessResult::allowed()->cachePerPermissions()` when the account has `administer ad inserter`,
  otherwise `AccessResult::neutral()` (not forbidden). Route-level `_permission` gating is what
  actually protects the create/edit/delete routes.
- **Storage** `src/AdInserterStorage.php` (extends `SqlContentEntityStorage`): adds
  `loadByMachineName($machine_name)` → `loadByProperties(['machine_name' => …])` then `array_shift`.
  Used by the machine-name block.
- **List builder** `src/AdInserterListBuilder.php`: columns ID / Name / Uniq name / Screen / Status;
  `getEntityIds()` runs an entity query with `accessCheck(TRUE)`, sorted by `changed` DESC, optional pager.

## Routes (`ad_inserter.routing.yml`) & permission

| Route | Path | Access |
|---|---|---|
| `entity.ad_inserter.collection` | `/admin/ad-inserter/list` | `administer ad inserter` |
| `entity.ad_inserter.add` | `/admin/ad-inserter/add` | `administer ad inserter` |
| `entity.ad_inserter.edit_form` | `/admin/ad-inserter/{ad_inserter}/edit` | `administer ad inserter` |
| `entity.ad_inserter.delete_form` | `/admin/ad-inserter/{ad_inserter}/delete` | `administer ad inserter` |
| `entity.ad_inserter.admin_form` | `/admin/config/services/ad-inserter` | `administer ad inserter` |
| `entity.ad_inserter.canonical` | `/admin/ad-inserter/{ad_inserter}` | `access content` |

Single permission (`ad_inserter.permissions.yml`): **`administer ad inserter`** (title "Administer add
inserter"). It is the sole gate for authoring ad `body` markup and also the entity `admin_permission`.
Delete uses `ContentEntityDeleteForm` (a POST confirm form). Menu/action/task links live in
`ad_inserter.links.{menu,action,task}.yml` (collection under *Content*, settings under *Config → Services*).

## Rendering path (raw HTML)

`ad_inserter.module::template_preprocess_ad_inserter()` sets the `body` element's
`#template` to `"{{ value|raw }}"` before rendering, i.e. the stored ad markup is emitted **unfiltered**
into the page (by design — ad snippets must run as `<script>`). For a `screen` other than `all` on
non-canonical views it base64-encodes the rendered body; the loader JS `atob()`-decodes and injects it
only after deciding the viewport matches (see [../plugins/blocks.md](../plugins/blocks.md)). On the
canonical view the body is emitted raw and un-deferred. Template: `templates/ad_inserter.html.twig`
(`<div class="ad-inserter">{{ content }}</div>`); per-entity override suggestion `ad_inserter__<id>`.
