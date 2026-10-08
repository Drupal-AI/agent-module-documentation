<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Search Exclude

Search Exclude has **no settings page of its own**. It is used by creating a core
**Search page** (`search.page.*` config entity) that uses its plugin.

## Where the state lives

```yaml
# config: search.page.<id>
id: my_search
label: 'Content (exclude)'
path: node-exclude          # the URL becomes /search/<path>
plugin: search_exclude_node_search
status: true
weight: 0
configuration:
  excluded_bundles:         # map of bundle => bundle; only truthy entries count
    page: page
    landing: landing
  rankings: {}              # inherited from core NodeSearch
```

Which page `/search` lands on is core config: `search.settings:default_page`.

## Via the UI (README steps)

1. `/admin/config/search/pages` → **Add search page**.
2. Choose **Content (Exclude)** as the search type; give it a label, a machine name and a path.
3. In **Exclude content types**, tick the content types to keep out of the index. Save.
4. Disable the default **Content** search page and set your new page as the **default**.
5. Re-index (`/admin/config/search/pages` → *Re-index site*, or `drush search:index`).

## Create it with Drush (scriptable)

```bash
drush php:eval '
  use Drupal\search\Entity\SearchPage;
  SearchPage::create([
    "id" => "node_exclude",
    "label" => "Content (exclude)",
    "path" => "node-exclude",
    "plugin" => "search_exclude_node_search",
    "status" => TRUE,
    "configuration" => [
      "excluded_bundles" => ["page" => "page"],
      "rankings" => [],
    ],
  ])->save();
'
# make it the site default and turn core Content search off
drush cset search.settings default_page node_exclude -y
drush php:eval '\Drupal\search\Entity\SearchPage::load("node_search")->disable()->save();'
```

## Read the current setup

```bash
drush cget search.page.node_exclude
drush cget search.page.node_exclude configuration.excluded_bundles
drush cget search.settings default_page
# list every search page and its plugin:
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("search_page")->loadMultiple() as $p) {
  printf("%s plugin=%s status=%d\n", $p->id(), $p->getPlugin()->getPluginId(), $p->status());
}'
```

## Change the excluded list on an existing page

```bash
drush php:eval '
  $p = \Drupal\search\Entity\SearchPage::load("node_exclude");
  $c = $p->get("configuration");
  $c["excluded_bundles"] = ["page" => "page", "article" => "article"];
  $p->set("configuration", $c)->save();
'
drush search:index          # or wait for cron
```

## Gotchas

- `excluded_bundles` is a **keyed map**, not a list. The form uses `#type: checkboxes`, so
  unticked boxes arrive as `0` and are dropped by `array_filter()` in
  `submitConfigurationForm()`. Writing a plain list works for the query but not for the form's
  `#default_value`.
- Excluding a type does **not** delete rows already in `search_dataset` for it — re-index
  (`drush search:index --reindex` / *Re-index site*) after changing the list.
- Each search plugin indexes under its own `type` key in `search_dataset`
  (`search_exclude_node_search`), so switching from core `node_search` means the new page
  starts from an empty index.
- Leaving `excluded_bundles` empty makes the plugin behave exactly like core `NodeSearch`.
- The module only helps *core* Search. It has no effect on Search API / Solr indexes.
