# hook_event_dispatcher — agent start

Respond to Drupal hooks as typed Symfony events: subscribe to an event class (e.g.
`EntityInsertEvent`) with an `EventSubscriberInterface` service instead of writing a
`hook_*()` function. The base module is only the dispatch mechanism (no events of its own) —
the actual events live in ~10 **per-subsystem submodules** you enable as needed
(`core_event_dispatcher`, `field_event_dispatcher`, `media_event_dispatcher`,
`path_event_dispatcher`, `preprocess_event_dispatcher`, `user_event_dispatcher`,
`views_event_dispatcher`, `toolbar_event_dispatcher`, `jsonapi_event_dispatcher`,
`webform_event_dispatcher`). No config UI, no permissions.

> The submodules are documented as a group, not individually — enable the one that owns the
> hook you want, then subscribe to its event constant. This index covers the main module only.

- Write an EventSubscriber for a hook event (naming, constants, alter/return hooks) →
  [extend/hook_event_dispatcher.md](extend/hook_event_dispatcher.md)
- Pick & enable the right submodule for a subsystem; scaffold a subscriber with Drush →
  [configure/hook_event_dispatcher.md](configure/hook_event_dispatcher.md)
