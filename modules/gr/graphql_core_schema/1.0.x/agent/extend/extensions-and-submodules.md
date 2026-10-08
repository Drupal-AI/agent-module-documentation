# Bundled schema extensions & included sub-modules

## Schema extensions (in the base module — enable per server)

Each is a `@SchemaExtension` with `schema = "core_composable"`; enable it in the server's schema config.
Many declare dependencies via `getExtensionDependencies()` / `getEntityTypeDependencies()`.

| Extension id | Adds |
|---|---|
| `breadcrumb` | `breadcrumb` on a URL (needs `routing`). |
| `entity_query` | `entityById` and `entityQuery` (filter/sort/range/revisions). |
| `field_config` | Field metadata (`name`, `description`, `isTranslatable`, …). |
| `formatted_date` | Formatted values from date/timestamp fields. |
| `image` | Image style derivative URLs/dimensions. |
| `language_switch_links` | Language switch links for a route. |
| `local_tasks` | Local task (tab) links for a route. |
| `media` | Helper fields on media entities. |
| `menu` | Load menus with (filtered/enhanced) nested links. |
| `render_field_item` | `viewField` / `viewFieldItem` — rendered field markup in a view mode. |
| `reverse_entity_reference` | Reverse reference lookups. |
| `routing` | `route` query — resolve a URL string to entity/route data. |
| `taxonomy` | Term helpers (e.g. `children`). |
| `user` | `currentUser`; `hasPermission` / `hasRole` / `roleIds` on `User`. |
| `user_login` | Mutations: login, logout, password reset/change. |
| `views` | `Query` field to execute a configured View and return entities. |

(Enums like `EntityTypeEnum`, `LangcodeEnum`, `DrupalDateFormatEnum`, `LanguageDirectionEnum` are
generated to support these.)

## Included sub-modules (enable separately; `modules/…`)

Contrib/niche integrations. Not documented as separate doc directories in this campaign; each is a thin
schema extension + data producers over the named project.

| Sub-module | Integrates / adds |
|---|---|
| `graphql_debugging` | Debug fields (e.g. request headers) for development. |
| `graphql_environment_indicator` | Active environment name/color (environment_indicator). |
| `graphql_file_url` | Adds file URL fields (`File` type extension). |
| `graphql_form_schema` | Entity **create/edit** form mutations + form result types. |
| `graphql_masquerade_schema` | `masqueradeContext` query + `masqueradeSwitchBack` mutation (masquerade). |
| `graphql_media_oembed_schema` | oEmbed resource / iframe URL for media (media oEmbed). |
| `graphql_messenger` | `messengerMessages` — Drupal messages collected during resolving. |
| `graphql_metatag_schema` | Metatags for routes/entities (metatag). |
| `graphql_metatag_schema_org_schema` | schema.org metatags. |
| `graphql_rokka_schema` | rokka.io image URLs (rokka). |
| `graphql_security` | Adds route access checks to GraphQL endpoints (access check + route subscriber). |
| `graphql_tablefield_schema` | Structured table data on `FieldItemTypeTablefield` (tablefield). |
| `graphql_telephone` | Parsed/formatted phone numbers (telephone). |
| `graphql_translatable_config_pages` | Translatable config pages data producer. |

Note: `graphql_form_schema` exposes mutations that create/edit entities — those go through Drupal form
processing and entity access; expose them only on servers whose clients you trust to write.
