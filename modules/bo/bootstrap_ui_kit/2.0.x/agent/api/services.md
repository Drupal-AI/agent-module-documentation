# Routes, controller, services, Twig extensions & hooks (API)

## Routes (`bootstrap_ui_kit.routing.yml`)

| Route | Path | Handler | Access |
|---|---|---|---|
| `bootstrap_ui_kit.ui_kit` | `/ui-kit` | `BootstrapUiKitController::content` | `_permission: access bootstrap ui kit` |
| `bootstrap_ui_kit.settings` | `/admin/appearance/bootstrap_ui_kit/settings` | `BootstrapUiKitSettingsForm` | `_permission: administer site configuration` |
| `bootstrap_ui_kit.glossary` | `/admin/appearance/bootstrap_ui_kit/glossary` | `BootstrapUiKitGlossaryForm` | `administer site configuration` |
| `bootstrap_ui_kit.sections` | `/admin/appearance/bootstrap_ui_kit/sections` | `SectionsListForm` | `administer site configuration` |
| `bootstrap_ui_kit.component` | `/admin/appearance/bootstrap_ui_kit/glossary/{section}` | `GlossarySectionComponentForm` | `administer site configuration` |

`{section}` is a plain string param. The admin forms are covered in
[../configure/settings.md](../configure/settings.md) and [../configure/glossary.md](../configure/glossary.md).

## Controller & page rendering

`Drupal\bootstrap_ui_kit\Controller\BootstrapUiKitController::content()` returns
`['#theme' => ['bootstrap_ui_kit']]`. The actual page is rendered by **`page--ui-kit.html.twig`**,
selected through the core path-based `page__ui_kit` theme suggestion for `/ui-kit`. `hook_theme()`
registers the `page__ui_kit` hook (template `page--ui-kit`, `render element` `html`).
`bootstrap_ui_kit_preprocess_page__ui_kit()` builds all template variables: `logo`, `access`,
`dev_mode`, `can_edit_ui_kit`, `active_theme`, `base_themes`, `iconography_set`, and the fully
hydrated `glossary` (each component gets a `_render`).

## Services (`bootstrap_ui_kit.services.yml`)

### `bootstrap_ui_kit.content_injection_manager` — `Service\ContentInjectionManager`

Constructed with `!tagged_iterator bootstrap_ui_kit.slot_type` (the ordered slot handlers).

```php
$cim = \Drupal::service('bootstrap_ui_kit.content_injection_manager');

// Parse a story YAML file into {props, slots, library_wrapper?}.
$data = $cim->getStoryData('my_theme:card', $absolute_story_path);

// Props only (BC helper).
$props = $cim->getPropsFromStory('my_theme:card', $absolute_story_path);

// Build a render array for a component + optional wrapper.
$render = $cim->buildRenderable('my_theme:card', [
  'props' => ['title' => 'Hi'],
  'slots' => [/* transformed slots */],
  'library_wrapper' => '<div class="p-3 border">{{ _story }}</div>', // inline Twig, or "@theme/…"
]);
```

- `buildRenderable()` produces `#type => component` (`#component`, `#props`, optional `#slots`).
  When `library_wrapper` is set it wraps the component in an `#type => inline_template`; a value
  beginning with `@` is treated as a Twig `include` path, otherwise as an inline Twig fragment. The
  wrapper context exposes `_story`, `_props`, `_slots`, `_component_id`.
- `getStoryData()` normalises props (`attributes.class` string↔array) and transforms `slots`
  through the slot handlers (`transformSlots`/`convertSlotItem`).

### `bootstrap_ui_kit.component_definition_repository` — `Service\ComponentDefinitionRepository`

Args `@extension.list.theme`, `@extension.list.module`. In-memory cache of parsed
`components/{machine}/{machine}.component.yml` files (theme paths preferred, then modules).

```php
$repo = \Drupal::service('bootstrap_ui_kit.component_definition_repository');
$def      = $repo->get('my_theme:card');           // full parsed .component.yml or NULL
$variants = $repo->getVariants('my_theme:card');   // ['primary' => [...], …]
$schema   = $repo->getPropsSchema('my_theme:card'); // props.properties map
$title    = $repo->getHumanTitle('my_theme:card');  // name / title
```

### `bootstrap_ui_kit.story_discovery` — `Service\StoryDiscovery`

Args `@extension.list.module`, `@extension.list.theme`. Globs story files named
`components/{machine}/stories/{machine}.*.story.yml` across: the provider's module/theme path,
`sites/*/{themes,modules}/custom/*`, `{themes,modules}/custom/*`, and a monorepo `../drupal/*`
sibling. Only files with a `name:` key are listed.

```php
$sd = \Drupal::service('bootstrap_ui_kit.story_discovery');
$set  = $sd->discover('my_theme:card');   // options/basename_map/full_map/reverse_* keyed by sha1 hash
$path = $sd->resolveStoryPath('my_theme:card', 'card.default.story.yml'); // basename → absolute path
```

Story YAML shape and slot format: [../plugins/slot-types.md](../plugins/slot-types.md).

## Twig extensions

| Service | Twig callable | Behaviour |
|---|---|---|
| `bootstrap_ui_kit.file_get_contents` (`TwigExtension\FileGetContents`) | function `fileGetContents(files[])` | Returns the first existing file's contents. `@extension/path` resolves under that module/theme's `templates/` dir; a plain path is `file_get_contents()`-read as-is. Template-authored only. |
| `bootstrap_ui_kit.attribute_tools` (`AttributeToolsTwigExtension`) | filter **and** function `to_attributes(value, merge = {})` | Normalises arrays / `Attribute` / null into a Drupal `Attribute` object, merging classes and `style` fragments. Used to safely pass `attributes` into nested `include()`d components (see README). |
| `bootstrap_ui_kit.macro_autoload` (`MacroAutoloadTwigExtension`) | function `macro_*(…)` | Attempts to call a macro from `templates/{name}/{name}.macro.twig`. Marked `@todo`/broken in source ("this fails"); treat as non-functional. |

## Hooks implemented (`bootstrap_ui_kit.module`)

- `hook_help` (route `help.page.bootstrap_ui_kit`).
- `hook_theme` — registers `page__ui_kit`.
- `hook_preprocess_page__ui_kit` — builds the `/ui-kit` variables & hydrates the glossary.
- `hook_preprocess_page_title` — blanks the title on `bootstrap_ui_kit.ui_kit`.
- `hook_preprocess_html` — inline-injects the configured icon sprite site-wide.

Internal helpers (procedural, `.module`): `_bootstrap_ui_kit_sanitize_dom_id()`,
`_bootstrap_ui_kit_normalize_component()`, `_bootstrap_ui_kit_hydrate_story()`,
`_bootstrap_ui_kit_build_component_render()`.

## Asset libraries (`bootstrap_ui_kit.libraries.yml`)

`bootstrap-ui-kit` (base css/js), `bootstrap-ui-kit.highlight-js` (loads highlight.js + copy plugin
from `unpkg.com`, dev mode only), `bootstrap-ui-kit.typography`, `bootstrap-ui-kit.iconography`,
`bootstrap_ui_kit.admin_icons`, `bootstrap-ui-kit.color`, `bootstrap-ui-kit.glossary-form`.

## Bundled Bootstrap Icons

The module's only Composer requirement is `twbs/bootstrap-icons:^1.10`. Its icon SVGs and sprite are
**bundled under `vendor/twbs/bootstrap-icons/`** in the shipped module and are the default source for
`icons_source_folder` / `icons_sprite_file`. Bootstrap CSS/JS itself is **not** bundled — the module
expects a Bootstrap-5-enabled theme (0 Drupal module dependencies).
