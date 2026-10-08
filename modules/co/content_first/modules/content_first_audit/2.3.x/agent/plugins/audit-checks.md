# ContentAuditCheck plugins, the consumer & storage

## Plugin type `ContentAuditCheck`

- **Attribute:** `Drupal\content_first_audit\Attribute\ContentAuditCheck` (extends core `Plugin`):
  `id` (string), `label` (`TranslatableMarkup`), `storage_column` (string — the DB column the count
  is written to; must be one of the `content_first_audit` columns).
- **Interface:** `Drupal\content_first_audit\ContentAuditCheck\ContentAuditCheckInterface`:
  - `getStorageColumn(): string`
  - `run(\DOMXPath $xpath, string $html): ContentAuditCheckResult` — inspect the rendered DOM (and
    raw `$html`, provided because libxml auto-corrects invalid nesting before the DOM is built) and
    return the violation count + offending markup.
- **Result:** `ContentAuditCheckResult` (readonly): `count`, `markup[]`, `context[]`;
  helper `::fromMarkup($markup)`. `count === 0` = passed.
- **Manager:** service `content_first_audit.check_manager` (`ContentAuditCheckPluginManager`,
  dir `Plugin/ContentAuditCheck`, cache `content_first_audit_checks`, alter hook
  `content_first_audit_check_info`). Reusable trait: `NodeMarkupTrait` (`resultFromNodes()`).

### Shipped checks (`Plugin/ContentAuditCheck/`)

| id | storage_column | Flags |
|---|---|---|
| `empty_block_tag` | `empty_block_count` | Empty block-level tags. |
| `missing_alt_attribute` | `missing_alt_count` | `<img>` with the `alt` attribute entirely absent. |
| `empty_alt_attribute` | `empty_alt_count` | `<img alt="">` **not** marked decorative (no `role=presentation`/`aria-hidden=true`). |
| `invalid_heading_content` | `invalid_heading_count` | Headings with invalid block content / no readable text. |

### Add a check

```php
#[ContentAuditCheck(
  id: 'my_check',
  label: new TranslatableMarkup('My check'),
  storage_column: 'my_count', // must exist as a column (add via hook_schema/update)
)]
final class MyCheck implements ContentAuditCheckInterface {
  use NodeMarkupTrait;
  public function getStorageColumn(): string { return 'my_count'; }
  public function run(\DOMXPath $xpath, string $html): ContentAuditCheckResult {
    return $this->resultFromNodes($xpath->query('//…'));
  }
}
```

## The consumer (`ContentAuditConsumer`)

`#[EntityRegistryConsumer(id: 'content_first_audit')]`, extends
`entity_registry\Plugin\EntityRegistryConsumerBase`. Per queued item it:
1. `shouldProcessItem()` — only `node`, and only bundles in `content_first_audit.settings:entity_types.node`
   (empty = all).
2. `processItem()` — loads the node translation, `content_first.builder->buildContent($entity,'full')`,
   builds a DOMXPath, runs every check (`runChecks()` — a faulty check resets its column to 0, never
   breaks the run), runs the metatag checker (`MetatagAuditChecker`, when Metatag present), analyses
   headings (`content_first.heading_analyzer`), then `AuditRepository::upsert()` into
   `{content_first_audit}` keyed on (entity_id, entity_type, language).
- `clearData()` empties the table; `deleteItem()` removes one entity/language row;
  `getTotalItems()`/`getStoredItemCount()` drive the processing summary.

## Storage table `content_first_audit`

Defined in `content_first_audit.install` `hook_schema()`. Columns: `id`, `entity_id`, `entity_type`,
`h1_count`, `hierarchy` (1/0), `empty_block_count`, `missing_alt_count`, `empty_alt_count`,
`invalid_heading_count`, `meta_title`, `meta_description`, `meta_og_title`, `meta_og_description`,
`meta_og_image`, `meta_og_url`, `meta_og_type`, `meta_og_site_name`, `language`. Unique key on
(`entity_id`, `entity_type`, `language`). Metatag length columns store character length (0 = missing);
`og_*` existence columns store 1/0.

## Views + status report

- `hook_views_data()` exposes the table with relationships to `node_field_data`, plus a
  language-aware `content_first_audit_link` field and per-metatag `MetatagStatus` field plugins
  (`content_first_audit_metatag_status`) split into "missing" / "invalid length".
- `hook_views_pre_view`/`pre_render` drop columns/filters for metatags the site does not export
  (`content_first_audit.audited_metatags`), keeping the table in step with the overview report.
- `hook_requirements('runtime')` aggregates the table into a status-page summary linking each count
  to the filtered audit view.
