<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling & configuring Vite

There is **no admin form**. Vite is turned on and tuned in three places: the extension's
`.info.yml`, its `*.libraries.yml`, and `settings.php`. A library is only rewritten if it
resolves to enabled (see resolution order at the bottom).

## 1. Enable for a whole theme/module (`*.info.yml`)

```yaml
# my_theme.info.yml
vite:
  enableInAllLibraries: true   # all normal asset libraries
  enableInAllComponents: true  # all SDC component libraries
```

`vite: true` (a bare boolean) is also accepted and means "enabled".

## 2. Enable / configure a single library (`*.libraries.yml`)

Replace built paths with **source** paths and opt in:

```yaml
global-styling:
  vite: true            # shorthand
  js:
    src/script.ts: {}
  css:
    component:
      src/scss/style.scss: {}
```

Or a config map for fine control:

```yaml
global-styling:
  vite:
    enabled: true
    viteRoot: '/..'                 # vite root; '/'-prefixed = relative to Drupal root, else to extension dir
    distDir: 'web/libraries/dist'   # build output dir relative to viteRoot (default: dist)
    manifestPath: 'manifest.json'   # relative to distDir (default: .vite/manifest.json)
    baseUrl: 'https://cdn.example.com/dist/'  # serve dist assets from here instead of a resolved local path
    devServerUrl: 'http://localhost:9999'     # default http://localhost:5173
    devDependencies:                # libraries attached only in dev mode (e.g. @react-refresh preamble)
      - mymodule/reactapp.devmode
```

Exclude a single asset inside an otherwise Vite-managed library:

```yaml
  js:
    src/script.ts: {}
    some/static/script.js: {vite: false}
```

Assets are skipped automatically when the path is absolute (`/…`), starts with `http`, or is
`type: external`.

## 3. Global defaults & overrides (`settings.php`)

```php
$settings['vite'] = [
  'useDevServer' => 'auto',   // 'auto' (probe), true (force dev server), false (always dist)
  'devServerUrl' => 'http://localhost:9999',
  // Global toggles (note: 'enabled' => TRUE here turns Vite on for ALL libraries — rarely wanted):
  'distDir' => 'web/libraries/dist',
  'manifestPath' => 'manifest.json',
  'baseUrl' => '/dist/assets/',
  'overrides' => [
    'my_theme' => [ /* per-extension settings like above */ ],
    'my_theme/global-styling' => [ /* per-library settings */ ],
  ],
];
```

## Deprecated `manifest` key

The old `manifest:` key (complete path relative to `viteRoot`) still works but is deprecated;
prefer `distDir` + `manifestPath`:

```yaml
vite:
  manifest: 'app/dist/manifest.json'   # deprecated
```

## Resolution order (`AssetLibrary::shouldBeManagedByVite` / `resolveViteSetting`)

For enablement, later wins: settings global default → settings library-type default
(`enableInAllLibraries` / `enableInAllComponents`) → extension `.info.yml` default →
extension type default → library `vite` config → `$settings['vite']['overrides']`. For other
settings: settings default → extension definition → library config → settings overrides.

## Dev server vs dist

When `useDevServer` is `'auto'` (or unset), the module HTTP-probes
`{devServerUrl}/@vite/client` (1.5s timeout); a `200` means "use dev server" (HMR: assets point
at the dev server, `vite/vite-dev-client` + `devDependencies` are attached). Otherwise it reads
`manifest.json` and serves the hashed `dist` build. Library definitions are cached, so run
`drush cr` after starting/stopping the dev server or changing YAML.
