# Node Link Report — agent index

A block that renders a node, extracts its anchors, and cURLs each to report broken / redirected /
unpublished / skipped links plus link-accessibility issues. One block plugin, one settings form, one
permission. Depends on core `path_alias` and PHP's DOM extension. No Drush, no config schema, no plugin types.

- **Settings keys, the block, placement, permission, cache behavior, how link checking works** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Block plugin id `node_link_report_block` (admin label "Node Link Report"); renders ONLY on
  `entity.node.canonical` / `entity.node.edit_form` / `entity.node.preview`, each toggled by a setting,
  and only for the `view node link report` permission (`restrict access: FALSE`).
- Settings config object `node_link_report.settings`; form route
  `node_link_report.node_link_report_admin_form` at `/admin/config/content/node_link_report`
  (permission `administer content`). No `config/install` defaults ship; keys default to empty/false.
- Service `node_link_report.link_checker` (`Drupal\node_link_report\Service\LinkChecker`) does the DOM
  parse + `curl_multi_*` HEAD checks; results cached 24h in `cache.default`, tag `node_link_report`.
- Theme hook `node_link_report_block` (template `templates/node-link-report-block.html.twig`); library
  `node_link_report/node-link-report`.
- Links are tested as anonymous; non-anonymous-visible targets read as broken. Checker relies on
  `curl` and `DOMDocument` (phpDom).
