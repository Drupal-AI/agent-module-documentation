# Configuration

Tab Tamer works by creating one small **Tab Tamer** configuration entity per route
whose tabs you want to control. Each entity is managed at **Structure → Tab tamer**
(`/admin/structure/tab-tamer`), and every screen requires the **Administer Tab
Tamer** permission.

## Add a Tab Tamer for a route

There are two ways to start:

- **The easy way** — while viewing the page whose tabs you want to change, click the
  **Add tabtamer** tab. The add form opens with the **Route name** already filled in
  for that page.
- **From the collection** — go to **Structure → Tab tamer** and click **Add tabtamer**,
  then type the **Route name** yourself (the route machine name, for example
  `entity.node.canonical` for node pages or `entity.user.canonical` for user
  profiles).

When the route name is set, the form loads that route's local tasks live and shows
one row per tab.

## Per‑tab settings

For each tab in the table you can set:

- **Tab** — the tab's underlying plugin id, shown read‑only so you know which tab the
  row refers to.
- **Link title** — the text to display for the tab. Change it to relabel, for
  example "View" to "Read".
- **Weight** — drag rows to reorder the tabs; lower weights appear first.
- **Display** — a checkbox. Leave it ticked to show the tab; **untick it to hide the
  tab** from everyone on that route.

Give the entity a machine name (it defaults to the route name with dots replaced by
underscores) and an **Enabled** state, then **Save**.

## The Enabled flag (note for config sync)

Each Tab Tamer entity has an **Enabled** on/off toggle that switches the whole
entity's effect on or off without deleting it. Be aware that this `status` flag is
intentionally **not** part of the exported configuration — only the `id`, the route
`label`, and the `tabs` are exported. So if you move config between environments, set
the enabled state on each environment as needed; it will not travel with a
configuration export/import.

## How your changes are applied

When a page renders, Tab Tamer finds the enabled entity matching the current route
and, for each configured tab, applies your new weight and link title, and hides any
tab whose **Display** you unchecked. It only ever relabels, reorders, or hides —
**it never grants access** to a tab a user could not otherwise see, so hiding is
presentation only and does not replace the route's own access checks.

## Managing in code

Because it is a configuration entity, a Tab Tamer can be exported and deployed as
`tabtamer.tab_tamer.*` config, or created programmatically:

```php
\Drupal::entityTypeManager()->getStorage('tab_tamer')->create([
  'id' => 'entity_node_canonical',
  'label' => 'entity.node.canonical',
  'tabs' => [
    ['id' => 'entity.node.canonical', 'label' => 'entity.node.canonical', 'link' => 'Read', 'weight' => -10, 'access' => TRUE],
    ['id' => 'entity.node.delete_form', 'label' => 'entity.node.delete_form', 'link' => 'Delete', 'weight' => 10, 'access' => FALSE],
  ],
])->save();
```
