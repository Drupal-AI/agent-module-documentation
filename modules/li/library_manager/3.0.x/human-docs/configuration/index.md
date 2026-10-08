# Configuration

There are two things to set up: the module's **settings** (where generated files
are written) and the **per‑library options** you choose each time you build a
definition. Both matter, and one setting deserves particular care.

## The settings form

Open **Structure → Library → Settings** (`/admin/structure/library/settings`).

- **Libraries path** — the folder where the JS and CSS files you author get
  written, relative to the Drupal root. **Leave this at its default**
  (`sites/default/files/libraries/custom`) unless you have a specific reason to
  change it. The field is not validated, and a relative path such as `../something`
  will write files *outside* the docroot — which risks overwriting existing site
  assets and leaving stray files behind after the module is uninstalled. There is
  no good reason to point it outside the files directory, so don't.

## Permissions

Everything except the assets report is gated by the **Administer libraries**
permission, which is marked **restricted** in Drupal — and it should stay that
way. This module lets an administrator run **arbitrary JavaScript on every page by
design**, so grant the permission only to fully trusted administrators. The
assets report at **Reports → Libraries** is gated separately by the standard
**View site reports** permission.

## Building a library — the per‑file options

When you add or edit a definition under **Structure → Library**, you provide the
source and set options for each file:

- **Source** — add each asset **by code** (typed into the CodeMirror editor), **by
  upload**, **by local path**, or **by external URL**. File names you provide are
  validated to end in `.js` or `.css` (and rejected if they try to traverse
  directories), so this is not a route to writing other file types.
- **Preprocess** — whether the file participates in Drupal's aggregation and
  minification.
- **Minified** — declare that the file is already minified.
- **Header** — load the script in the page header rather than the footer.
- **`type="module"`** and **`nomodule`** — mark a script as an ES module, or as a
  fallback for browsers that don't support modules.
- **Weight** — control load order relative to other files.
- **Dependencies, version, licence** — declare which other libraries this one
  needs, and its metadata.

## Operations on a definition

Each library definition supports **build**, **export**, **duplicate**, and
**delete**, plus an assets‑check form. Duplicating an existing definition is a
quick way to start a new one; exporting is useful for moving a definition into
configuration deployment.

## Remember: this is configuration, not repository code

Anything you author here is site *configuration*. It exports and deploys with your
config, but it will not show up in a theme code review or a `grep` of the
repository. For code that belongs to the theme, put it in the theme; use Library
Manager for genuine site‑level configuration.
