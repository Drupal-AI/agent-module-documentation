<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brandfolder Assets endpoints

All routes require only `_user_is_logged_in: TRUE`.

| Route | Path | Controller | Notes |
|---|---|---|---|
| library | `/brandfolderassets/library` | `AssetsLibrary` | Reads `$_GET['field_name']`, `field_name_delta`; builds modal HTML |
| save | `/brandfolderassets/save` | `AssetsSave` | Downloads `data_attributes_cdnurl` via `system_retrieve_file()` |
| pagination | `/brandfolderassets/pagination/{totalpage}/{viewpage}` | `AssetsPagination` | |
| search | `/brandfolderassets/search/{searchtype}/{searchvalue}` | `AssetsSearch` | |

Behaviour: the modal calls the `brandfolder` module's `brandfolder_api($api_key)` client (`getBrandfolders`, `listAssets`) to render a thumbnail grid; `AssetsSave` writes the selected CDN asset into `public://brandfolderassets` as a managed file and returns its fid/URL as JSON.
