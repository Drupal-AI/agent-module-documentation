# Configuration

Libraries Provider is configured in two complementary ways: you **declare** a
library's defaults in YAML, and you **adjust** those choices through the optional
UI. This page covers both.

## Declaring a library in YAML

In a module or theme's `*.libraries.yml`, add a `libraries_provider` section to
the library you want the site to manage. For example, to load Font Awesome from
jsDelivr:

```yaml
fontawesome:
  remote: https://github.com/FortAwesome/Font-Awesome
  version: 5.8.0
  css:
    base:
      https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.8.0/css/all.min.css:
        type: external
        minified: true
  libraries_provider:
    enabled: true
    source: cdn.jsdelivr.net
    npm_name: '@fortawesome/fontawesome-free'
```

The keys under `libraries_provider` set this library's **defaults**:

- **`enabled`** — when the library is attached, its assets are only actually
  loaded if this is true. Set it to false to disable an optional library or to
  hand things over to a replacement.
- **`source`** — the ID of the plugin that serves this library by default. It must
  match the URLs you gave for the CSS/JS above. The module ships plugins for the
  **jsDelivr CDN** and for **local libraries** in the site's `/libraries` folder;
  other sources can be added by other modules.
- **`npm_name`** — the library's package ID on npm, used to look up available
  versions.

Additional properties you can set:

- **`minified`** — `never`, `always`, or `when_aggregating` (the default).
  Change this when the upstream release only ships minified (or only unminified)
  files.
- **`blacklist_releases`** — a list of versions to hide from the version picker
  (for example a broken or insecure upstream build).
- **`variants_available`**, **`variant_regex`**, **`variant`** — declare the
  variations of a library, the part of the path that changes between variants, and
  the default variant.
- **`replaces`** — the ID(s) of other libraries this one replaces, so the same
  base library isn't loaded twice (handy when a CSS skin already bundles its base
  library). Library IDs take the form `NAMEOFMODULEORTHEME__KEYOFTHELIBRARY` —
  note the **two** underscores; the key part comes from the `.libraries.yml` file.

## Changing choices through the UI

With the **Libraries Provider UI** submodule enabled, you can make these choices
through an administrative interface instead of editing YAML — for each library,
pick whether to load from the CDN or a local copy, update the version, and choose
a variant where options exist. This is the place to switch a library's source to
meet a CSP, privacy, or offline requirement without patching any code.

## Remember: enabled ≠ always loaded

Marking a library `enabled` does not cause it to load on every page. It still
only loads where a module or theme **attaches** it. Libraries Provider governs
*how* an attached library is served, not *whether* it is attached.
