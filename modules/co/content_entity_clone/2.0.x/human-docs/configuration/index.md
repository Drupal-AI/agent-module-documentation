# Configuration

## Grant the permissions

Content Entity Clone defines two permissions, assigned at **People → Permissions**
(`/admin/people/permissions`):

- **Administer entity cloning** (`administer entity cloning`) — access to the cloning
  overview and per-bundle configuration.
- **Clone content entities** (`clone content entities`) — the permission a user needs
  to actually see and use the Clone action. Keep this separate from administration so
  you can let editors clone without giving them configuration access.

Note that, in addition to the permission, a user can only clone a given entity if they
can reach that bundle's **creation route** and have **update** access to the **source**
entity — so cloning never lets someone create content they otherwise couldn't.

## Enable cloning per bundle

1. Go to **Configuration → Content Entity Clone**
   (`/admin/config/content_entity_clone`).
2. The overview lists your content entity types and their bundles. Click through to a
   bundle's settings form.
3. On the bundle's settings form (path
   `/admin/config/content_entity_clone/field_settings/{entity_type}/{bundle}`):
   - Turn **cloning on** for the bundle.
   - Optionally set a custom **clone link label** (for example "Duplicate" instead of
     "Clone").
   - For **each field**, choose how it is handled — pick a **field processor** or
     choose **Skip field** to leave it out of the copy.
4. Save.

Enabling a bundle writes a config object
(`content_entity_clone.bundle.settings.<entity_type>.<bundle>`) recording that it is
enabled, the optional label, and the per-field processor choices — so your clone
configuration is exportable and deployable.

## Field processors

A field processor decides how a field's value is transformed as it's copied onto the
new entity. The module ships these:

- **Copy values** (`copy_values`) — copy the field's values as-is.
- **Append clone suffix** (`entity_label_clone_suffix`) — append " [CLONE]" to the
  entity's label, so copies are easy to spot.
- **Clone referenced entities** (`clone_referenced_entities`) — deep-clone referenced
  entities (for example paragraphs) so the copy has its own independent references
  rather than sharing the originals.
- **Copy layout** (`copy_layout`) — copy a Layout Builder layout, deep-cloning its
  inline content blocks so the cloned page's layout is independent of the source.

Choose **Skip field** for anything you don't want carried over — for example leave the
author and date fresh while copying only the body and image.

Developers can add custom field processors (they are a plugin type declared with the
`#[ContentEntityCloneFieldProcessor]` attribute) or alter existing ones via a hook —
see the sibling [agent docs](../agent/start.md) for the plugin details.

## How cloning works for the editor

Once a bundle is enabled, a **Clone** action (a local task tab and/or an operation
link) appears on entities of that bundle for permitted users. Clicking it opens the
normal creation form, pre-filled with the source entity's processed field values, on
an **unsaved** entity. The editor reviews the pre-filled form, makes any changes, and
saves — producing a genuine new entity rather than an automatic duplicate. This makes
it easy to, say, clone last month's event to create next month's, then just edit the
date.
