# Permissions

Defined in `block_ajax.permissions.yml`:

| Permission | Restrict access | Controls |
|-----------|-----------------|----------|
| `administer ajax blocks` | `true` | Whether the "Ajax block" fieldset is shown/editable on a block's config form. `AjaxBlockForm` sets the fieldset's `#access` to `AjaxBlocks::hasAccess()`, which checks this permission. Marked `restrict access: true` (grant only to trusted roles). |

Notes:
- This permission gates **configuring** an Ajax block, not viewing one.
- The public AJAX render routes (`/block/ajax/...`) do **not** use this permission; they require the
  core `access content` permission (see blocks/ajax-endpoint.md).
