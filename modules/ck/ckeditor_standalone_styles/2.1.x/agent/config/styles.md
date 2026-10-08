<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ckeditor_style` config entity & admin UI

Each entry in the Styles dropdown is a `ckeditor_style` config entity
(`src/Entity/CKEditorStyle.php`, config prefix `style`, so config names look like
`ckeditor_standalone_styles.style.<id>`).

## Fields (config_export)

| Field | Type | Meaning |
| --- | --- | --- |
| `id` | string (machine name, ≤32 chars) | Unique key. |
| `label` | label | Text shown in the Styles dropdown. |
| `element` | string | Exactly one HTML tag the style applies to, e.g. `p`, `h2`, `span`, `div`. |
| `classes` | string | One or more CSS classes, **one per line**; all are applied together when the style is chosen. |
| `weight` | integer | Order in the dropdown (ascending). |

Schema: `config/schema/ckeditor_standalone_styles.schema.yml`.

## Admin UI

- **Collection (list):** `/admin/config/content/ckeditor_style` — a `DraggableListBuilder`
  (`CKEditorStyleListBuilder`) showing Label / Machine name / Element / Classes with drag-to-reorder
  (persists `weight`). Menu link "CKEditor styles" under **Configuration → Content authoring**
  (`ckeditor_standalone_styles.links.menu.yml`).
- **Add:** `/admin/config/content/ckeditor_style/add` (action link "Add CKEditor style").
- **Edit:** `/admin/config/content/ckeditor_style/{ckeditor_style}/edit`.
- **Delete:** `/admin/config/content/ckeditor_style/{ckeditor_style}/delete` (confirm form).

Add/edit form (`Form/CKEditorStyleForm.php`): Label (required), machine name, HTML Element (required,
trimmed on validate), CSS classes textarea (required, one per line). All entity routes and the entity's
`admin_permission` are gated by **`administer ckeditor standalone styles`**.

Because these are config entities, a **theme or module can ship default styles** as
`ckeditor_standalone_styles.style.<id>.yml` config; they appear in the list alongside UI-created ones.

## Making styles appear in an editor

1. Enable the module (adds the entity type via `hook_update_9200`; if upgrading from an older textarea
   config, `post_update_001_migrate_config` converts `element.class|Label` lines into entities).
2. In a CKEditor 5 text format's toolbar, add the **Style** button. Styles defined in that format's own
   plugin config are **ignored** — the list is supplied entirely from these entities.
3. Only styles whose `element` is allowed by the format's filter are offered (see
   [../architecture/integration.md](../architecture/integration.md)).

## Legacy settings form (do not rely on)

`/admin/config/content/ckeditor-standalone-styles` (`CkeditorStandaloneStylesSettingsForm`) is the pre-2.1
textarea form. It is superseded by the entity UI; its validator references a `generateStylesSetSetting`
method that no longer exists on the class, so saving it is not the supported path. Manage styles through
the config-entity collection instead.
