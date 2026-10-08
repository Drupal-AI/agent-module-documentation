# Permissions

Defined in `pdf_using_mpdf.permissions.yml` plus a dynamic callback
(`PdfUsingMpdfNodeTypePermissions::accessPermissions`).

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer mpdf settings` | **true** | The settings form `admin/config/user-interface/mpdf`. |
| `generate <type> pdf` | *(none — grantable to any role)* | The `node/{node}/pdf` route for that content type. One permission is generated **per node type** (e.g. `generate article pdf`, `generate page pdf`). |

## How the route access is checked

`pdf_using_mpdf.generate_pdf` (`node/{node}/pdf`) uses the `_access_generate_pdf` requirement,
served by `GeneratePdfAccessCheck`:

```php
$permission = 'generate ' . $node->getType() . ' pdf';
return $account->hasPermission($permission) ? AccessResult::allowed() : AccessResult::forbidden();
```

- The check tests the per-type permission; grant `generate <type> pdf` deliberately.
- The `generate <type> pdf` permissions are **not** marked `restrict access: true`.
