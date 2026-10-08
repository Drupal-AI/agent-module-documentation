# API: icon service & factories

## `webicons.service` — IconService

`Drupal\webicons\Services\IconService` implements `IconServiceInterface`. It is a thin resolver that maps a
library id to its factory service.

```php
$factory = \Drupal::service('webicons.service')->getIconFactory('boxicons');
// == \Drupal::service('webicons.boxicons')
$render = $factory->getIconRenderArray(['icon_class' => 'bx bxs-beer']);
```

- `getServicePrefix(): string` — returns `'webicons.'`. Override this service to point the resolver at a
  different service namespace.
- `getIconFactory(string $libraryId): IconFactoryInterface` — returns `\Drupal::service('webicons.' . $libraryId)`.

Known library ids/labels are the constant `IconServiceInterface::ICONS`:
`boxicons` → *Box Icons*, `fortawesome` → *Fortawesome Icons*, `materialicons` → *Material Icons*.

## Factory services — IconFactory

Each library is a service (`webicons.boxicons`, `webicons.fortawesome`, `webicons.materialicons`) extending
the abstract `Drupal\webicons\Services\IconFactory` (implements `IconFactoryInterface`). Constructor args:
`@module_handler`, `@config.factory`, `@library.discovery`, `@cache.default`.

| Method | Behaviour |
|---|---|
| `getLibraryId(): string` | Hard-coded per factory (`boxicons` / `fortawesome` / `materialicons`). |
| `getLibraryName(): string` | `'webicons/' . getLibraryId()` (the asset library machine name). |
| `getIcons(): array` | Returns the cached icon list, else calls `extractFromLibrary()`. |
| `extractFromLibrary(): array` | Per-library parse of the **bundled** asset files (abstract; see below). |
| `saveIconsIntoCache(array): array` | Stores the list permanently in `cache.default` (cid = library id). |
| `getSelectorIconsRenderTemplate(): string` | `templates/icon-selector--items-<libraryId>.html.twig`. |
| `getIconRenderArray(array $keyValues, array $classes = []): array` | Builds the `webicon_field__value` render array (`#tag = 'i'`, attaches the library CSS). |
| `getLibraryCacheId(): string` | `'webicons_collection_' . getLibraryId()`. |

Extraction per library (all read fixed, module-shipped files — no request input, no network):
- **Boxicons** — regex over `assets/libraries/boxicons/css/boxicons.min.css`, collecting `.class:before{content:"\code"}` pairs.
- **Font Awesome** — decodes `assets/libraries/@fortawesome/fontawesome-free/metadata/icon-families.json`, keeping free styles as `{style, class, code}` grouped by style.
- **Material Icons** — decodes `assets/libraries/material-icons/_data/versions.json`, using each key as an icon name (`code` empty). `MaterialiconsIconFactory` also overrides `getIconRenderArray()` to use `#tag = 'span'`.

## Add a new icon library

The design is meant to be extended without patching the module:

1. Ship the library's CSS as an asset library `mymodule/<id>` in your `*.libraries.yml`.
2. Add a factory class extending `Drupal\webicons\Services\IconFactory`, implementing `getLibraryId()`
   (return your `<id>`) and `extractFromLibrary()` (return `[['class' => …, 'code' => …], …]` then
   `$this->saveIconsIntoCache(...)`). Override `getLibraryName()` if the asset library is not under
   `webicons/`, and `getIconRenderArray()` if you need a different tag.
3. Register it as service `webicons.<id>` with the same four arguments, so
   `IconService::getIconFactory('<id>')` resolves it. Add `templates/icon-selector--items-<id>.html.twig`
   for the picker grid.
4. To expose it in the field settings select, that select reads `IconServiceInterface::ICONS`; to change
   the option list, decorate/override `webicons.service`.

## Picker route / controller

`IconSelectorController::iconSelectorDialog()` (route `webicons.open_selector`, `/webicon-selector`,
`_permission: 'access content'`) reads `lid` (library id) and `wid` (target wrapper id) from the request,
resolves the factory, and returns an `AjaxResponse` with an `OpenModalDialogCommand` rendering the
`icon_selector` theme hook (the icon grid + a client-side name filter). `lid` is only ever used as the
`webicons.` service-name suffix and to select a shipped template by hard-coded factory id.
