# Fields, bundles, display & theming

## Fragment types (bundles)

A **fragment type** is the bundle. Create/manage them at `/admin/structure/fragment-types` (route
`entity.fragment_type.collection`, perm `administer fragment types`). A fragment type is a config
entity with just `id`, `label`, `description`. Each type is fieldable exactly like a content type:
Field UI hangs off `field_ui_base_route = entity.fragment_type.edit_form`, so you get the usual
sub-tabs under `/admin/structure/fragment-types/{fragment_type}/edit`:

- **Manage fields** — `entity.fragment.field_ui_fields` (perm `administer fragment fields`)
- **Manage form display** — `entity.entity_form_display.fragment.default` (perm `administer fragment form display`)
- **Manage display** — `entity.entity_view_display_overview.fragment` (perm `administer fragment display`)

(The `administer fragment fields/display/form display` permissions are provided by core Field UI for
this entity type, not by `fragments.permissions.yml`.) View modes and form modes work as normal;
because the entity is `translatable`, added fields can be made translatable per field.

## Base fields

Declared in `Fragment::baseFieldDefinitions()` (`src/Entity/Fragment.php`):

| Field | Type | Notes |
|---|---|---|
| `title` | `string` | Max 255, **required**, revisionable, translatable; the entity **label** key. |
| `status` | `boolean` | Default TRUE; the **publishing** status key; shown as a checkbox in the "Publishing status" tab. |
| `user_id` | `entity_reference` → `user` | The author/owner (uid key); revisionable, translatable; autocomplete widget. |
| `created` | `created` | Creation timestamp. |
| `changed` | `changed` | Last-changed timestamp (drives `EntityChangedInterface`). |
| `revision_translation_affected` | `boolean` | Read-only, revisionable, translatable core bookkeeping field. |

Revision-log fields (`revision_user`, `revision_created`, `revision_log_message`) come from
`RevisionableContentEntityBase` via the `revision_metadata_keys`. `install/fragments.install` contains
`fragments_update_8100` (widened `title` to 255) and `fragments_update_8101` (made `title`
translatable) — relevant only when upgrading from very old installs.

## Display & theming

- Theme hook **`fragment`** (`hook_theme()`, render element `content`), template
  `templates/fragment.html.twig` — it simply prints `title_suffix` + `content` inside
  `<div class="fragment">`.
- Suggestions (`hook_theme_suggestions_fragment()`): `fragment__{view_mode}`, `fragment__{bundle}`,
  `fragment__{bundle}__{view_mode}` — override per bundle and/or view mode by copying the template to
  e.g. `fragment--tip--teaser.html.twig`.
- Rendering is done with the core `EntityViewBuilder`; there is no fragment-specific formatter or
  widget. To surface a fragment, add an **entity-reference field targeting `fragment`** on another
  entity (fragments set `common_reference_target = TRUE`, so they appear in the reference target list)
  and choose the "Rendered entity" formatter, optionally with a specific fragment view mode.

## Admin listing

Out of the box the listing at `/admin/content/fragments` is produced by `FragmentListBuilder`
(columns: Title → edit form, Author, Updated). When **Views Bulk Operations** is installed, the
optional view in `config/optional/views.view.fragments.yml` (view id `fragments`) installs and takes
over the same path with filters (title, type, author, status), sortable columns and a bulk-delete
action. Both are gated by `access fragments overview`.
