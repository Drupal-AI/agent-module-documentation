# Configure — Paragraphs types

A **Paragraphs type** is a config entity (`paragraphs.paragraphs_type.<id>`, class
`Drupal\paragraphs\Entity\ParagraphsType`) — the bundle for `paragraph` content entities.
Manage at **Admin → Structure → Paragraphs types** (`/admin/structure/paragraphs_type`,
route `entity.paragraphs_type.collection`, permission `administer paragraphs types`).

## Create and field a type
1. Add a type (`/admin/structure/paragraphs_type/add`): label, machine id, optional
   description and icon (`icon_uuid` / `icon_default` stored on the config entity).
2. Add fields via Field UI on that bundle exactly like a node type (text, image, media,
   nested paragraph reference, etc.).
3. Configure **Manage display** — each type has its own view display and Twig template.

## Use the type in content
Add a field of type **Entity reference revisions** (target type = *Paragraph*) to any
fieldable entity (node, user, term…), then pick the **Paragraphs** widget on the form
display. On the field's reference settings you choose which paragraph types are allowed
(`target_bundles` / drag-drop ordering `target_bundles_drag_drop`) and the
`default_paragraph_type`. See [widget.md](widget.md) for widget options.

## Config entity mapping (`paragraphs_type.schema.yml`)
`id`, `label`, `description`, `icon_uuid`, `icon_default`, and `behavior_plugins`
(a keyed sequence of enabled behavior plugin settings, each `{ enabled: bool, ... }`).

## Behavior plugins on a type
The type edit form lists available behavior plugins (only those whose `isApplicable()`
returns TRUE). Enable one to attach non-field functionality (extra render attributes,
CSS classes, layout options) — no storage field is added. Settings persist under
`behavior_plugins.<plugin_id>`. To build your own see [../plugins/behavior.md](../plugins/behavior.md).

Helpful entity methods: `getBehaviorPlugins()`, `getEnabledBehaviorPlugins()`,
`hasEnabledBehaviorPlugin($id)`, `getIconFile()`, `getIconUrl()`, `getDescription()`.
Procedural helpers in `paragraphs.module`: `paragraphs_type_get_types()`,
`paragraphs_type_get_names()`, `paragraphs_type_load($name)`.
