# Configuration

All of Bootstrap Library's behaviour is controlled from one form at **Configuration →
Development → Bootstrap Library** (`/admin/config/development/bootstrap_library`),
which requires the **Administer site configuration** permission. This page walks
through each setting.

> **Important — nothing loads by default.** The shipped defaults set the theme rule to
> "all themes except the ones listed" with an *empty* list, which — because of how the
> rule is evaluated — actually means **nothing is attached** until you either pick one
> or more themes or flip the theme rule. So expect to configure the visibility
> settings before Bootstrap appears on your pages.

## Where Bootstrap comes from

### Load Bootstrap from CDN

A select list. Choose **Load locally** (the default) to use files installed on your
server, or pick a specific **Bootstrap version** (e.g. 5.2.3, 4.6.0, 3.3.7, …) to
load that version from a CDN. Selecting a CDN version **overrides** the "minimized"
build choice below — the CDN provides its own assets. Pin an exact version here so
you can stage a Bootstrap 4 → 5 upgrade by simply switching the number and testing.

### Minimized (local build)

Radio options controlling which *local* build is attached (ignored when a CDN version
is selected):

- **Source** — the non‑minified build. Good for development and readable stack traces.
- **Minified** — the minified build. Best for production.
- **Composer** — use the `twbs/bootstrap` Composer layout (files under
  `/libraries/bootstrap/dist/…`).

## Theme visibility — which themes load Bootstrap

- **Themes Visibility** — a radio choice:
  - *All themes except those listed* — Bootstrap loads everywhere except the themes
    you pick (invert mode).
  - *Only the listed themes* — Bootstrap loads only on the themes you pick.
- **List of themes** — a multi‑select of your installed themes. Combined with the
  radio above, this is how you keep Bootstrap on your front‑end theme but off the
  admin theme (Claro/Gin), or load it everywhere except a legacy theme.

Because of the default (invert mode with an empty list), you must pick at least one
theme — or switch to "only the listed themes" and choose one — for anything to load.

## Page visibility — which URLs load Bootstrap

- **Activate on specific URLs** — a radio choice:
  - *All pages except those listed* — load Bootstrap everywhere except the listed
    paths (the shipped default).
  - *Only the listed pages* — load Bootstrap only on the listed paths.
- **Pages** — a textarea, one path per line. Wildcards (`*`) and `<front>` are
  supported, and paths are matched against both the internal path and its alias. The
  shipped default list excludes admin pages, image browsers, node add/edit forms,
  print pages and AJAX endpoints:

  ```
  admin*
  imagebrowser*
  img_assist*
  imce*
  node/add/*
  node/*/edit
  print/*
  printpdf/*
  system/ajax
  system/ajax/*
  ```

To load Bootstrap only on a campaign section, for example, switch the radio to *Only
the listed pages* and list `/campaign` and `/campaign/*`.

## Files settings

Two checkboxes (CSS / JS) appear under a *Files Settings* section. **Note:** in this
version these are saved but **not actually consulted** by the attach logic — both the
CSS and the JS always load. Treat them as a no‑op.

## Save and the one‑off disable switch

Click **Save configuration**, then clear caches (`drush cr`) so the new library
attachment takes effect. To disable Bootstrap for a single request while debugging a
style clash, append `?bootstrap=no` to any URL.

## Reading and writing the settings with Drush

```bash
# read everything (or one key)
drush cget bootstrap_library.settings
drush cget bootstrap_library.settings minimized.options

# example: load only on /campaign and below, in the Olivero theme, non-minified
drush cset bootstrap_library.settings url.visibility 1 -y
drush php:eval '
  \Drupal::configFactory()->getEditable("bootstrap_library.settings")
    ->set("url.pages", ["/campaign", "/campaign/*"])
    ->set("theme.visibility", 1)
    ->set("theme.themes", ["olivero" => "olivero"])
    ->set("minimized.options", 0)
    ->save();
'
drush cr
```

> If you set a **CDN version** from code, you must also write the accompanying CDN URL
> blob (`cdn.options`) — the settings form does this automatically via a hidden field,
> so using the form is the safest way to switch to CDN. Setting the version without the
> blob breaks the CDN library build.

## A note on config schema

This version's config schema file is malformed (it is missing an intermediate mapping
level under `theme`, `url`, `minimized`, `cdn` and `files`), so strict typed‑config
validation may warn about these keys and the values are effectively untyped. It does
not stop the module working; it just means you should not rely on schema validation
for these settings.
