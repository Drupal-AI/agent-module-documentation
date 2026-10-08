# Configuration

Getting Patternkit working has two halves: **registering a pattern library** (a
developer/site‑builder step done in a `libraries.yml` file) and **managing it from
the admin settings** (keeping cached patterns in sync and controlling who can build
with them). This page covers both, plus the permission and security points that
matter.

## Open the settings form

1. Log in as a user with the appropriate administrative permission.
2. Go to the **Patternkit** admin settings page (route `patternkit.settings`),
   under the site's configuration.

The settings page is where you manage library settings and can **update the entire
library at once** — useful after you change templates or schemas (see "Keeping
patterns in sync" below).

## Register a pattern library

Patternkit discovers patterns from a library declared in any installed theme's or
module's `*.libraries.yml`. You add a `patterns` section pointing at where your
templates live, and add a JSON Schema file next to each Twig template. The steps:

1. In your theme or module's `libraries.yml`, add a `patterns` entry. For a
   directory of Twig templates:

   ```yaml
   my_library:
     version: VERSION
     css:
       theme:
         dist/css/example.css: {}
     js:
       dist/js/example.min.js: {}
     # Enables Patternkit and Twig namespaces:
     patterns:
       src/patterns: {plugin: twig}
   ```

   Templates can live anywhere relative to the theme or module root — you can even
   reuse your existing theme templates.

2. For each Twig template you want to expose, add a **JSON Schema** (Draft 4+) file
   with the same name in the same directory — for example
   `src/patterns/mypattern/mypattern.twig` alongside
   `src/patterns/mypattern/mypattern.json`. The schema drives the editor form used
   to fill the pattern's fields.

3. **Clear caches.** The pattern should then appear as a block in the block list
   and in Layout Builder.

For libraries that need no additional CSS/JS (for example a folder of SVGs), add
`drupalSettings: {}` to keep Drupal from erroring on load and use the appropriate
plugin (for example `{plugin: file.svg}`).

## Build pages with patterns

Once a pattern shows up as a block, place it like any block — via **Structure →
Block layout** or in **Layout Builder** — and use its schema‑driven form to fill
the fields. You can insert Drupal **tokens** into pattern fields to pull values
from context such as the current node, user, or language.

## Keeping patterns in sync

When a pattern block's configuration is saved, Patternkit **caches the template in
the database** — both to survive an origin failure and to lock in the template
version at configuration time. When you later change a schema or template:

- Update an individual block by editing it and clicking **Update**.
- Update **the entire library at once** from the Patternkit admin library settings.

## Who can build with patterns

Patternkit provides its own permission governing who may place and configure
patterns. Grant it only to **trusted editors** — see the security note below for
why this matters.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant Patternkit's permission to the roles that should be allowed to place and
   configure patterns.
3. Save permissions.

## Security: escape editor‑supplied values

Patternkit renders patterns using field values supplied by editors. If a pattern's
Twig template outputs those values without escaping, editor input could inject
markup or scripts (**cross‑site scripting**). Two rules follow:

- Make sure every pattern template **escapes** the values it renders. Twig's
  autoescaping helps, but review any place a template deliberately outputs raw
  markup.
- **Restrict** who can place and configure patterns to trusted editors via the
  permission above.

Remember this project does not carry official security‑advisory coverage, so keep
it updated and review your templates yourself.
