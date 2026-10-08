<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services (calling the module from PHP)

There is no plugin manager here; the module is a small pipeline of four services wired
together by `\Drupal\subrequests\Controller\FrontController::handle()`, the controller behind
the `/subrequests` route.

## Request flow

1. **`FrontController::handle(Request $request)`** — reads the raw payload (POST body, or the
   `query` GET parameter), hands it to `BlueprintManager::parse()`, runs the resulting tree
   through `SubrequestsManager::request()`, then combines the responses with
   `BlueprintManager::combineResponses()`. Output format is `multipart-related` unless the
   master request's format is `json`.

2. **`subrequests.blueprint_manager` → `Blueprint\BlueprintManager`** (constructor arg:
   `@serializer`):
   - `parse($input, Request $request): SubrequestsTree` — deserializes the JSON array into a
     `SubrequestsTree` (via the `subrequests.denormalizer.blueprint.json` /
     `JsonBlueprintDenormalizer` normalizer service) and forwards the master request's `Host`
     header onto every subrequest that doesn't already set one.
   - `combineResponses(Response[] $responses, string $format): Response` — normalizes the
     response array into the wire format (`MultiresponseNormalizer` for
     `multipart-related`, `MultiresponseJsonNormalizer` for `json`), wraps it in a
     `CacheableResponse` with status 207, and merges in every partial response's cacheability
     metadata.

3. **`subrequests.subrequests_manager` → `SubrequestsManager`** (constructor args:
   `@http_kernel`, `@serializer`, `@subrequests.json_path_replacer`):
   - `request(SubrequestsTree $tree): Response[]` — walks the tree level by level
     (`processBatchesSequence`). For each level: run `JsonPathReplacer::replaceBatch()` to
     resolve any tokens against responses accumulated so far, denormalize each `Subrequest`
     into a Symfony `Request` (via `subrequests.denormalizer.subrequest.json` /
     `JsonSubrequestDenormalizer`, which also copies the master request's session/cookies),
     dispatch it with `$http_kernel->handle($request, HttpKernelInterface::MAIN_REQUEST)`, and
     stamp the response with `Content-ID: <requestId>`. Levels are strictly sequential;
     subrequests within a level run against fresh sub-requests but not literally in parallel
     PHP execution — "parallel" here means "no ordering dependency between them", not
     multi-threading.

4. **`subrequests.json_path_replacer` → `JsonPathReplacer`** — no constructor args. See
   [blueprint-format.md](blueprint-format.md) for the token syntax it implements
   (`replaceBatch()` / `replaceItem()`, backed by the `galbar/jsonpath` library's `JsonObject`
   class).

## Calling it programmatically

```php
/** @var \Drupal\subrequests\Blueprint\BlueprintManager $blueprint_manager */
$blueprint_manager = \Drupal::service('subrequests.blueprint_manager');
/** @var \Drupal\subrequests\SubrequestsManager $subrequests_manager */
$subrequests_manager = \Drupal::service('subrequests.subrequests_manager');

$tree = $blueprint_manager->parse($json_blueprint_string, $current_request);
$responses = $subrequests_manager->request($tree);
$combined = $blueprint_manager->combineResponses($responses, 'json');
```

## Related internals

- `\Drupal\subrequests\Subrequest` — plain value object for one parsed subrequest
  (`requestId`, `uri`, `action`, `headers`, `body`, `waitFor`, `_resolved`).
- `\Drupal\subrequests\SubrequestsTree` (extends `\ArrayObject`) — ordered list of "levels"
  (arrays of `Subrequest`), plus `allIds()` used to check whether a `waitFor` dependency has
  been satisfied yet.
- `\Drupal\subrequests\SubrequestsServiceProvider` / `PageCache` — an unrelated container
  workaround (swaps in a `PageCache` middleware subclass that doesn't statically cache the
  page-cache ID per PHP request object) for a core page-cache bug; not part of the public API.
