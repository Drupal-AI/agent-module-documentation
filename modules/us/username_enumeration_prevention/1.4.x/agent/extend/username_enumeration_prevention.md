# Extend / behavior — username_enumeration_prevention

This module has **no configuration, no settings form, and no permissions of its own**.
You install it, and it closes two username-enumeration vectors automatically. Below is
exactly what it changes so you can reason about the behavior.

## 1. Generic forgot-password response

Core's forgot-password form (`user_pass`, at `/user/password`) validates the submitted
name/email and, if no account matches, shows an error that reveals whether that account
exists. The module removes that leak:

- `username_enumeration_prevention_form_user_pass_alter()` appends a validate handler,
  `username_enumeration_prevention_pass_validate()`, to the `user_pass` form.
- The handler loads the account by email (`user_load_by_mail`) then by name
  (`user_load_by_name`). If an **active** account is found it sets it on the form as
  core expects; otherwise it logs a `notice`: *"Blocked user attempting to reset
  password."* via the `username_enumeration_prevention` logger channel.
- It then **clears the sensitive error on the `name` field** (re-adding any other,
  non-sensitive errors), so a valid and an invalid identifier produce the same neutral
  outcome. No "no account found" message is shown.

Net effect: submitting the reset form no longer tells an attacker which usernames or
emails are registered.

## 2. 403 → 404 on user routes

Drupal normally returns **403 Access denied** for a restricted but existing user page
(e.g. `/user/123`) and **404 Not found** for a non-existent id — a difference that lets
an attacker confirm accounts. The module erases that distinction:

- `UserRouteEventSubscriber` (service `username_enumeration_prevention.user_route_subscriber`,
  in `src/UserRouteEventSubscriber.php`) subscribes to `KernelEvents::EXCEPTION`.
- In `onException()`, when the thrown exception is an `AccessDeniedHttpException`
  **and** the current route is one of the user routes, it swaps the throwable for a
  `NotFoundHttpException`. Result: unauthorized user pages return a uniform **404**.
- The user route set is computed in `getUserRoutes()` from the `user` entity type's
  **link templates** (via the route provider / `getRoutesByPattern`), keeping any route
  whose parameter is `entity:user` or whose path contains `{user}`, plus the two extra
  route ids `user.cancel_confirm` and `shortcut.set_switch`. The list is cached under
  the CID `username_enumeration_prevention_user_route_ids` (tag `routes`,
  `Cache::PERMANENT`), so it is recomputed only when routes are rebuilt.

Because the set is derived from the live user entity definition, the protection keeps
covering user view/edit/cancel routes across upgrades without hardcoding paths.

## The one thing that defeats it: `access user profiles`

The module does **not** define or change permissions. If a role — especially
**anonymous** — is granted core's `access user profiles` permission, that role can view
user pages directly (no 403 is ever thrown), which re-exposes usernames. The module's
`hook_requirements()` (runtime phase, in `username_enumeration_prevention.install`)
therefore adds a **status-report warning** when anonymous users hold `access user
profiles`, and an OK message otherwise. To keep the protection effective, ensure
anonymous (and untrusted roles) do **not** have `access user profiles`.

## Enable and forget

```
drush en username_enumeration_prevention -y
```

No config to set, no route to visit, nothing to schedule. Verify with a quick check:
as an anonymous user, `/user/1` should return **404** (not 403), and the forgot-password
form should not reveal whether an account exists.
