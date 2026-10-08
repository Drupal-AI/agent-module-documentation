<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The audience view-access gate

Enforcement is opt-in per field (`enforce_view_access`). All logic lives in `AudienceFieldHooks` (`src/Hook/`), wired for Drupal 10 via bridges in `mautic_audiences_field.module`. It reads audiences through `@mautic_audiences.resolver`.

## Entity view gate — `hook_entity_access`
`AudienceFieldHooks::entityAccess()` runs only for `view` on fieldable entities. For each field where `MauticAudienceItem::enforcesViewAccess()` is true and at least one alias is stored:
- Whoever may **edit** the entity (its admin permission, or `access('update')` allowed) is never gated.
- The account's audience is resolved: the current request's for the current user (`resolver->resolve()`), the stored one for another authenticated user (`resolveForUser()`), empty for a hypothetical anonymous account.
- If the audience matches none of the stored aliases (segment or tag per the field's `kind`), it returns **`AccessResult::forbidden()`**; otherwise neutral.

Crucially it **only ever forbids or stays neutral, never allows** — so it cannot override the entity's own handler (an unpublished entity stays unpublished for a matching visitor). Cacheability: one narrow `mautic_audience.segment:`/`.tag:` context per stored alias, the entity, `cachePerPermissions()`, and the visitor's `mautic_audience:contact:<id>` tag; for an anonymous current visitor it sets max-age 0 and trips core's page-cache kill switch (`@page_cache_kill_switch`), because such a page is no longer shareable between anonymous visitors.

## Field-value gate — `hook_entity_field_access`
`entityFieldAccess()` forbids `view` on any `mautic_audience` field unless the account has `administer mautic audiences`. This makes viewing the raw aliases administrative across formatters, JSON:API, REST, and Views field handlers (the business's segmentation is data to check against, not to list). Templates use `is_in_segment()` which reads items without printing them.

## What the gate does NOT cover (and the tooling for it)
`hook_entity_access` runs only when something asks about view access. It does not cover raw entity queries / `loadMultiple()`, Views on a base table, the search index, or `accessCheck(FALSE)` feeds/exports. Two plugins carry the same condition where needed:

### Per-row Views filter `mautic_audience_row_match` (`src/Plugin/views/filter/AudienceRowMatch.php`)
Added to each field's base table by `AudienceFieldHooks::fieldViewsDataViewsDataAlter()` as "*&lt;label&gt; matches the visitor*". Not exposable. `query()` builds two parameterized `EXISTS`/`NOT EXISTS` subqueries against the field's dedicated data table (table/column names come from the field storage definition, not from input; each expression is namespaced by the filter id to avoid argument collisions). Option `include_untargeted` (default on) keeps rows with no audience (turn off for a "picked for you" listing). Bubbles the broad `mautic_audience` context + contact tag.

### Search API processor `mautic_audience_access` (`src/Plugin/search_api/processor/MauticAudienceAccess.php`)
Indexes a hidden per-item field of `kind:alias` keys for enforcing fields (items with none get the literal `mautic_audience__all`), and in `preprocessSearchQuery()` adds an OR condition group so an item surfaces only if it is untargeted or matches one of the searcher's audience keys. Respects `search_api_bypass_access` (admin listings untouched); adds the `mautic_audience` cache context + contact tag. Toggling enforcement changes what belongs in the index, so **reindex** afterwards.

## Status report — `hook_runtime_requirements`
`runtimeRequirements()` lists the fields that enforce view access. When core's Internal Page Cache module is on, it raises a **warning** that pages rendering those entities for anonymous visitors are served from origin (a deliberate hit-rate cost).
