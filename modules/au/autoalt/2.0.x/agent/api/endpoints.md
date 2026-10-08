<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AutoAlt.ai endpoints (autoalt.routing.yml)

All POST unless noted. Controller `Drupal\autoalt\Controller\AutoaltController`.

| Route | Path | Permission |
|---|---|---|
| generate | `/api/autoalt/generate` | **access content** |
| save_alt | `/api/autoalt/save-alt` | administer media |
| list_fids | `/api/autoalt/list-fids` | administer site configuration |
| availcredit | `/api/autoalt/availcredit` | administer site configuration |
| totalImagesCount | `/api/autoalt/totalImagesCount` | administer site configuration |
| shortAltTextCount | `/api/autoalt/shortAltTextCount` | administer site configuration |
| processedByAutoaltCount | `/api/autoalt/processedByAutoaltCount` | administer site configuration |
| history_api | `/api/autoalt/history` (GET/POST) | access content |
| history_page | `/admin/content/autoalt/history` | access content |
| send_plugin_data | `/api/autoalt/get-data-from-plugin` | access administration pages |

**generate** (`:105`): reads `fid`, `File::load($fid)` (`:118`), base64-encodes bytes via `file_get_contents` (`:158`), builds a payload and `POST`s to `https://ahxdfj.autoalt.ai/api/autoalt-generate-alt` with the site `api_key` (`:183`).
