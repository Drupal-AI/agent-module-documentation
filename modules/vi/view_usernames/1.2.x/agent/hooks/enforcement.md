# Hooks & runtime enforcement

All enforcement lives in `view_usernames.module`. Every hook resolves the decider chain
(`view_usernames.view_username_access_decider`) for the `view label` operation and hides the
username when the result is forbidden. Layered on purpose: the first two hooks are "proper" access
checks; the last two are last-resort guards so a username never leaks even when a caller forgot to
check access.

| Hook | Function | Delegates to | When it acts |
|---|---|---|---|
| `hook_entity_access` | `view_usernames_user_access()` | `EntityHooks::userEntityAccess()` | Only for operation `view label` on a user entity; returns the decider result, else `neutral()`. |
| `hook_entity_field_access` | `view_usernames_entity_field_access()` | `EntityHooks::entityFieldAccess()` | Only for operation `view` on the `name` field of a **persisted** user (stub/new users are skipped); returns the decider result, else `neutral()`. |
| `hook_preprocess_HOOK` (`username`) | `view_usernames_preprocess_username()` | — | For any `#theme => 'username'`: if `view label` is forbidden, blanks `name`, `name_raw` and sets `truncated = FALSE`. Anonymous accounts are exempt (their label is public). |
| `hook_user_format_name_alter` | `view_usernames_user_format_name_alter()` | `CacheabilityBubbleUpper` | Last line of defense for direct `getDisplayName()` calls (e.g. `UserNameFormatter::viewElements()`): sets `$name = ''` when `view label` is forbidden, unless the internal bypasser says skip. |
| `hook_module_implements_alter` | `view_usernames_module_implements_alter()` | — | Re-orders `user_format_name_alter` so this module's implementation runs **last**. |

Why two safety nets on top of real access checks: field access is allowed-by-default and entity
access is neutral-by-default, so a code path that renders a username without asking would otherwise
leak it. `hook_preprocess_username` and `hook_user_format_name_alter` close that gap. The source is
explicit that `hook_preprocess_username` "is not supposed to be here but currently this is the safest
way" to make every `#theme => 'username'` inherit the check.

## The correct caller pattern

When you render a username yourself, pass the access result as `#access` so the check runs with
proper cacheability (do not rely only on the safety nets):

```php
/** @var \Drupal\user\UserInterface $user */
$user = \Drupal\user\Entity\User::load(1);
$build[] = [
  '#theme' => 'username',
  '#account' => $user,
  '#cache' => ['tags' => $user->getCacheTags()],
  // Check whether the CURRENT user may view this user's username.
  '#access' => $user->access('view label', NULL, TRUE),
];
```

`$user->access('view label', NULL, TRUE)` returns an `AccessResultInterface` carrying the decider's
cache metadata. The `EntityHooks` handlers bubble that cacheability up (`CacheabilityBubbleUpper`,
which renders an empty build carrying the metadata into the current render context) so cached
fragments invalidate when roles or permissions change.

## Automatic behavior you should know about

- **Email**: the mail plugin manager (`plugin.manager.mail`) is decorated by
  `Drupal\view_usernames\Mail\MailManagerDecorator` (installed by the `MailPluginDecoratorPass`
  compiler pass, registered in `ViewUsernamesServiceProvider`). During `MailManager::mail()` it
  activates the format-name **bypasser**, so tokens such as `[user:display-name]` resolve to the real
  username in outgoing mail regardless of who triggered the send — even an anonymous request that
  causes an email to a registered user. The render result is marked uncacheable and the bypass is
  deactivated immediately after the mail call.
- **JSON:API**: `JsonApiEarlyRenderingFixEventSubscriber` (internal service
  `event_subscriber.view_usernames.jsonapi_early_rendering_fix`) activates the same bypasser when the
  controller for a request is JSON:API's `EntityResource` (`KernelEvents::CONTROLLER`, priority 16,
  before `early_rendering_controller_wrapper_subscriber`), and resets it on every (sub)request.
  Reason: JSON:API already enforces field access, and the extra `user_format_name_alter` guard would
  trigger an early-rendering error (HTTP 500). Username protection for JSON:API therefore comes from
  the `name` field-access hook above, not from the format-name guard.

The bypasser only relaxes `hook_user_format_name_alter`. Entity access and the `name` field-access
check are **never** bypassed, so JSON:API/REST responses still omit `name` for viewers who lack
access.

## Internal services — do not use

`view_usernames.user_format_name_hardening_bypasser`
(`TemporaryUserFormatNameHardeningBypasser`) and the JSON:API subscriber are marked `@internal`; the
`EntityHooks`, collector, default decider, `CacheabilityBubbleUpper` and mail decorator are `final`
and `@internal` too. Do not depend on, decorate or subclass them. The only supported extension point
is registering a `view_username_access_decider`-tagged service — see
[../api/deciders.md](../api/deciders.md).
