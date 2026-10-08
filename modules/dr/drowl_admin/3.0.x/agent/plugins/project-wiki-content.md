<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drowl_admin — ProjectWiki content plugin (soft dependency)

`src/Plugin/ProjectWikiContentPlugins/DrowlAdminProjectWikiContents.php`

A single plugin, id **`drowl_admin`**, annotated `@ProjectWikiContent`. It extends
`Drupal\project_wiki_markdown_content\Plugin\ProjectWikiMarkdownContentPluginBase`, which comes from
the **contributed `project_wiki_markdown_content` module**. That module is **not** listed in
`drowl_admin.info.yml` dependencies, so this is an optional/soft relationship: the plugin only
resolves and does anything when `project_wiki_markdown_content` is also installed. On a plain
drowl_admin install (as here) the class simply is not discovered as a usable plugin.

## What it contributes

The class overrides one method:

```
public function getEntriesDirectoryPath() {
  return $this->moduleHandler->getModule('drowl_admin')->getPath()
    . "/docs/project_wiki_markdown_content";
}
```

It just points the base plugin at the module's own bundled Markdown directory,
`docs/project_wiki_markdown_content/`. All discovery, parsing and rendering of those Markdown files
is done by the base module — this class adds no rendering, no user input, no external calls.

## Bundled content

The directory ships one file, `entity_display_configuration.md` (front matter
`isDeveloperContent: TRUE`), documenting DROWL field-display CSS class conventions for editors, e.g.:
- `field__label--colon` — append a colon to a field label.
- `field-items--inline` / `field-items--inline-comma` — lay field items side by side (optionally
  comma-separated).
- `field--label-column` — render label and value in separate columns.

These are static, module-authored docs surfaced inside a project wiki; they configure nothing on
their own.
