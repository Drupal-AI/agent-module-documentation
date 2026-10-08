# Configuration

Script Manager has no traditional settings form — you configure it by creating
and managing individual **script** snippets. Each snippet is a small
configuration entity, so it can be exported and deployed with your other config.

## Open the snippet list

1. Log in as a user with the **Administer scripts** permission (an administrator
   by default).
2. Go to **Structure → JavaScript Snippets**, or navigate directly to
   `/admin/structure/scripts`.

You'll see a list of every snippet you've created, with links to add, edit, and
delete.

## Add a snippet

Click **Add** (`/admin/structure/scripts/add`) and fill in the form:

- **Label** *(required)* — a human-friendly name, e.g. "Google Analytics". Shown
  only in the admin list.
- **Machine name** — the internal id, generated from the label. It cannot be
  changed after the snippet is created.
- **Position** *(required)* — where the snippet is injected:
  - **Top** — rendered near the top of the page (the `<head>` region), for things
    like a Google Tag Manager container or a verification meta tag.
  - **Bottom** — rendered near the end of the page (before `</body>`), the usual
    place for analytics and most tracking tags.
  - **Not shown** — the snippet is never rendered. Use this to temporarily
    disable a snippet without deleting it.
- **Snippet** *(required)* — the actual HTML/JavaScript, including its
  `<script>…</script>` tags. **This is emitted exactly as you type it, without
  escaping**, so paste vendor code carefully and only add code you trust.
- **Visibility** — a set of vertical tabs identical to core block visibility (see
  below). Leave everything blank to show the snippet on every non-admin page.

Click **Save**. The snippet takes effect immediately on front-end pages.

## Scope a snippet with visibility rules

The **Visibility** section lets you limit where a snippet runs, using Drupal's
standard condition plugins — the same ones you see when placing a block:

- **Pages** (request path) — restrict to, or exclude, specific paths (e.g. only
  `/blog/*`, or everywhere *except* a section). Each condition can be negated.
- **Roles** — show the snippet only to users in chosen roles.
- **Languages** — show the snippet only for chosen languages.

When you set more than one condition, they are combined with **AND** logic — a
snippet renders only where *all* its conditions pass. An empty visibility set
means "always visible" (on non-admin pages). Note that snippets are **never**
output on admin routes, regardless of your rules — so tracking code won't fire in
the back end.

## Reference a snippet from a content field (optional)

Script Manager also provides a **Script Formatter**. If you add an
entity-reference field that targets the `script` entity type, you can display a
referenced snippet wherever that field appears — independently of the top/bottom
page placement. As with page placement, the snippet content is authored by
someone with the **Administer scripts** permission.

## Restricting which visibility conditions appear (advanced)

There is one module-level setting, `enabled_visibility_plugins` in the
`script_manager.settings` config object, which controls *which* condition plugins
are offered on the snippet form. There is no UI for it; the default (an empty
list) offers all applicable conditions. To restrict the list, edit the config
directly — for example via a `script_manager.settings.yml` in your config sync
directory, or with `drush config:set`.

## Create a snippet from the command line (optional)

You can create snippets programmatically instead of clicking through the form —
handy for scripted deployments:

```bash
ddev drush php:eval "\Drupal::entityTypeManager()->getStorage('script')->create([
  'id' => 'ga',
  'label' => 'Google Analytics',
  'position' => 'bottom',
  'snippet' => '<script>/* your tag here */</script>',
  'visibility' => [],
])->save();"
```

To scope it, populate `visibility` with a condition's configuration, for example
`'visibility' => ['request_path' => ['id' => 'request_path', 'pages' =>
'/blog/*', 'negate' => false]]`. You can also export the snippet as YAML
(`script_manager.script.<id>.yml`) and import it with `drush cim` on other
environments.
