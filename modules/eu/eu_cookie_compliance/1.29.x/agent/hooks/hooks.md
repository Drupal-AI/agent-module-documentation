# Hooks (`eu_cookie_compliance.api.php`)

Four alter hooks let you override banner logic in custom code.

- `hook_eu_cookie_compliance_geoip_match_alter(&$geoip_match)` — override the EU‑country
  decision (e.g. set `$geoip_match['in_eu'] = FALSE`) when using GeoIP‑based display.
- `hook_eu_cookie_compliance_path_match_alter(&$excluded, $path, $exclude_paths)` — take full
  control of whether the current path is excluded from the banner.
- `hook_eu_cookie_compliance_show_popup_alter(&$show_popup)` — advanced logic to force‑show or
  hide the banner (e.g. hide on a specific node type).
- `hook_eu_cookie_compliance_cid_alter(&$cid)` — vary the cache id used to store banner data
  (e.g. per content type/context).

Implement in `my_module.module`; each receives its argument by reference.
