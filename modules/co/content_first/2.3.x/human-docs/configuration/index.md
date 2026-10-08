# Configuration

Content First has one settings form that controls which content gets the Content
First tab and what its clean output includes.

## Open the settings form

1. Log in as a user with the **Administer content_first** permission.
2. Go to **Configuration → Content authoring → Content First**, or navigate
   directly to `/admin/config/content/content-first`.

Settings persist in the `content_first.settings` config object.

## The settings

### Which entities get the tab

- **Nodes enabled** (default on) — whether nodes get the Content First tab.
- **Node bundles** (default: all) — restrict the tab to specific content types.
  Leave empty to allow all. A node whose type isn't allowed returns a 403 on the
  tab.
- **Menus enabled** (default on) and **Menus** (default: all) — the same controls
  for the menu Content First tab.

### Front matter

Front matter is the block of YAML metadata prepended to the Markdown output — handy
for mkdocs and LLM pipelines.

- **Markdown attributes** (default on) — the master switch: prepend YAML front
  matter to the Markdown. Turn it off to output body text only.
- **Entity properties** (default: `id, type, bundle, status, langcode, created,
  changed`) — which entity properties are included as front‑matter values.
- **Entity extra fields** (default: none) — additional field machine names to
  include as front‑matter attributes.
- **Allowed metatags** (default: `title, description, abstract`) — which metatags
  become front matter. Requires the Metatag module to have any effect.
- **Include menu link** (default off) — include menu‑link data in the front matter.

### Cleaning the HTML

- **Ignored selectors** (default: `nav.pager`, `ul.contextual-links`) — a list of
  CSS selectors whose matching elements are removed from the rendered HTML before
  it's converted to Markdown or simplified HTML. Add selectors here to strip
  regions you don't want in the output.

## Setting config with Drush

```bash
ddev drush cset content_first.settings markdown_attributes 1 -y
ddev drush cset content_first.settings 'entities.node.bundles.0' article -y
```

## Permissions

| Permission | Grant to | Controls |
|---|---|---|
| **View content_first content** | Roles that should read/export the clean output | The node Content First tab, the copy/download actions, and the ZIP download. (The tab additionally requires normal node‑view access and the node's bundle being enabled above.) |
| **Administer content_first** | Trusted admins | The settings form on this page (and clearing audit results if the audit submodule is enabled). |

Neither permission is marked as restricted. The menu Content First tab is instead
gated by the core **Administer menu** permission. Rendered output is escaped before
display, and node‑view access is enforced before anything is built.
