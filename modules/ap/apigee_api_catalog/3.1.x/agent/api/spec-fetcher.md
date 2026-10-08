# SpecFetcher service & the Re-import operation

## Service `apigee_api_catalog.spec_fetcher`

Class `Drupal\apigee_api_catalog\SpecFetcher` implements `SpecFetcherInterface`
(`src/SpecFetcher.php`, `src/SpecFetcherInterface.php`). Constructor args (services.yml):
`@file_system`, `@http_client`, `@entity_type.manager`, `@string_translation`, `@messenger`,
`@logger.channel.apigee_api_catalog`.

Single public method:

```php
public function fetchSpec(\Drupal\node\NodeInterface $apidoc): string;
```

It updates the passed `apidoc` node **in memory only** — the caller must `save()` the node to
persist. Behavior when `field_apidoc_spec_file_source` is `url`:

1. Returns early (`FALSE`) if `field_apidoc_file_link` is empty.
2. Resolves the link with `Url::fromUri($uri, ['absolute' => TRUE])` and issues a Guzzle `GET`
   (`allow_redirects.strict = TRUE`). If `field_apidoc_fetched_timestamp` is set, it adds an
   `If-Modified-Since` (RFC 7231) header — a conditional GET.
3. HTTP `304 Not Modified` → sets `field_apidoc_fetched_timestamp = time()`, returns `STATUS_UNCHANGED`.
4. Otherwise reads the body; `md5($data)` is compared to the stored `field_apidoc_spec_md5`. Equal →
   just refreshes the timestamp, `STATUS_UNCHANGED`.
5. Changed → writes the body via `file.repository->writeData()` into
   `{uri_scheme}://{file_directory}/` (from `field_apidoc_spec`'s settings, default
   `public://apidoc_specs/`, `EXISTS_RENAME`), points `field_apidoc_spec` at the new file, and sets
   `field_apidoc_spec_md5` + `field_apidoc_fetched_timestamp`. Returns `STATUS_UPDATED`.
6. Guzzle errors, an empty body, or a save failure are logged to the `apigee_api_catalog` channel
   **and** shown to the user via messenger; returns `STATUS_ERROR`.

For the `file` source, `fetchSpec()` returns `STATUS_UNCHANGED` without touching the spec (the md5 of
an uploaded file is set separately in `hook_node_presave`).

### Interface constants

| Constant | Value | Meaning |
|---|---|---|
| `SpecFetcherInterface::SPEC_AS_FILE` | `'file'` | Source = uploaded file |
| `SpecFetcherInterface::SPEC_AS_URL` | `'url'` | Source = remote URL |
| `SpecFetcherInterface::STATUS_UPDATED` | `'status_updated'` | Spec content changed and was saved |
| `SpecFetcherInterface::STATUS_UNCHANGED` | `'status_unchanged'` | No change (304 or equal md5) |
| `SpecFetcherInterface::STATUS_ERROR` | `'status_error'` | Fetch/save failed |

### Calling it directly

```php
/** @var \Drupal\node\NodeInterface $apidoc */
$status = \Drupal::service('apigee_api_catalog.spec_fetcher')->fetchSpec($apidoc);
if ($status !== \Drupal\apigee_api_catalog\SpecFetcherInterface::STATUS_ERROR) {
  $apidoc->save(); // fetchSpec only mutates the entity in memory
}
```

Note: `hook_node_presave` already calls `fetchSpec()` for URL-sourced apidoc nodes on every save, so
a plain `$node->save()` re-fetches automatically — you rarely need to call the service yourself.

## The Re-import operation

`hook_entity_type_build` registers a node form handler `reimport_spec`
(`Entity\Form\ApiDocReimportSpecForm`) and link template `reimport-spec-form` → `/node/{node}/reimport`.
`hook_entity_operation` adds a **"Re-import OpenAPI spec"** operation (weight 100) to every `apidoc`
node the current user can update; a local task tab is also declared.

- Route: `entity.node.reimport_spec_form`, path `/node/{node}/reimport`, `_entity_form: node.reimport_spec`,
  option `_node_operation_route: TRUE`.
- Access: `ApiDocReimportSpecForm::checkAccess` →
  `AccessResult::allowedIf($node->bundle() == 'apidoc' && $node->access('update', $account))`. There is
  no separate permission — re-import rides on normal node **update** access for the bundle.
- Submit (`ApiDocReimportSpecForm::submitForm`): no-op with a status message if the source is `file`;
  otherwise calls `fetchSpec()`, and on any non-error status creates a new revision (if revisionable)
  and `save()`s the node. Cancel returns to `view.api_catalog_admin.page_1`.

## Related validation constraint

`field_apidoc_file_link` gets the `ApiDocFileLink` constraint (added in
`hook_entity_bundle_field_info_alter`). `ApiDocFileLinkConstraintValidator` resolves each URI and
performs a Guzzle **HEAD** request (`allow_redirects.strict`) to confirm the URL is reachable, adding
a violation (`%value is not a valid link`) otherwise. Constraint plugin id `ApiDocFileLink`
(`type = "string"`).
