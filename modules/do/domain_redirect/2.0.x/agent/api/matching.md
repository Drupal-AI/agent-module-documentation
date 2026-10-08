<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain-aware matching, uniqueness, and alias inheritance

## Repository decorator — `RedirectRepositoryDecorator`

`src/RedirectRepositoryDecorator.php` extends `Drupal\redirect\RedirectRepository`
and is registered in `domain_redirect.services.yml` with
`decorates: redirect.repository`, `$inner: '@.inner'` (autowired). The Redirect
module's own request subscriber calls `findMatchingRedirect()` on this service, so
there is **no event subscriber added by this module**.

`findMatchingRedirect($source_path, $query, $language, $cacheable_metadata)`:

1. Reads the active domain from `Drupal\domain\DomainNegotiationContext::getDomain()`.
   If it is `NULL` (domain not negotiated yet), it delegates to the inner,
   non-domain-aware repository and returns.
2. Otherwise builds the candidate `hash` list with `Redirect::generateHash()` for the
   source path/query/language (plus the `LANGCODE_NOT_SPECIFIED` variant, and
   query-less variants when `passthrough_querystring` is set in `redirect.settings`).
3. Runs one parameterized SQL query (placeholders `:hashes[]`, `:domain_id`):
   `... WHERE hash IN (:hashes[]) AND enabled = 1 AND (domain_id IS NULL OR domain_id = :domain_id) ORDER BY domain_id IS NULL ASC, LENGTH(redirect_source__query) DESC`.
   The `domain_id IS NULL ASC` ordering makes a **domain-specific match win over a
   global (NULL) one**; the query-length ordering preserves Redirect's own
   query-specificity behavior. `domain_id` comes from the negotiated domain entity,
   not from request input.
4. Loads the winning `rid`, guards against redirect loops via `$foundRedirects` +
   `RedirectLoopException`, follows chained redirects with `findByRedirect()`, and
   adds the redirect as a cacheable dependency.

Other repository methods (`findBySourcePath`, `findByDestinationUri`, `load`,
`loadMultiple`) simply proxy to `$inner`. **The redirect destination is always the
stored `redirect` entity's target** — admin-configured, never derived from the
request URL/host.

## Uniqueness constraint — `DomainAwareUniqueHash`

- `DomainRedirectHooks::entityTypeAlter()` (`hook_entity_type_alter`) removes the
  Redirect `RedirectUniqueHash` constraint from the `redirect` entity type and adds
  `DomainAwareUniqueHash`.
- `src/Plugin/Validation/Constraint/DomainAwareUniqueHash.php` — the constraint
  (id `DomainAwareUniqueHash`) with the "already being redirected for this domain"
  violation message.
- `DomainAwareUniqueHashValidator::validate()` computes the redirect's hash
  (`Redirect::generateHash` over source path/query/language) and queries storage
  (`getExistingRedirect()`) for another redirect with the **same hash and same
  `domain_id`** — using `notExists('domain_id')` when the redirect is global, or
  `condition('domain_id', $id)` otherwise, and excluding the entity's own id on
  edit. A match adds one violation linking to the existing redirect's edit form.
  Net effect: same hash on **different** domains is allowed; same hash on the **same**
  domain (or two globals) is rejected. (The lookup uses `accessCheck(FALSE)`, which
  is correct for a uniqueness check — it runs during validation and returns nothing
  to the user beyond the standard duplicate-redirect message.)

## Domain Path auto-redirect inheritance

Two hooks on `DomainRedirectHooks` cooperate so a redirect auto-created by the
Redirect module (on `auto_redirect`) after a domain-specific alias rename inherits
the alias's domain:

- `pathAliasPresave()` (`hook_path_alias_presave`): when a path alias that has a
  non-empty `domain_id` (added by `domain_path`) is renamed, it stashes the domain
  keyed by `oldAlias:langcode` in the in-memory `$aliasDomainContext`.
- `redirectPresave()` (`hook_redirect_presave`): for a **new** redirect with an
  empty `domain_id`, it looks up `/<source path>:<language>` in that context and,
  if found, sets the redirect's `domain_id`. Aliases without a domain produce
  global redirects (unchanged).

Verified by `tests/src/Kernel/DomainRedirectTest.php` (precedence, per-domain
matching, duplicate rejection, NULL-domain fallback, and alias inheritance).
