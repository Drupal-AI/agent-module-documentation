# Islandora services, code API & routes

## `islandora.utils` → `Drupal\islandora\IslandoraUtils`

The general-purpose helper. Field-name constants: `MEMBER_OF_FIELD` (`field_member_of`), `MODEL_FIELD`
(`field_model`), `MEDIA_USAGE_FIELD` (`field_media_use`), `MEDIA_OF_FIELD` (`field_media_of`),
`EXTERNAL_URI_FIELD` (`field_external_uri`).

| Method | Returns / does |
|---|---|
| `getParentNode(MediaInterface)` | The node a media belongs to (`field_media_of`). |
| `getMedia(NodeInterface)` | All media of a node. |
| `getMediaWithTerm(NodeInterface, TermInterface)` | Media of a node tagged with a term (used by derivatives). |
| `getReferencingMedia($fid)` | Media referencing a file. |
| `getTermForUri($uri)` / `getUriForTerm(TermInterface)` | Resolve taxonomy term ↔ external URI. |
| `getUriFieldNamesForTerms()` | Fields that hold term URIs. |
| `executeNodeReactions/executeMediaReactions/executeFileReactions/executeTermReactions($type, $entity)` | Run all Context reactions of a type for an entity. |
| `executeDerivativeReactions($type, NodeInterface, MediaInterface)` | Run derivative reactions. |
| `haveFieldsChanged($entity, $original)` | Detect relevant field changes (used by CRUD hooks). |
| `getFilesystemSchemes()` | Available flysystem schemes. |
| `getMediaReferencingNodeAndTerm(NodeInterface, TermInterface)` | Find media by node + use term. |
| `getReferencingFields($entity_type, $target_type)` | Entity-reference fields between types. |
| `getEntityUrl / getDownloadUrl / getRestUrl($entity, $format)` | URL helpers. |
| `isIslandoraType($entity_type, $bundle)` / `canCreateIslandoraEntity(...)` | Islandora-ness checks. |
| `findAncestors(ContentEntityInterface, $fields, $max_height)` | Walk `field_member_of` ancestry. |
| `deleteMediaAndFiles(array $media)` | Delete media + their files. |

## Other services (`islandora.services.yml`)

- `islandora.media_source_service` (`MediaSource\MediaSourceService`) — create/replace a media's source
  file, validate mime/extension; backs the REST controllers.
- `islandora.eventgenerator` (`EventGenerator\EventGenerator`) — build the JSON-LD-ish event payloads that
  the emit-event Actions send.
- `islandora.stomp` (`Stomp\StatefulStomp` via `StompFactory`) — the broker connection (config `broker_url`).
- `islandora.entity_mapper` (`Islandora\EntityMapper\EntityMapper`) — Drupal↔Fedora URI mapping.
- Event subscribers: `JwtEventSubscriber` (mints/validates JWT claims for microservice auth),
  `Media/NodeLinkHeaderSubscriber` (HTTP `Link` headers when `allow_header_links`),
  `StompHeaderEventSubscriber` (adds JWT auth header to outbound STOMP), `AdminViewsRouteSubscriber`.
- Context providers: media / file / taxonomy-term route context providers.

## Media / REST routes (`islandora.routing.yml`)

Auth for the source routes is `['basic_auth', 'cookie', 'jwt_auth']` — microservices call back with a JWT.

| Route | Method / path | Access |
|---|---|---|
| `islandora.media_source_update` | `PUT /media/{media}/source` | permission `update media` |
| `islandora.media_source_put_to_node` | `PUT /node/{node}/media/{media_type}/{taxonomy_term}` | `MediaSourceController::putToNodeAccess` = node `update` **and** `create media` |
| `islandora.attach_file_to_media` | `GET|PUT /media/add_derivative/{media}/{destination_field}` | `attachToMediaAccess` = media `update` |
| `islandora.upload_children` | `/node/{node}/members/upload/{step}` | `AddChildrenWizard\Access::childAccess` |
| `islandora.upload_media` | `/node/{node}/media/upload/{step}` | `Access::mediaAccess` |
| `islandora.add_member_to_node_page` | `/node/{node}/members/add` | `_entity_create_any_access: node` |
| `islandora.add_media_to_node_page` | `/node/{node}/media/add` | `_entity_create_any_access: media` |
| `islandora.confirm_delete_media_and_file` | `/media/delete_with_files` | `administer media`+`delete any media` |
| `islandora.confirm_delete_node_and_media` | `/node/delete_with_media` | `administer media`+`delete any media` |

The source/attach routes are the ones microservices hit to write derivatives back (see the derivative
pattern in [../plugins/context.md](../plugins/context.md)).

## Entity CRUD hooks (`islandora.module`)

`islandora_{node,media,file,taxonomy_term}_{insert,update,delete}` run the matching Context reactions;
`islandora_jsonld_alter_normalized_array` and `islandora_entity_view_mode_alter` apply the JSON-LD/view-mode
reactions; `islandora_entity_extra_field_info`/`islandora_entity_view` add repository UI. There is **no
`islandora.api.php`** — extension is done via Context plugins and standard core/JSON-LD hooks, not custom
Islandora hooks.
