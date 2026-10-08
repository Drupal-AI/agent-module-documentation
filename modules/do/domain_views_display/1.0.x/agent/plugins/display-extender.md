<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Domain Views Display display extender & override mechanism

## Install & enable

```bash
composer require drupal/domain    # if not already present (^2 || ^3, needs >= 2.0)
composer require drupal/domain_views_display
drush en domain_views_display -y
```

Dependencies: core **`views`** and contrib **`domain`** (Domain Access). No third-party libraries,
no PHP extension requirement in the runtime `require` (dev-only `require` lists PHP >= 8.3).

`hook_install` (`domain_views_display.install` → `src/Install.php` `Install::install()`) appends the
extender id to the `views.settings` `display_extenders` list so the extender is active on **all**
displays. Uninstall removes it. Both no-op during config sync (`$is_syncing`).

## The plugin

`src/Plugin/views/display_extender/DomainViewsDisplayExtender.php`, extending
`Drupal\views\Plugin\views\display_extender\DisplayExtenderPluginBase`:

- Attribute `#[ViewsDisplayExtender(...)]`, id constant `self::ID =
  'domain_views_display_display_extender'`, title *"Domain Views Display extender"*.
- **Plugin type: `views_display_extender`** (an existing core Views type — this module defines no
  new plugin type). It is **not** an access, style, filter, or query plugin.
- `defineOptions()` adds one option: **`override_displays`** (default `[]`) — an associative array
  keyed by **domain id** whose value is the **display id** to use on that domain.

### Options form (Views UI)

- `optionsSummary()` registers a category **`domain_views_display`** titled **"Domain overrides"**
  in the second column, with an **"Override display"** row whose value is the comma-joined labels of
  the mapped domains (via `DomainStorage::loadMultipleSorted()`), or *"None"*.
- `buildOptionsForm()` (section `override_displays`): a fieldset **"Override the display by
  domain"**; one `select` per configured domain (`loadMultipleSorted()`), options being the view's
  **other** displays (`$this->view->storage->get('display')`, with the current display and
  `default` removed), each labelled `"@title (@id)"`. Empty option = *"This display"* (no override).
- `submitOptionsForm()` stores `array_filter($form_state->getValue('override_displays'))` — empty
  selections are dropped, so only real overrides persist.
- `calculateDependencies()` adds each mapped domain's `getConfigDependencyName()` as a `config`
  dependency (a code comment notes core issue #2426607 means this may not actually stick on the
  view).

Config schema `config/schema/domain_views_display.views.schema.yml` extends
`views_display_extender` with `override_displays` as a `sequence` of `string`.

Example (inside a view's display config):

```yaml
display:
  page_1:
    display_options:
      display_extenders:
        domain_views_display_display_extender:
          override_displays:
            example_com: page_2      # domain id 'example_com' renders display 'page_2'
            other_com: feed_1        # domain id 'other_com' renders display 'feed_1'
```

## Runtime override mechanism

Helper `src/DomainViewsDisplay.php` (`Drupal\domain_views_display\DomainViewsDisplay`), autowired
with `domain.negotiator` and `entity_type.manager`, resolved through `\Drupal::classResolver()`.

- **`getActiveOverride(ViewExecutable $view, ?CacheableMetadata $cacheability = null): ?string`** —
  the core decision. Throws `\LogicException` if no current display is set. Reads
  `override_displays` from the current display's extender; if empty returns `NULL`. Otherwise adds
  the **`url.site`** cache context, then returns `$overrides[$this->domainNegotiator->getActiveId()]`
  **only if** that value is set, is **not** the current display, and passes
  **`$view->access($override)`** — else `NULL`. So the switch is a no-op unless the visitor already
  has access to the target display.
- **Page routes.** `Routing\RouteSubscriber::alterRoutes()` calls
  `getViewDisplaysWithOverrides()` (an entity query for views whose display config `exists`
  `...override_displays`) and, for each `view.<view_id>.<display_id>` route, swaps
  `_controller` `ViewPageController::handle` → `ControllerDecorator::handle` and `_title_callback`
  `ViewPageController::getTitle` → `ControllerDecorator::getTitle`.
  `Routing\ControllerDecorator::handle()` sets the display, computes the override, calls the real
  `ViewPageController::handle()` with `$override ?? $display_id`, and `addCacheableDependency()` on a
  `CacheableResponseInterface` response. `getTitle()` likewise returns the override display's title.
- **Embedded & pre-rendered views.** `hook_views_pre_view` → `viewsPreView()` → `ensureDisplay()`
  calls `getActiveOverride()` and `$view->setDisplay($override)`, applying cacheability to
  `$view->element`. `hook_element_info_alter` → `elementInfoAlter()` unshifts `preRender()` onto the
  `view` element's `#pre_render`; `preRender()` (a trusted callback) rewrites `#display_id` to the
  override, guarding with `$view->access($element['#display_id'])` first and applying cacheability.
- `hook_module_implements_alter` (static `moduleImplementsAlter()`) orders this module's
  `views_pre_view` **first** and its `element_info_alter` **last**, so the display is fixed before
  other implementations run and the pre-render lands at the front of the list.
- `TrustedCallbackInterface::trustedCallbacks()` declares `process` and `preRender`.

## How to configure on a view

1. Build the alternate display(s) in the view (e.g. a second `Page` or `Feed`).
2. Edit the display you want to vary; in the **Domain overrides** group click **Override display**.
3. For each domain, pick the display to render there (or leave *"This display"* for no override).
4. Save. On matching domains the mapped display now renders in place of the original for page
   requests, embeds, and pre-rendered view elements.

Caveats: mappings can form loops (A→B→A) — the code has only an unimplemented `@todo` guard;
renaming a targeted display breaks its mapping; and the added config dependency on the domain may
not persist on the view (core #2426607).
