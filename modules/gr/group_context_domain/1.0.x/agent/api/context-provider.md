<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group-from-domain context provider, cache context, and trait

Two services (`group_context_domain.services.yml`) plus one shared trait expose the domain's group.
Both consume `@domain.negotiator` and `@entity.repository`.

## Shared lookup: `GroupFromDomainContextTrait`

File `src/GroupFromDomainContextTrait.php` (namespace `Drupal\group_context_domain`). Adds
`public function getGroupFromDomain(): GroupInterface|null`:

1. `getDomainNegotiator()->getActiveDomain()` — the currently negotiated `domain` record (or none).
2. `$domain->getThirdPartySetting('group_context_domain', 'group_uuid')` — the assigned group UUID
   (see [config/domain-group.md](../config/domain-group.md) for how it's stored).
3. `getEntityRepository()->loadEntityByUuid('group', $uuid)` — loads the group by UUID.
4. Returns the group, or `NULL` if there's no active domain, no assigned UUID, or no matching group.

The trait declares `protected DomainNegotiatorInterface $domainNegotiator` and
`protected EntityRepositoryInterface $entityRepository`; its `getDomainNegotiator()` /
`getEntityRepository()` lazily fall back to `\Drupal::service(...)` if a class using the trait
didn't inject them. Reuse the trait in your own service to get the same lookup — inject
`domain.negotiator` and `entity.repository` into those two properties.

Note `loadEntityByUuid()` applies the **current language / entity-repository** resolution; the
lookup itself does no access check — access is the consuming context's concern.

## Context provider: `GroupFromDomainContext`

File `src/Context/GroupFromDomainContext.php`. Service
`group_context_domain.group_from_domain_context`, tagged `context_provider`; implements
`ContextProviderInterface` and uses the trait + `StringTranslationTrait`.

- `getRuntimeContexts($unqualified_context_ids)` — builds an **optional** (`setRequired(FALSE)`)
  `EntityContextDefinition::fromEntityTypeId('group')`, wraps `getGroupFromDomain()` in a
  `Context`, and attaches cacheability `setCacheContexts(['url.site.group'])`. Returns
  `['group' => $context]`. Because it's optional, downstream code must tolerate a `NULL` value.
- `getAvailableContexts()` — advertises a `group` context labelled *"Group from domain"* with the
  description *"Returns the group from the domain record if there is one. Can be configured on the
  domain record form."* This is what appears in context-selection UIs (e.g. block placement,
  Layout Builder, Group Sites).

Typical use: place a block that requires/uses a `group` context (such as Group's operations block)
and select **Group from domain** as the context source, so it works on any page of the domain.

## Cache context: `DomainGroupCacheContext`

File `src/Cache/Context/DomainGroupCacheContext.php`. Service `cache_context.url.site.group`,
tagged `cache.context`; implements `CacheContextInterface`, uses the trait. Cache context **ID
`url.site.group`** (a child of core's `url.site`).

- `getContext()` — returns `getGroupFromDomain()->id()` when a group is found, otherwise the
  literal string **`group.none`** (deliberately not a valid group ID/type, so cache buckets never
  collide with a real group).
- `getCacheableMetadata()` — if there's an active domain, adds it as a cacheable dependency
  (`addCacheableDependency($domain)`), so changing the domain record (including its group
  assignment) invalidates dependent caches.
- `getLabel()` — *"Group from domain"*.

Add `url.site.group` to a render array's `#cache['contexts']` (or return it from your plugin's
`getCacheContexts()`) to vary output per detected group.

## Operating notes

- No configuration is needed to activate the services — enabling the module registers both. The
  only setup is assigning a group to a domain (the permission + domain form).
- Everything keys off `domain.negotiator->getActiveDomain()`, so behavior follows the Domain
  module's negotiation for the request. On CLI/queue contexts with no negotiated domain, the
  lookup returns `NULL` / `group.none`.
