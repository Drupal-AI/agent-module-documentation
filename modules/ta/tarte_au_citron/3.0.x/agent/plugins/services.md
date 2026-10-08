# The `tarte_au_citron` service plugin type

The module defines one plugin type, managed by `ServicesManager` (a `DefaultPluginManager`, service
`tarte_au_citron.services_manager`). Each plugin represents a third-party service (analytics, video,
social, …) that consent gates.

- **Namespace:** `Plugin/tarte_au_citron`
- **Interface:** `Drupal\tarte_au_citron\ServicePluginInterface` (base: `ServicePluginBase`)
- **Annotation:** `@TarteAuCitronService(id, title)` (`src/Annotation/TarteAuCitronService.php`)
- **Alter hook:** `tarte_au_citron_services_info`
- **Cache:** plugin defs cached as `tarte_au_citron_plugins`

## You rarely implement one — the deriver does it for you

There is a single concrete plugin, `Plugin/tarte_au_citron/TarteAuCitron`, and it declares a **deriver**
(`TarteAuCitronServiceDeriver`). The deriver calls
`LibraryJsDiscover::getJsServices()` and emits one derivative **per service found in the library's
`tarteaucitron.services.js`**, so the full plugin id is `tarte_au_citron:<serviceKey>` (e.g.
`tarte_au_citron:gtag`). Each derivative carries a `title` and, if the library exposes
`tarteaucitron.user.<service>*` params, a `settings` array (rendered on the JS config form as textfields;
a param ending in `More` renders instructions to implement `hook_tarte_au_citron_<pluginId>_alter`).

Therefore, to add a service you normally just make sure it exists in the tarteaucitron.js library and
enable it on the settings form — no PHP plugin class required.

## Discovery (`LibraryJsDiscover`, service `tarte_au_citron.library_js_discover`)

Reads files from `web/libraries/tarteaucitron/` with regex, caching each result in the `services_js`
cache bin:

| Method | Reads | Returns |
|---|---|---|
| `getJsServices()` | `tarteaucitron.services.js` | service key → definition (+ `params`) |
| `getJsConfig()` | `tarteaucitron.js` (`defaults`, `parameters.*`) | config key → `{type, default_value, isUrl?}` |
| `getTextsConfig()` | `lang/tarteaucitron.<lang>.js` | text id → `{type, default_value}` (+ `engage-*` per enabled service) |
| `getTextsAvailableLanguagesConfig()` | `tarteaucitron.js` `availableLanguages` | language id → language object |
| `getLibraryVersion()` | `tarteaucitron.js` `version` | version string (or "Unknown") |
| `hasJsMinified()` | filesystem | bool (min.js present) |

`getJsonFromString()` normalizes the JS object literals into JSON before `Json::decode()`.

## ServicesManager API (service `tarte_au_citron.services_manager`)

| Method | Purpose |
|---|---|
| `getServicesOptionList()` | id → title, sorted, for the checkboxes on the JS form. |
| `getServices(bool $enabled = FALSE)` | instantiate service plugins (all, or only enabled) with their stored `settings`. |
| `isServiceEnabled(string $id)` | whether `tarte_au_citron.settings:services` has the id. |
| `isNeeded()` | `TRUE` unless the current user has `bypass tarte au citron` (guards the page attach). |

## ServicePluginBase surface (implement/override on a custom class)

`addJs(array &$page, array &$data)` (attach a library + merge settings), `defaultSettings()`,
`getSettings()`/`getSetting()`/`setSettings()`/`setSetting()`, `settingsForm()`, `isEnabled()`,
`getPluginTitle()`. `getLibraryName()` (protected, default `''`) — return a Drupal library id to attach
when the service is active.
