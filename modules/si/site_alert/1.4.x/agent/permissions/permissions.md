# Site Alert permissions

From `site_alert.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer site alert` | Full admin of the entity (the entity's `admin_permission`); the collection/add/edit/delete UI. |
| `add site alerts` | Create alerts. |
| `update site alerts` | Edit existing alerts. |
| `delete site alerts` | Delete alerts. |

Viewing alerts is **not** permission-gated — every visitor sees active alerts via the block.

## Trust note: message is rendered as raw markup (by design)

The alert `message` (a `text_long` field) is emitted without a text-format filter — both the block
(`SiteAlertBlock::build()`) and the AJAX controller build it as:

```php
'message' => ['#type' => 'markup', '#markup' => $alert->getMessage()],
```

Drupal's renderer runs `#markup` through `Xss::filterAdmin()` (strips `<script>`, event handlers, and
dangerous protocols but allows a broad admin tag set). There is no per-field allowed-HTML restriction,
so anyone with `add site alerts` / `update site alerts` can inject arbitrary admin-level HTML that is
shown site-wide to all visitors. Treat these permissions as trusted-author roles and do not hand them to
low-trust users. (This is expected filter-less admin-content behavior; it is documented here so operators scope
the permissions accordingly.)
