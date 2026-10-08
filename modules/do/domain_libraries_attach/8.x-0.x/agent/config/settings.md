<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-domain library assignment — config, service, and runtime attach

How Domain Libraries Attach lets you pick theme libraries per Domain record and load them at runtime.
Cites `domain_libraries_attach.routing.yml`, `.services.yml`, `.links.task.yml`, `.module`,
`src/DomainLibrariesManager.php`, `src/Form/LibrariesAttachConfigForm.php`.

## Install / enable

- `drush en domain_libraries_attach` (or via Extend). Requires the **Domain** module
  (`domain:domain`, from `drupal/domain`) — declared in `domain_libraries_attach.info.yml`.
- No install file, no default config, no config schema. Nothing is attached until you assign
  libraries on the settings form.

## Settings route & permission

- Route **`domain_libraries_attach.settings`** (`domain_libraries_attach.routing.yml`):
  path `/admin/config/domain/domain_libraries_attach`, form
  `\Drupal\domain_libraries_attach\Form\LibrariesAttachConfigForm`, title
  *"Domain libraries configuration"*, requirement `_permission: 'administer domains'`.
- `administer domains` is Domain's own site-builder permission — the same one that gates managing
  domain records. There is no module-specific permission.
- Surfaced as a local task tab **"Domain libraries settings"** (`domain_libraries_attach.admin` in
  `.links.task.yml`) on `base_route: domain.admin`, i.e. alongside the Domain records admin.

## The config form (`LibrariesAttachConfigForm`)

- Extends core `ConfigFormBase`; form id `domain_libraries_attach_config_form`. Editable config:
  **`domain_libraries_attach.settings`** (`getEditableConfigNames()`).
- `create()` injects `config.factory`, `config.typed`, the `domain_libraries_attach.manager`
  service, and the **`domain`** entity storage (`entity_type.manager->getStorage('domain')`).
  The constructor caches `domainStorage->loadOptionsList()`.
- `buildForm()` loops the domain options list and renders one `#type => 'fieldset'` per domain
  (title = domain name). Inside each is a control keyed `<domainId>_libraries`:
  `#type => 'select'`, `#multiple => TRUE`, `#options` = `manager->getOptionsList()`,
  `#default_value` = `config->get(<domainId>)`, label naming the default theme
  (`manager->defaultThemeName`). If no domains exist it shows *"Can't find any domain record"*.
- `submitForm()` writes, for each domain, `config->set(<domainId>, form_state->getValue(<domainId>_libraries))`
  then `config->save()`. So the config object maps **domain id → array of selected library names**
  (theme-prefixed, e.g. `mytheme/extra`).

## The manager service (`DomainLibrariesManager`)

Service **`domain_libraries_attach.manager`** (`.services.yml`), args
`config.factory`, `domain.negotiator`, `theme_handler`, `library.discovery`, `router.admin_context`.
Constructor sets `isAdminRoute` (from `AdminContext::isAdminRoute()`), `defaultThemeId`
(`themeHandler->getDefault()`) and `defaultThemeName`.

- `getAllLibraries($themePrefix = TRUE)` — `library.discovery`'s
  `getLibrariesByExtension(defaultThemeId)` keys; optionally prefixes each with `<themeId>/`.
- `getLibraries($themePrefix = TRUE)` — the "extra" libraries: `getAllLibraries()` **minus** the
  libraries the theme already auto-loads (`$theme->libraries` from its `*.info.yml`). If the theme
  declares no `libraries:` key, returns all discovered libraries.
- `getOptionsList()` — `[prefixedName => shortName]` for the form select
  (`array_combine(getLibraries(), getLibraries(FALSE))`); `[]` when none.
- `getLibrariesForCurrentDomain()` — resolves the active domain via
  `domain.negotiator->getActiveDomain()`, returns
  `config('domain_libraries_attach.settings')->get(<activeDomainId>)` (an array or NULL).

## How libraries get attached per domain (runtime)

`domain_libraries_attach.module` implements **`hook_page_attachments_alter(&$attachments)`**:

1. `$libs = manager->getLibrariesForCurrentDomain();`
2. If `manager->isAdminRoute` is TRUE **or** `$libs` is empty → return (no attach on admin routes /
   when nothing is configured for the active domain).
3. Otherwise `$attachments['#attached']['library'] = array_merge($attachments['#attached']['library'], $libs);`

Each attached name must be a library the active theme actually defines, since the option list is
built from that theme's discovered libraries. `hook_help()` (help page) renders the module README,
using the Markdown filter if the `markdown` module is enabled, else `<pre>`.

## How to configure (operator steps)

1. Declare the extra library in your default theme's `THEME.libraries.yml` (do **not** also list it
   under `libraries:` in `THEME.info.yml`, or it loads globally and drops out of the extra list).
2. Enable this module and Domain; create your Domain records.
3. Visit `/admin/config/domain/domain_libraries_attach` (needs `administer domains`).
4. In each domain's fieldset, select one or more libraries, then Save.
5. Load a front-end (non-admin) page on that domain — the selected assets are attached for that
   domain only.
