# Islandora's automation engine: Context Conditions, Reactions & Actions

Islandora does not hardcode "when X happens, do Y". Instead it registers plugins for the **Context** module.
An admin builds a Context (`/admin/structure/context`) from **Conditions** (when does it apply?) and
**Reactions** (what to do), and Reactions execute **Actions** (usually emitting an event to a microservice or
indexing). This is the heart of an Islandora site's behavior.

`IslandoraUtils::executeNodeReactions()/executeMediaReactions()/executeFileReactions()/executeTermReactions()`
and `executeDerivativeReactions()` are the entry points; the entity CRUD hooks in `islandora.module` call
them on insert/update/delete.

## Actions (`src/Plugin/Action/`)

Emit-event actions publish a JSON message to the STOMP queue named in their config (event type +
`queue`), consumed by an Islandora microservice/alpaca:

| id | Class | Emits for |
|---|---|---|
| `emit_node_event` | `EmitNodeEvent` | a node |
| `emit_media_event` | `EmitMediaEvent` | a media |
| `emit_file_event` | `EmitFileEvent` | a file |
| `emit_term_event` | `EmitTermEvent` | a taxonomy term |
| `generate_derivative_file` | `AbstractGenerateDerivativeMediaFile` (abstract base) | derivative → media file attach |
| — | `AbstractGenerateDerivative` (abstract base) | derivative → new media on a node |
| `index_node_in_search_api` | `IndexNodeInSearchApi` | force Search API indexing of a node |
| `index_medias_parent_node_in_search_api` | `IndexMediasParentNodeInSearchApi` | index a media's parent node |
| `delete_media_and_file` | `DeleteMediaAndFile` | delete media + its file |
| `delete_node_and_media` | `DeleteNodeAndMedia` | delete node + its media |

### The Generate-Derivative pattern (`AbstractGenerateDerivative::generateData()`)

Config: `queue` (e.g. `islandora-connector-houdini`), `event` (`Generate Derivative`), `source_term_uri`,
`derivative_term_uri`, `mimetype`, `args`, `destination_media_type`, `scheme`, `path`
(default `[date:custom:Y]-[date:custom:m]/[node:nid].bin`). It resolves the **source media** (the media on the
node tagged with `source_term_uri`), builds a `source_uri` download URL and a `destination_uri` pointing at
the `islandora.media_source_put_to_node` REST route, token-replaces the `path`, and emits the message so a
microservice fetches the source, converts it, and PUTs the result back. Submodules subclass this with
their own defaults (image/audio/video/OCR) — see the submodule docs.

## Context Reactions (`src/Plugin/ContextReaction/`)

| id | Class | Effect |
|---|---|---|
| `derivative` | `DerivativeReaction` | Run the configured derivative Actions for a node. |
| `file_derivative` | `DerivativeFileReaction` | Derivative Actions that attach a file to existing media. |
| `index` | `IndexReaction` | Run index Actions (push to Search API). |
| `delete` | `DeleteReaction` | Run delete Actions. |
| `view_mode_alter` | `ViewModeAlterReaction` | Switch the view mode used to render the entity. |
| `form_display_alter` | `FormDisplayAlterReaction` | Switch the form display. |
| `alter_jsonld_type` | `JsonldTypeAlterReaction` | Change the `@type` in JSON-LD output (config: `source_field`). |
| `islandora_map_uri_predicate` | `JsonldSelfReferenceReaction` | Set the predicate used for the self URI in JSON-LD (`drupal_uri_predicate`). |

The `index`/`delete`/`derivative` reactions store a list of action ids
(`islandora.reaction.actions` schema).

## Conditions (`src/Plugin/Condition/`)

Restrict when a Context applies. Available ids:

`node_is_islandora_object`, `node_is_published`, `node_has_term`, `node_has_parent`, `node_has_ancestor`,
`node_referenced_by_node`, `node_had_namespace`, `parent_node_has_term`, `parent_node_of_node_has_term`,
`media_is_islandora_media`, `media_has_term`, `media_has_mimetype`, `media_source_mimetype`,
`media_uses_filesystem`, `file_uses_filesystem`, `islandora_entity_bundle`, `content_entity_type`.

The term-based ones (`*_has_term`) match against a taxonomy term **URI** (`field_external_uri`) with AND/OR
logic; filesystem ones match a flysystem scheme (e.g. `fedora`, `public`).

## Other plugins

- **EntityReferenceSelection** `ExternalUriSelection` — reference selection for external-URI terms.
- **Field**: FieldType `media_track` (+ widget) for media track/caption files; FieldFormatter
  `islandora_image` (adds an alt-text source setting).
- **Views**: field `IntegerWeightSelector` (reorder children); filters `NodeHasMediaUse`, `NodeIsIslandora`.

## Typical setup

1. Create taxonomy terms for models (Image, …) and media use (Original File, Service File, Thumbnail) with
   `field_external_uri` set to the standard Islandora URIs.
2. Build a Context: Condition `node_has_term` = Image → Reaction `derivative` running
   `generate_image_derivative` (from islandora_image), etc.
3. Ensure the broker + microservices are running so emitted events are processed.
