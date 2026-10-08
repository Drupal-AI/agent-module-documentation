# Configure Node Link Report

## Setup (3 steps)
1. Grant `view node link report` to roles that should see the report (`/admin/people/permissions`).
2. Place the **Node Link Report** block (`node_link_report_block`) in a region at `/admin/structure/block`.
   The block self-limits to node view/edit/preview routes per settings below.
3. Tune settings at `/admin/config/content/node_link_report` (needs `administer content`).

## Settings — config object `node_link_report.settings`
No `config/install` file ships, so every key starts unset (empty/false) until the form is saved.

| Key | Type | Meaning |
|---|---|---|
| `enable_check_external_links` | bool | If off, external links are skipped entirely (only internal checked). |
| `enable_reporting_good_links` | bool | Also list links that passed. |
| `enable_reporting_skipped_links` | bool | List links skipped (mailto/tel/sms/im + excluded). |
| `enable_reporting_inaccessible_links` | bool | Run + show the link-accessibility pass. |
| `accessibility_guidance_url` | string | Optional URL shown as guidance next to a11y issues. |
| `accessibility_guidance_link` | string | Link text for the guidance URL. |
| `display_on_node_view` | bool | Allow block on `entity.node.canonical`. |
| `display_on_node_edit` | bool | Allow block on `entity.node.edit_form`. |
| `display_on_node_preview` | bool | Allow block on `entity.node.preview`. |
| `user_agent` | string | User-Agent for the cURL checks (default `Drupal:Node Link Report link_checker`). |
| `additional_domains_as_internal` | string | Newline list of extra hosts treated as internal. |
| `decoupled_frontend` | string | Alternate frontend origin (`https://www.example.com`) to re-check "broken" internal links against. |
| `domains_to_skip` | string | Newline list of external hosts to skip. |
| `path_patterns_to_skip` | string | Newline path patterns to skip, `*` wildcard per segment (e.g. `/node/*/edit`, `/user/*`). |

The form stores the three `allow_display_on` checkboxes into the `display_on_node_*` keys, and
dedupes/sorts the three multiline lists (comma or newline separated) before saving. Saving invalidates
cache tag `node_link_report` (clears all cached reports).

Drush example:
```
drush cset node_link_report.settings enable_check_external_links 1 -y
drush cset node_link_report.settings display_on_node_view 1 -y
```

## How a report is produced (service `node_link_report.link_checker`)
1. Loads the current node (from `entity.node.canonical`/`edit_form`, or `node_preview` param).
2. Renders it with a bogus view mode `bogus-view-mode-12345-gibberish` so no page template runs, then
   parses the HTML with `DOMDocument::loadHTML`.
3. Accessibility pass over all `<a>`: empty href, empty/undescriptive text, image-only links missing alt.
4. Dedupes anchors by href; drops `mailto`/`tel`/`sms`/`im` (→ skipped), self URLs, and skip-pattern URLs.
5. `curl_multi_*` HEAD requests (10s timeout, follow up to 10 redirects, `SSL_VERIFYHOST` off /
   `SSL_VERIFYPEER` on). 400/405/501/503 → retried as a full GET.
6. Classifies each: `good`, `redirected` (2xx/3xx but different effective URL, ignoring trailing slash),
   `unpublished` (internal fail whose path resolves to an unpublished entity), else `bad`. Optional
   decoupled-frontend re-check can rescue an internal "bad" as good.
7. Renders theme `node_link_report_block`; caches the render array 24h (tags `node_link_report`,
   `node:{nid}`) unless it's a preview. Node save invalidates `node:{nid}`.

## Permission
`view node link report` (title "View Node Link Report", `restrict access: FALSE`) — gates block
visibility only. The block's `blockAccess()` returns forbidden off the allowed node routes, and
otherwise `allowedIfHasPermission('view node link report')`.
