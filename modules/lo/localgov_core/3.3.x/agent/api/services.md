# LocalGov Core — services, events & hooks

## Page Header event

`PageHeaderDisplayEvent` (`Drupal\localgov_core\Event\PageHeaderDisplayEvent`), constant
`EVENT_NAME = 'localgov_core.page_header_display'`. Dispatched by the Page Header block while building.
Subscribers can read/override:
- `getEntity()` / `setEntity()`, `getView()` / `setView()`
- `getTitle()` / `setTitle()`, `getSubTitle()` / `setSubTitle()`, `getLede()` / `setLede()`
  (each accepts array|string|null render values)
- `getVisibility()` / `setVisibility(bool)` — set FALSE to hide the header block
- `getCacheTags()` / `setCacheTags(array)`

Subscribe with an `EventSubscriberInterface` on `PageHeaderDisplayEvent::EVENT_NAME` to customise the
header for particular entities/routes.

## Service: `localgov_core.default_block_installer` (`DefaultBlockInstaller`)

Args: `config.factory`, `entity_type.manager`, `file_system`, `module_handler`, `theme_handler`,
`theme.manager`. Reads `config/localgov/block.*.yml` files inside a module's directory
(`blockDefinitions()`) and installs those blocks into theme regions. Invoked automatically:
- `hook_modules_installed()` → `install($modules)` (skipped during config sync / installer).
- `hook_localgov_post_install()` → installs blocks for every enabled `localgov_*` module.

Call `\Drupal::service('localgov_core.default_block_installer')->install(['my_module'])` to place a
module's default blocks programmatically.

## Utility: `FieldRenameHelper::renameField($old_field_name, $new_field_name, $entity_type)`

Static helper (no service). Renames a field: creates new `FieldStorageConfig` for the new name,
updates config dependencies, rewrites entity view/form displays (including field groups), and removes
the old storage. New name is truncated to 32 chars. Returns early if the old field storage is absent.
Intended for use from `hook_update_N()` / post-update hooks. Throws on unsupported entity-reference
revisions field changes.

## Roles hook: `hook_localgov_roles_default()`

Provided by the `localgov_roles` submodule but implemented by many modules. Return an array keyed by
`RolesHelper::*_ROLE` constant → list of permission strings; `localgov_roles` grants them on install
and on module install. See the localgov_roles submodule docs.

## Distribution hook: `hook_localgov_post_install()`

LocalGov Core implements it to install default blocks for all `localgov_*` modules. Other modules can
implement it for post-install setup during a LocalGov distribution install.

## Theming preprocess

- `hook_preprocess_file_link()` — appends file **type** (uppercased extension) and reformatted **size**
  (e.g. `123.45KB`) to file link text as `<span class="file-meta">…</span>`; for `document` media it
  can use the file description or media name as the link text (based on the field display's
  `use_description_as_link_text`).
- `hook_library_info_alter()` / `template_preprocess_default_variables_alter()` — honour LocalGov Base
  theme settings `localgov_base_remove_css` / `localgov_base_remove_js` to strip that theme's assets.
- `hook_theme()` registers `localgov_page_header_block`; `hook_theme_suggestions_*` adds
  `localgov_page_header_block__{bundle}`, `__{type}__{id}`, `__{type}` suggestions.
