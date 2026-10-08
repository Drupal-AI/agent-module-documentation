Hook Event Dispatcher lets you react to Drupal hooks by subscribing to typed Symfony event classes instead of writing procedural `hook_*()` functions. Each core subsystem's hooks are wrapped by a separate submodule you enable as needed.

---

The base `hook_event_dispatcher` module is a thin dispatch mechanism: it provides a manager service (`hook_event_dispatcher.manager`) that wraps Drupal's `event_dispatcher`, a decorator over the core `module_handler`, and a `HookEventPluginManager`. It ships no events of its own. The actual events live in ~10 per-subsystem submodules — `core_event_dispatcher` (entity, form, theme, block, file, menu, token, language, page, options hooks), `field_event_dispatcher`, `media_event_dispatcher`, `path_event_dispatcher`, `preprocess_event_dispatcher`, `user_event_dispatcher`, `views_event_dispatcher`, `toolbar_event_dispatcher`, `jsonapi_event_dispatcher`, and `webform_event_dispatcher` — and you enable only the ones you need. Each submodule implements the relevant hooks in its `.module` file; every implementation builds a typed event object (e.g. `EntityInsertEvent`) and calls `$manager->register($event)`, dispatching it under a namespaced event name (all prefixed with `hook_event_dispatcher.`). Your code implements `EventSubscriberInterface`, registers the class as an `event_subscriber`-tagged service, and returns a map of event-name constants (e.g. `EntityHookEvents::ENTITY_INSERT`) to method names from `getSubscribedEvents()`. Event names are exposed as constants on `*HookEvents` classes per subsystem (`EntityHookEvents`, `FormHookEvents`, `FieldHookEvents`, `ViewsHookEvents`, `UserHookEvents`, etc.), so you subscribe by referencing a constant rather than a raw string. Alter-style and return-style hooks are supported too: event objects expose getters/setters (and `HookReturnInterface`) so the submodule feeds your changes back into the hook's return value. A Drush generator (`hook_event_dispatcher.generator`) can scaffold a subscriber. The result is dependency-injected, unit-testable, IDE-navigable hook logic that replaces scattered `.module` functions.

---

- Respond to entity insert/update/delete by subscribing to `EntityInsertEvent`, `EntityUpdateEvent`, `EntityDeleteEvent` instead of `hook_entity_insert()` etc.
- Set a field value before save via `EntityPresaveEvent` rather than `hook_entity_presave()`.
- Add markup to a rendered entity through `EntityViewEvent` instead of `hook_entity_view()`.
- Alter a form with `FormAlterEvent` / `FormBaseAlterEvent` instead of `hook_form_alter()`.
- Register theme hooks by subscribing to a `ThemeEvent` instead of `hook_theme()`.
- Preprocess template variables via `preprocess_event_dispatcher` events instead of `template_preprocess_*()` / `hook_preprocess_HOOK()`.
- Control access decisions through `EntityAccessEvent` instead of `hook_entity_access()`.
- React to field-related hooks with `field_event_dispatcher` (widget/formatter/field info events).
- React to media hooks (e.g. source info) with `media_event_dispatcher`.
- React to path/alias changes with `path_event_dispatcher` instead of path hooks.
- React to user hooks (login, cancel, format name) with `user_event_dispatcher`.
- Alter Views data and query behavior with `views_event_dispatcher` instead of `hook_views_*()`.
- Alter the toolbar with `toolbar_event_dispatcher` instead of `hook_toolbar()`.
- Alter JSON:API behavior with `jsonapi_event_dispatcher`.
- React to Webform hooks with `webform_event_dispatcher`.
- Group related hook logic into one injectable subscriber service instead of many free functions.
- Unit-test hook logic by instantiating the event and calling your subscriber method directly.
- Use IDE autocompletion and type-hints on event objects (getters/setters) instead of untyped hook args.
- Reference event names as `*HookEvents` constants to avoid typos in raw hook strings.
- Reorder or short-circuit hook handlers using Symfony event subscriber priorities and `stopPropagation()`.
- Enable only the subsystems you need (e.g. just `core_event_dispatcher`) to keep surface area small.
- Return a value from a hook (e.g. token replacements) via events implementing `HookReturnInterface`.
- Scaffold a new event subscriber quickly with the module's Drush generator.
- Migrate a legacy `.module` full of hook functions toward service-based, DI-friendly subscribers incrementally.
- Decorate/override the `module_handler` behavior transparently — existing hook implementations keep working alongside subscribers.
