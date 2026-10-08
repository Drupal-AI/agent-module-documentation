# Hooks (`digital_asset_inventory.api.php`)

## `hook_digital_asset_inventory_title_resolve_alter(&$title, &$source, array $context)`
Fired after the core title-resolution chain (media name → anchor text → image alt → HTTP fetch)
but **before** the resolved title is stored. Lets a site override titles using authenticated APIs
or custom logic.

- `$title` (string, by ref) — the resolved title; modify in place.
- `$source` (string, by ref) — the `title_source` value; set a custom name (e.g. `google_api`) when
  overriding. Core sources: `manual`, `http_fetch`, `oembed`, `media_name`, `anchor_text`,
  `image_alt`, `truncated_url`, `original` (plus `auth_required`, `js_rendered`, `unsafe_url`,
  `http_not_found` for failures).
- `$context` (array) — `asset_item` (the `DigitalAssetItem`), `resolved_title` (HTTP-fetched title
  or NULL, Phase 2 only), `anchor_title`, `image_alt`.

Example: resolve Google Docs / SharePoint titles via a service-account API when the URL matches a
known pattern (see the api.php examples). Implement in your module's `.module` file:
```php
function mymodule_digital_asset_inventory_title_resolve_alter(&$title, &$source, array $context) {
  $url = $context['asset_item']->get('file_path')->value ?? '';
  if (str_contains($url, 'sharepoint.com/') && ($t = _mymodule_graph_api_title($url))) {
    $title = $t;
    $source = 'ms_graph';
  }
}
```
This is the only hook the module invites.
