# Configuration

PDB has no admin settings form. "Configuring" it means three things: telling it where to
find your components, describing each component in its info file, and setting per-instance
options when you place a component's block. For the full component-authoring reference (all
the info-file keys, asset handling, and the discovery API), see the sibling
[`agent/`](../agent/start.md) docs — this page is the human-oriented overview.

## Where components are discovered

A component is a directory containing an info file whose `type` is `pdb`, for example:

```
my_components/hello/
├── hello.info.yml      # type: pdb, machine_name, presentation, add_js/add_css, …
└── hello.js
```

By default PDB scans the whole install for such directories. On a large site that is slow,
so you can restrict the search from `settings.php`:

```php
// settings.php — only scan these directories (relative to the Drupal root)
$settings['pdb_search_dirs'] = ['sites/default/components', 'web/libraries/my-components'];
```

If you set this, only the listed directories are scanned. Developers can also add search
directories at runtime through a `PdbDiscoveryEvent` subscriber, or adjust discovered
component metadata with `hook_component_info_alter()` — both are covered in the agent docs.

After adding or moving components, clear caches (`drush cr`) so PDB rediscovers them. A
component with `status: disabled` in its info file is skipped and does not become a block.

## Placing and configuring a component block

Once a component is discovered it appears as a block:

1. Go to **Structure → Block layout** (or add a block in Layout Builder).
2. Find your component under its category (declared in the info file, or the provider name)
   and place it.
3. If the component's info file declares a `configuration` section, the block form shows
   those fields — this is the per-instance settings form the component author defined (for
   example a "Greeting" text field). Fill them in and save.

The values you enter are stored on the block and passed to the front-end component through
`drupalSettings`, so the same component can be reused with different settings in different
places.

> **Security note for component authors.** The per-block settings form is built directly
> from the component's `configuration` info with no property allow-list, so treat component
> info files as trusted code (they live on disk, like module code). When a component
> declares Drupal `contexts` (for example the current node), PDB clones the entity and
> checks view access field by field before exposing it, nulling any field the current user
> may not see — so unviewable field data is not leaked to the browser.

## Assets

A component's `add_js` / `add_css` entries are built into header/footer asset libraries
automatically, and each automatically depends on the framework runtime library provided by
your presentation module. Entries marked `type: external` are kept as absolute (CDN) URLs.
You do not configure this in the UI — it comes from the component's info file.
