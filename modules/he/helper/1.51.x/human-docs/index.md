# Helper — manual setup guide

**Helper** (`helper`) is a developer toolkit module — a grab‑bag of reusable
services, static utilities, form elements, blocks, Twig helpers, Drush commands,
and opt‑in behavior tweaks for building Drupal sites and modules. It ships **no
user‑facing feature of its own**; instead it provides code‑level building blocks
that other modules and custom code can lean on so you write less boilerplate.

On the API side it offers injectable services for common chores: programmatic
config import/export (`helper.config`), entity lookups and option lists and
reference‑selection handlers (`helper.entity`, `helper.entity_type`,
`helper.current_entity`), building render‑ready menus (`helper.menu`), creating or
reusing managed files and data URIs (`helper.file`), tweaking a text format's
allowed tags (`helper.text_format`), plus Layout Builder and Pathauto helpers and
a set of static utility classes (`ArrayHelper`, `Utility`, `Html`, `Field`). It
also adds a `helper_entity_select` form element, two blocks
(`helper_node_field`, `helper_context_entity`), Twig helpers (a `format_bytes`
filter and a `file_data_uri` function), a `module_dependency` service tag, an
`_is_multilingual` route requirement, sub‑theme region inheritance, and
unique‑value validation constraints.

Helper also bundles a handful of **Drush commands** for managing module schema
versions, resetting post‑update hooks, and switching install profiles, plus a set
of optional behavior "helpers" you can toggle on — for example disabling HTML5
client‑side validation on all forms, hiding core's Layout Builder layouts, or
redirecting 403/404 entity views to the edit form. These toggles are stored in the
`helper.settings` configuration object, but there is **no settings form** — you
enable them in code or config.

This guide is written for a **human**. Because Helper is entirely a developer
toolkit, the practical reference — the full service list, the static helpers, the
Drush commands, and the behavior toggles with their keys — lives in the terse,
token‑cheap [`agent/`](../agent/start.md) docs. Start there when you want to
actually call something.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Helper has **no settings page, no permissions and no admin links**
(`configure: null`). Everything it offers is consumed from code, Twig, or the
command line, and the optional behavior toggles live in the `helper.settings`
config object without a UI.

## How to use it

Enable the module, then reach for whichever piece you need from code:

- **Inject a service** by type‑hinting its class, e.g. `Drupal\helper\Config` or
  `Drupal\helper\EntityType` — the class name is aliased to the matching
  `helper.*` service.
- **Use the Twig helpers** in templates, e.g.
  `{{ file.getSize()|format_bytes }}` or the `file_data_uri()` function.
- **Run the Drush commands**, e.g.
  `drush module:schema-version:get mymodule` or
  `drush install-profile:switch`.
- **Turn on a behavior helper** by adding its key to the `helper.settings`
  `enabled` map (for example `core_form_novalidate` or
  `redirect_entity_4xx_to_edit`).

See the [`agent/`](../agent/start.md) docs for the exhaustive list of services,
commands and toggle keys with their signatures.
