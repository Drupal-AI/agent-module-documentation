# Sitewide search block

- **Plugin id**: `localgov_sitewide_search_block`
- **Class**: `Drupal\localgov_search\Plugin\Block\SitewideSearchBlock`
- **Admin label**: "Sitewide search block"
- **Type**: core `@Block` plugin (this module defines no plugin *type* of its own).

## What it renders (`build()`)

Loads the `localgov_sitewide_search` index, then:

- **If the index is not enabled** (`!$index->status()`) — e.g. no backend installed — it
  renders a notice: *"The sitewide search index requires a search backend. Enabling the
  Sitewide Search Database module will provide one."* linking to
  `system.modules_list` (fragment `module-localgov-search-db`).
- **Otherwise** it renders the exposed filter form of the
  `localgov_sitewide_search` view / `sitewide_search_page` display as a standalone form:
  - built via `FormBuilder` on `\Drupal\views\Form\ViewsExposedForm` with a GET,
    always-process, no-redirect `FormState`;
  - `#id` gets a `-block` suffix (so `views-exposed-form-…-sitewide-search-page-block`);
  - the `s` field gets a `Search` placeholder and is marked `#required`;
  - cache context `url.query_args:s` is added.

Submitting sends `?s=<term>` to `/search` (the view page), where results render.

## Dependencies

Injected via `create()`: `form_builder`. Uses `Drupal\views\Views::getView()` and
`Drupal\search_api\Entity\Index`.

## Placement

Shipped placements (config/optional, both region `search`, weight `-16`):

| Block config | Theme |
| --- | --- |
| `localgov_sitewide_search_block_base` | `localgov_base` |
| `localgov_sitewide_search_block_scarfolk` | `localgov_scarfolk` |

To use it in another theme, place the *Sitewide search block* via
`/admin/structure/block` in the desired region.

## Related accessibility

`localgov_search_preprocess_form()` adds `role="search"` and `aria-label="Sitewide"` to the
`views-exposed-form-localgov-sitewide-search-sitewide-search-page` form — see
[hooks/integration.md](../hooks/integration.md).
