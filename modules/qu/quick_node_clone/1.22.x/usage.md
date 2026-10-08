Quick Node Clone adds a "Clone" action to nodes so editors can duplicate an existing node — including its fields and (optionally) referenced paragraphs — as a new draft to edit and save.

---

Quick Node Clone streamlines content duplication in Drupal. It adds a Clone tab/action to nodes that opens the standard node add form pre-populated with a deep copy of the source node's field values, so an editor can tweak and save a new node instead of retyping everything. Referenced entities such as Paragraphs are cloned recursively (rather than shared), so editing the copy doesn't change the original. A settings form lets you prepend configurable text to the cloned title (default "Clone of"), exclude specific fields per node type or paragraph type from being copied, choose the publication status of clones (published, unpublished, or same as source), and — when the Group module is present — control whether group relationships are recreated. Access is fine-grained: a dynamic permission per content type grants "clone any" or "clone own" rights, plus a settings-administration permission. Two hooks (`hook_cloned_node_alter`, `hook_cloned_node_paragraph_field_alter`) let developers post-process the cloned entity or its paragraph fields before the edit form is shown. It depends only on core's Node module.

---

- Add a Clone action to duplicate any node.
- Let editors create a new article from an existing one without retyping.
- Deep-clone referenced Paragraphs so the copy is independent.
- Prepend "Clone of" (or custom text) to the cloned node's title.
- Save clones as unpublished drafts by default.
- Keep clones' publication status the same as the source.
- Publish clones immediately when desired.
- Exclude certain fields from being copied per content type.
- Exclude certain paragraph fields from cloning.
- Grant "clone any content" per content type via permissions.
- Grant "clone own content" only for a user's own nodes.
- Duplicate a complex landing page built from paragraphs in one click.
- Create template/boilerplate nodes editors clone as a starting point.
- Speed up producing series content (e.g. weekly newsletters).
- Clone a product/spec node and change only a few fields.
- Recreate group relationships on clones (with the Group module).
- Reset or randomize a field on the clone via `hook_cloned_node_alter`.
- Adjust paragraph field values on clone via a hook.
- Avoid accidental edits to the original by working on a copy.
- Provide a safe "duplicate and edit" workflow for content teams.
- Clone nodes that reference media without duplicating the media itself.
- Prepare A/B variants of a page quickly.
- Reduce data-entry errors when creating similar content.
- Clone event nodes for recurring events and adjust dates.
- Gate access to clone settings behind an admin permission.
