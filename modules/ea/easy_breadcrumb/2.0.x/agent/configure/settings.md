# Settings

![Easy Breadcrumb settings form](../../../../../../../screenshots/easy_breadcrumb/2.0.x/settings.png)

Config object `easy_breadcrumb.settings` (schema `config/schema/easy_breadcrumb.schema.yml`,
defaults in `config/install/easy_breadcrumb.settings.yml`, config-translation enabled).
UI: `/admin/config/user-interface/easy-breadcrumb` (route
`easy_breadcrumb.general_settings_form`, `EasyBreadcrumbGeneralSettingsForm`).
Read/write: `drush config:get easy_breadcrumb.settings` / `drush config:set easy_breadcrumb.settings <key> <value>`.

Key options (defaults from install config):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `applies_admin_routes` | bool | true | Also build breadcrumbs on admin pages. |
| `include_invalid_paths` | bool | false | Keep path segments that don't resolve to a valid route (as plain text). |
| `excluded_paths` | text | `''` | Newline list of paths to omit (module default: `search`, `search/node`). |
| `replaced_titles` | text | `''` | Map raw segment titles to friendlier synonyms. |
| `custom_paths` | text | `''` | Define fully custom breadcrumbs for specific paths. |
| `include_home_segment` | bool | true | Prepend a Home crumb. |
| `home_segment_title` | label | `Home` | Label for the Home crumb. |
| `home_segment_keep` | bool | false | Show the Home crumb on the front page too. |
| `hide_single_home_item` | bool | false | Hide the breadcrumb when only Home would show. |
| `use_site_title` | bool | false | Use the site name as the Home crumb label. |
| `include_title_segment` | bool | true | Append the current page title as the last crumb. |
| `title_from_page_when_available` | bool | true | Use the real page title instead of deducing it from the URL. |
| `title_segment_as_link` | bool | false | Render the current-page crumb as a link. |
| `alternative_title_field` | label | `field_breadcrumb_title` | Field to source a crumb title from, if present. |
| `use_menu_title_as_fallback` | bool | false | Fall back to a menu link title for the crumb label. |
| `use_page_title_as_menu_title_fallback` | bool | false | Fall back to page title when no menu title. |
| `menu_title_preferred_menu` | string | `''` | Menu to prefer as the menu-title source. |
| `remove_repeated_segments` | bool | true | Drop consecutive identical segments. |
| `remove_repeated_segments_text_only` | bool | false | Compare by text only (ignore URL) when de-duping. |
| `language_path_prefix_as_segment` | bool | false | Show the language prefix (`/en`) as its own crumb. |
| `absolute_paths` | bool | false | Emit absolute rather than relative segment URLs. |
| `term_hierarchy` | bool | false | Build crumbs from taxonomy term hierarchy. |
| `follow_redirects` | bool | true | Resolve redirects (needs Redirect module) to canonical URLs. |
| `capitalizator_mode` | string | `ucwords` | Segment casing: `none`, `ucfirst`, `ucwords`, `ucall`. |
| `capitalizator_ignored_words` | sequence | `of, and, or, de, del, y, o, a` | Small words kept lowercase. |
| `capitalizator_forced_words` | sequence | `{}` | Words forced to a fixed casing (e.g. brand names). |
| `capitalizator_forced_words_case_sensitivity` | bool | true | Match forced words case-sensitively. |
| `capitalizator_forced_words_first_letter` | bool | false | Only force the first letter. |
| `limit_segment_display` | bool | false | Cap how many segments render. |
| `segment_display_limit` | int | 0 | Max segments shown when limiting. |
| `segment_display_minimum` | int | 1 | Minimum segments to keep. |
| `truncator_mode` | bool | false | Truncate long segment labels. |
| `truncator_length` | int | 100 | Max label length when truncating. |
| `truncator_dots` | bool | true | Append `…` to truncated labels. |
| `add_structured_data_json_ld` | bool | false | Emit `BreadcrumbList` JSON-LD into the page head. |

Setting keys are also mirrored as constants in `EasyBreadcrumbConstants`.

## JSON-LD structured data
When `add_structured_data_json_ld` is true, `easy_breadcrumb_preprocess_block()` calls the
`easy_breadcrumb.structured_data_json_ld` service (`EasyBreadcrumbStructuredDataJsonLd::value()`)
and attaches a `<script type="application/ld+json">` `BreadcrumbList` to the head of the
`system_breadcrumb_block` output — useful for search-engine breadcrumb rich results.
