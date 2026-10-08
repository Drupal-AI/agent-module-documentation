# Site-logo automation (config-import subscriber + SiteLogo)

The module ships the Acquia CMS logo image (`assets/images/acquia_cms_logo.png`) and installs it as a Media
entity + the global site logo. This happens on module install (see [hooks/roles.md](../hooks/roles.md)) and
also when the module is enabled through a **config import**, handled here.

## Event subscriber

`acquia_cms_image.config_subscriber` → `Drupal\acquia_cms_image\Config\AcquiaCmsImageConfigSubscriber`
(`acquia_cms_image.services.yml`, argument `@class_resolver`).

- Subscribes to `ConfigEvents::IMPORT` → `onConfigImport()`.
- On a config import that **installs** `acquia_cms_image`, it reads the incoming `system.theme.global` and, if
  its `logo.path` equals `SiteLogo::LOGO_PATH` (`public://media-icons/acquia_cms_logo.png`) — i.e. the site
  hasn't overridden the logo — calls `SiteLogo::createLogo()`. This creates the logo media that the imported
  theme config points at.

## `SiteLogo` service

`Drupal\acquia_cms_image\SiteLogo` — a `final`, `@internal` class implementing `ContainerInjectionInterface`
(instantiated via `\Drupal::classResolver(SiteLogo::class)` or the class resolver). Treat it as internal to
Acquia CMS; it is not a stable API.

| Method | Behavior |
|---|---|
| `createLogo(): SiteLogo` | If `validate()` passes: ensures optional media config exists during profile install (`ensureMediaExists()`), writes `assets/images/acquia_cms_logo.png` to `public://media-icons/acquia_cms_logo.png` via `file.repository`, then creates a `media` entity (bundle `image`, fixed **UUID `0c6f0f26-9fbb-4c2e-804c-418815aba162`**, name "Acquia CMS Logo"). |
| `setLogo(): void` | Sets `system.theme.global` `logo.use_default = FALSE` and `logo.path = public://media-icons/acquia_cms_logo.png`, but **only if no `logo.path` is already set** (won't clobber a custom logo). |
| `validate(): bool` | Returns FALSE (skips creation) if a media with that fixed UUID already exists, or if the target directory can't be created. |
| `checkIfMediaExists()` / `ensureMediaExists()` / `ensureDirectoryExists()` | Guards: dedupe by UUID, import optional media config during a profile install, `mkdir` the destination. |

Net effect: enabling the module gives the site an "Acquia CMS Logo" media item and, unless a logo was already
chosen, wires it up as the theme logo. Idempotent — the fixed UUID prevents duplicate logo media on re-install
or re-import.
