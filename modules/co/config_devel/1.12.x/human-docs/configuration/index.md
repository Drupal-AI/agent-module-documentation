# Configuration

## Open the settings form

1. Log in as a user with the core **Import configuration** permission (Config Devel
   defines no permission of its own).
2. Go to **Configuration → Development → Configuration development**, or navigate
   directly to `/admin/config/development/config_devel`.

The form has two text areas, corresponding to the two automated features. Both store
their values in the `config_devel.settings` object, and both start empty.

## Auto import

In the **Auto import** box, list the config **files** you want imported
automatically, one path per line. Paths are **relative to the Drupal root** (for
example `modules/custom/my_module/config/install/views.view.frontpage.yml`).

At the start of every request, Config Devel checks each listed file's hash and, if it
has changed since last time, imports it into active storage — the same result as
pasting it into core's *Single import* form. This lets you hand-edit a YAML file and
have the change apply on the next page load, no clicking required.

> **Note:** `system.site`, `core.extension`, and `simpletest.settings` are **not
> compatible** with auto-import and are rejected. This is unlikely to change.

## Auto export

In the **Auto export** box, list config **object names** (not filenames), one per
line — for example `system.site` or `views.view.frontpage`.

Whenever one of those objects is saved through the admin UI, Config Devel writes its
current value back out to the file(s) associated with it, so your UI edits land in
files under version control automatically. A single config object can be exported to
multiple target files if you list them for it.

Click **Save configuration** when you're done editing either box.

## Module (Features-like) export and import

To make a module own and ship a set of config objects, add a `config_devel:` section
to the module's `.info.yml` listing those object names, then use Drush to move them in
and out of the module's `config/install` (and `config/optional`) directory.

## Drush commands

| Command | Alias | What it does |
|---------|-------|--------------|
| `drush config:devel-export MODULE_NAME` | `cde` | Write the config objects listed in the module's `config_devel:` info section into its `config/install` / `config/optional` directory. |
| `drush config:devel-import MODULE_NAME` | `cdi` | Read that module's shipped config back into active storage. |
| `drush config:devel-import-one PATH` | `cdi1` | Import a single YAML file (or stdin) into active storage, deriving the object name from the filename. |

Examples:

```bash
# Export a custom module's owned config into its config/install directory
drush config:devel-export my_module

# Re-import a module's shipped config after editing the YAML
drush config:devel-import my_module

# Import one file
drush config:devel-import-one path/to/system.site.yml

# Pipe config from another environment via stdin
drush cdi1 system.site < file.yml
```

This is the practical way to build a reusable "feature" module: list its config in the
`config_devel:` info section, run `drush cde`, and the objects (content type, fields,
displays, views, …) are written into the module ready to install elsewhere.
