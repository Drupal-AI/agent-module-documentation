# Libraries (Libraries API) — manual setup guide

**Libraries** (`libraries`) provides a generic, module‑independent way for Drupal to
discover, version‑detect, and load external front‑end and PHP libraries. Many
external libraries (jQuery plugins, JS/CSS toolkits, PHP files) cannot be bundled
inside contrib modules for licensing reasons, and when several modules integrate with
the same library they need one shared place to describe and locate it. Libraries API
is that shared place.

It keeps each library's metadata — machine name, files, version, dependencies,
variants — separate from any single module and exposes it through the
`libraries.manager` service. In this Drupal 8+ rewrite, libraries are typed, classed
objects: a **library type** plugin (asset, multiple‑asset, PHP‑file) decides how a
library is registered and loaded, a **locator** plugin finds it on disk or by URI,
and a **version detector** plugin reads its version from a file. Library definitions
are discovered either as JSON fetched from a remote registry into
`public://library-definitions`, or as local YAML files. Asset library types register
the external assets with Drupal core's own library system so they can be attached to
render arrays. A module or theme declares that it needs a library by adding a
`library_dependencies` key to its `.info.yml` file.

Libraries is primarily a **developer tool** — an API other modules build on rather
than a feature you configure through the admin UI. It has **no configuration screen**
and **no permissions**: its behaviour is driven by library definitions (remote
registry URLs, a local definitions path, and global locators) stored in
configuration, plus the plugins and code that consume the `libraries.manager`
service. It has no dependencies beyond Drupal core and no submodules. It does provide
a legacy Drush command, `drush libraries-list`, to list registered libraries with
their install status, version, and variants. The old Drupal 7‑style
`hook_libraries_info()` still exists but is deprecated in favour of the plugin and
definition system.

This guide is written for a **human**. Because Libraries has no admin screens, the
real work is in code and configuration — for the developer‑facing detail (the
`libraries.manager` service, the plugin types, discovery configuration, and the Drush
command), read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page to open. After enabling the module, you work with it in one
of these ways:

- **As a site builder:** place an external library in the site‑wide `libraries`
  directory (or provide a definition for it), and Libraries' locator plugins find it.
  Enable local YAML definitions or the remote JSON registry to describe the libraries
  your modules need. Run **`drush libraries-list`** to see which libraries are
  registered and whether each is installed, its detected version, and its variants.
- **As a module or theme author:** declare that your extension needs a library by
  adding a `library_dependencies:` key to its `.info.yml`. Load or inspect a library
  in code via the manager service — for example
  `\Drupal::service('libraries.manager')->getLibrary($id)` — or extend the system by
  implementing a `LibraryType`, `Locator`, or `VersionDetector` plugin.

See the [`agent/`](../agent/start.md) docs for the exact services, plugin interfaces,
definition‑discovery configuration, and Drush usage.
