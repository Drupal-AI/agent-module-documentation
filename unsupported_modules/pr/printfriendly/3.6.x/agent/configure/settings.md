# Configure printfriendly

Settings form: `admin/config/printfriendly/config` (route `printfriendly.config`, form
`PrintfriendlyConfigForm`, permission `administer printfriendly`). Values persist in the config
object **`printfriendly.settings`**. No schema ships (config is untyped).

## Settings keys

| Key | Values | Meaning |
|---|---|---|
| `printfriendly_display` | array of node-type machine names + `teaser` | Where the button appears. |
| `printfriendly_image` | image filename (see button groups) or `custom-button-img-url` | Which bundled button/icon image. |
| `custom_button_img_url` | URL | Custom button image (when `printfriendly_image` = `custom-button-img-url`). |
| `printfriendly_page_header` | `default_logo` / `custom_logo` | Header logo in the printout. |
| `printfriendly_page_custom_header` | URL | Custom header image URL (→ JS `pfHeaderImgUrl`). |
| `printfriendly_tagline` | string | Header tagline (→ `pfHeaderTagline`). |
| `printfriendly_click_delete` | `0`/`1` | Allow/deny click-to-delete (→ `pfdisableClickToDel`). |
| `printfriendly_images` | `0`/`1` | Include/exclude images (→ `pfHideImages`). |
| `printfriendly_image_style` | `right`/`left`/`none`/`block` | Image alignment (→ `pfImageDisplayStyle`). |
| `printfriendly_pdf` | `0`/`1` | Allow/deny PDF action (→ `pfDisablePDF`). |
| `printfriendly_email` | `0`/`1` | Allow/deny Email action (→ `pfDisableEmail`). |
| `printfriendly_print` | `0`/`1` | Allow/deny Print action (→ `pfDisablePrint`). |
| `printfriendly_custom_css` | URL | Custom CSS URL for the printout (→ `pfCustomCSS`). |
| `db_version` | int | Internal upgrade marker set by `printfriendly_upgrade_db()`. |

## Runtime behaviour

- **`printfriendly_page_attachments($page)`** runs on every page: calls
  `printfriendly_upgrade_db()`, then builds an inline `<script>` string concatenating the config
  values above into `var pf* = …;` and appending a loader for `//cdn.printfriendly.com/printfriendly.js`.
  The `printfriendly/printfriendly-libraries` CSS library is also attached.
- **`printfriendly_node_view()`** adds `$build['printfriendly']` when
  `in_array($node->getType(), printfriendly_display)` **and**
  `\Drupal::currentUser()->hasPermission('access printfriendly')`. For `teaser` it links to
  `/node/{id}`; otherwise `printfriendly_create_button()` uses the current path + query.
- **`printfriendly_create_button()`** returns markup:
  `<a href="https://www.printfriendly.com/print?url={current_url}"><img src="{cdn or custom image}"></a>`.
  The URL is built with `Url::fromUri($base_url . $path, ['query' => $query])->toString()`
  (query values are URL-encoded by `toString()`).

## Notes for agents

- Set config with `drush cset printfriendly.settings <key> <value>` or via
  `\Drupal::configFactory()->getEditable('printfriendly.settings')`.
- The inline `pf*` JS values (custom header URL, tagline, custom CSS URL) come from
  `administer printfriendly` (a `restrict access: true` admin) — trusted-admin config placed into
  an inline script. Document as admin-only; not treated as an XSS finding here.
- Third-party dependency: the widget, button images and printable rendering come from
  PrintFriendly.com; the page URL is sent to their service. Password-protected or JS-rendered
  content needs a PrintFriendly Pro subscription.
