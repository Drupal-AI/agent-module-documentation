<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Libraries Attach (domain_libraries_attach) — agent index

Attaches extra asset libraries from the **default theme** to specific **Domain** records, so each
domain loads its own additional CSS/JS on front-end pages. Package `Domain`. **Requires
`domain:domain`** (`drupal/domain`). Core requirement `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version dir 8.x-0.x (installed release `8.x-0.1-alpha7`, pre-1.0 alpha).

- **The settings route + permission, the config form + config object, the manager service, and how
  libraries get attached per domain** → [config/settings.md](config/settings.md)

## What it actually is

- One config form: `LibrariesAttachConfigForm` (`src/Form/LibrariesAttachConfigForm.php`, extends
  core `ConfigFormBase`), at route **`domain_libraries_attach.settings`** →
  `/admin/config/domain/domain_libraries_attach`, permission **`administer domains`** (from the
  Domain module). Exposed as a local task tab `domain_libraries_attach.admin` under `domain.admin`.
- One service: **`domain_libraries_attach.manager`** = `DomainLibrariesManager`
  (`src/DomainLibrariesManager.php`), built from `config.factory`, `domain.negotiator`,
  `theme_handler`, `library.discovery`, `router.admin_context`.
- One config object: **`domain_libraries_attach.settings`**, keyed by **domain id → array of
  theme-prefixed library names**. No config schema ships (no `config/schema/`).
- Two hooks in `domain_libraries_attach.module`: `hook_help()` (renders README on the help page) and
  **`hook_page_attachments_alter()`** (the runtime attach). No entities, plugins, permissions,
  Drush commands, or install file.

## Mechanism (from source)

- `hook_page_attachments_alter()` calls `manager->getLibrariesForCurrentDomain()`; if
  `manager->isAdminRoute` is TRUE or the list is empty it returns without attaching, otherwise it
  `array_merge`s the configured libraries into `$attachments['#attached']['library']`.
- `getLibrariesForCurrentDomain()` reads the **active domain** from `domain.negotiator`
  (`getActiveDomain()->id()`) and returns `config('domain_libraries_attach.settings')->get($domainId)`.
- The form builds one `#type => fieldset` per domain (`DomainStorage::loadOptionsList()`), each with a
  `#multiple` **`select`** whose `#options` come from `manager->getOptionsList()`. `submitForm()`
  saves each domain's selection under the domain id. Selectable libraries are the theme's declared
  libraries **minus** those the theme already auto-loads via its `*.info.yml` (`getLibraries()` diffs
  `getAllLibraries()` against `$theme->libraries`).

## Notes / caveats

- The default theme (`theme_handler->getDefault()`) is the sole library source; only that theme's
  `*.libraries.yml` entries appear. If it declares none, all discovered libraries are offered.
- No attachment happens on admin routes by design.
- Config is stored keyed by raw domain id with no schema, so `drush config:export` will emit the
  values but without typed-config validation.
