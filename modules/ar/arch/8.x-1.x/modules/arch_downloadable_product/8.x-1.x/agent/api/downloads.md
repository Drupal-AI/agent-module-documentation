<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Downloads: entitlement, routes, and URL signing

## Install & enable

```bash
drush en arch_downloadable_product -y
```

Requires `arch`, `arch_product`, core `file`. Then edit a **product type**
(*Structure → Product types → edit*) and tick **Downloadable product**. On save the module adds a
`product_file` field to that bundle (see [fields/product-file.md](../fields/product-file.md)).

## The entitlement service — `ProductFileAccess` (`downloadable_product.access`)

`src/ProductFileAccess.php`. All checks are server-side; the file field uses the `private` scheme so
files are never web-reachable directly.

| Method | What it verifies |
|---|---|
| `check($product, $file, $account)` | `productHasFile()` **and** `customerHasProduct()`. |
| `checkByIds($product_id, $file_uuid, $user_uuid)` | loads product/file/user, same two checks. |
| `checkWithToken(...)` / `checkByIdsWithToken(...)` | the above **plus** `token === DownloadUrlBuilder::getToken()`. |

- `productHasFile()` — the file must be referenced by the product's `product_file` field.
- `customerHasProduct()` — `db->select('arch_order','o')` left-joined to `order__line_items` with
  `o.uid = account`, `o.status = 'completed'`, `l.line_items_product_id = product`. Anonymous → FALSE.
  (Uses the query builder with bound conditions — not string-concatenated SQL.)

## Download route — `arch_downloadable_product.download`

Path `/product/{product_id}/{file_uuid}/{user_uuid}`, `_custom_access:
ProductDownloadController::downloadAccess`.

`downloadAccess($account, $product_id, $file_uuid, $user_uuid)` (`src/Controller/ProductDownloadController.php`):

1. Forbidden if the user is **anonymous** or `{user_uuid}` does **not** equal the current user's own
   `uuid()` — so a signed URL cannot be replayed by a different account.
2. Reads `?pdtok=` and calls `checkByIdsWithToken()`; forbidden unless it returns TRUE.

`download()` then loads the file by UUID, checks the file exists on disk, invokes
`hook_product_file_download` / `hook_file_download` for headers, and returns a `BinaryFileResponse`
(or `AccessDeniedHttpException` if no module supplied headers, `NotFoundHttpException` if missing).

## Signed URLs — `DownloadUrlBuilder` (`download_url_builder`)

`src/DownloadUrlBuilder.php`, constructed with `@private_key`.

- `getToken($product, $file, $account)` → `substr(Crypt::hmacBase64("$pid:$fid:$email",
  $private_key . Settings::getHashSalt()), 0, 8)`.
- `getDownloadUrl(...)` → `Url::fromRoute('arch_downloadable_product.download', {product_id, file_uuid,
  user_uuid}, ['query' => ['pdtok' => token]])`.

Because the token is an HMAC keyed on the site private key, download URLs cannot be forged by a
client; the `product_id:file_id:email` binding also ties a URL to one product/file/user triple.

## "My files" — `PurchasedFiles`

Route `arch_downloadable_product.user.purchased_files` = `/user/{user}/downloads` (task tab under the
user's canonical route). Access `fileListAccess()` = `$user->access('view')`. `fileList()` collects the
viewed user's completed orders that contain downloadable bundles, and renders a `table__purchased_files`
of filename/size/date/product/order. A working **download link is only rendered when the viewed user is
the current user** (`$user->id() == $this->currentUser()->id()`); for anyone else the filename is plain
text.

## Operational notes

- Files live under `private://`; a working private-file stream wrapper must be configured
  (`file_private_path` in `settings.php`).
- `RouteSubscriber::alterRoutes()` sets `_custom_access_check: 'FALSE'` on
  `entity.field_config.product_field_delete_form`, and `arch_downloadable_product_form_field_config_edit_form_alter()`
  hides the field-config delete button, to stop admins deleting the managed `product_file` field by hand.
- The product-type toggle is disabled once products of that type already hold files
  (`_arch_downloadable_product_type_has_file_data()`).
