# Repository service (`domain_path_redirect.repository`)

Service id `domain_path_redirect.repository` → `Drupal\domain_path_redirect\DomainPathRedirectRepository`
(tagged `backend_overridable`). Loads/looks up `domain_path_redirect` entities. This is the module's
public lookup API; the request subscriber uses it to resolve redirects.

Constructor args: `@entity_type.manager`, `@database`, `@config.factory` (reads `redirect.settings`),
`@request_stack`.

## Methods

| Method | Signature | Behaviour |
|---|---|---|
| `findMatchingRedirect` | `($source_path, $domain_id, array $query = [], $language = LANGCODE_NOT_SPECIFIED)` | Core matcher. Returns a `DomainPathRedirect` or `NULL`. Throws `RedirectLoopException`. See below. |
| `findBySourcePath` | `($source_path)` | Entity query, `redirect_source.path LIKE $source_path` AND `enabled = 1`. Returns entities. `accessCheck(FALSE)`. |
| `findByDestinationUri` | `(array $destination_uri)` | Entity query, `redirect_redirect.uri IN $destination_uri` AND `enabled = 1` (e.g. `['internal:/node/123']`). `accessCheck(FALSE)`. |
| `load` | `($redirect_id)` | Loads one entity by id. |
| `loadMultiple` | `(?array $redirect_ids = NULL)` | Loads many (all if NULL). |

## `findMatchingRedirect` details

1. Builds candidate hashes with `DomainPathRedirect::generateDomainHash($source_path, $domain_id, $query, $language)`.
   Also adds a `LANGCODE_NOT_SPECIFIED` variant when a specific language was passed.
2. If `$query` is non-empty **and** `redirect.settings:passthrough_querystring` is on, it also adds
   query-less hash variants (so `/path?x=1` can match a redirect stored for `/path`).
3. Runs a **direct, parameterised** SQL query:
   `SELECT rid FROM {domain_path_redirect} WHERE hash IN (:hashes[]) AND enabled = 1 ORDER BY LENGTH(redirect_source__query) DESC`
   (longest query string wins). The `:hashes[]` placeholder is bound, not interpolated.
4. Loops are guarded via an internal `foundRedirects` list → throws `RedirectLoopException` if the
   same `rid` is seen twice.
5. Follows **chained** redirects: `findByRedirect()` takes the matched destination, strips the base
   URL, and recurses with `findMatchingRedirect()` so a destination that is itself a redirect resolves
   to the final target within the same domain/language.

The `domain` is part of the hash, so a lookup only ever returns a redirect belonging to the passed
`$domain_id`.

## Usage

```php
/** @var \Drupal\domain_path_redirect\DomainPathRedirectRepository $repo */
$repo = \Drupal::service('domain_path_redirect.repository');

// Resolve for a domain (returns a DomainPathRedirect or NULL):
$redirect = $repo->findMatchingRedirect('offers', 'example_com', [], 'en');
if ($redirect) {
  $url = $redirect->getRedirectUrl()->toString();
  $code = $redirect->getStatusCode();
}

// Find every enabled redirect targeting a node, across domains:
$targets = $repo->findByDestinationUri(['internal:/node/123']);
```

## Entity helper methods (`DomainPathRedirect`)

- `static generateDomainHash($source_path, $domain, array $source_query, $language)` — the
  domain-scoped hash used everywhere for matching/dedup.
- `static getCurrentDomainId()` — default-value callback returning `[domain.negotiator->getActiveId()]`.
- `setDomain(DomainInterface $domain)`, `getDomain()`, `getLanguage()`.
- Plus everything inherited from `Drupal\redirect\Entity\Redirect` (`setSource()`, `setRedirect()`,
  `getSourceUrl()`, `getRedirectUrl()`, `getStatusCode()`, …).
