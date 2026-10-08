# Context Breadcrumb — plugins & services

The module does not define its own plugin *type*; it provides plugin *implementations* for the Context
and Condition plugin systems, plus supporting services (`context_breadcrumb.services.yml`).

## Context reaction: `context_breadcrumb`

`src/Plugin/ContextReaction/Breadcrumb.php` (`@ContextReaction("context_breadcrumb")`, label
"Breadcrumb"). Config: `breadcrumbs` (sequence of {title, url, token, weight}) + `cache_query_args`.
This is where breadcrumb rows are entered on a Context. Applied by the breadcrumb builder.

## Condition plugin: `taxonomy_vocabulary`

`src/Plugin/Condition/TaxonomyVocabulary.php` (`@Condition`). Lets a Context be active based on the
current vocabulary. Config: `vocabularies` (sequence). Pairs with the context provider below.

## Context provider: `context_breadcrumb.vocabulary_context`

`src/ContextProvider/VocabularyContext.php` — exposes the current route's vocabulary as a runtime
context (tagged `context_provider`), so the condition/reactions can key off it.

## Services

| Service | Class | Role |
|---|---|---|
| `context_breadcrumb.breadcrumb` | `Breadcrumb\ContextBreadcrumbBuilder` | `breadcrumb_builder` tag, **priority 9999**. Resolves the active context, runs titles/URLs through Token, builds the `Breadcrumb` object. |
| `context_breadcrumb.json_ld_data` | `Service\JsonLdData` | Collects breadcrumb links and builds a Schema.org `BreadcrumbList` array (`buildJsonLdData()`). |
| `context_breadcrumb.response` | `EventSubscriber\ResponseSubscriber` | On `kernel.response`, if `enable_json_ld` and not an admin route, replaces the placeholder `<script type="context_breadcrumb_ld">` with `<script type='application/ld+json'>` + `Json::encode()`d data. |

## Custom event

`src/Event/ContextBreadcrumbEvent.php` is dispatched by the breadcrumb builder, letting other modules
alter the resolved breadcrumb before it is returned (subscribe to it via a normal event subscriber).

## JSON-LD flow (for reference)

`context_breadcrumb_page_attachments_alter()` injects the empty placeholder script when `enable_json_ld`
is on; `context_breadcrumb_system_breadcrumb_alter()` feeds the current breadcrumb links into
`JsonLdData::setDataListItems()`; `ResponseSubscriber` swaps the placeholder for the encoded JSON-LD.
Output is `Json::encode()`d, so values are escaped for the JSON/script context.
