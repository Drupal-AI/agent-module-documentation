<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Push Notifications (push_notifications) — agent index

Stores **device tokens** and sends push messages to iOS/Android from Drupal.
Version **8.x-1.0-alpha2** — **alpha**. Core requirement `^9 || ^10 || ^11`.

**This release fatals on Drupal 11.4 and cannot be used — verified on a clean install.**
`PushNotificationsTokenLanguageConstraintValidator::validate()` carries the pre-Symfony-6 signature:

```
Declaration of …PushNotificationsTokenLanguageConstraintValidator::validate($value, Constraint $constraint)
must be compatible with Symfony\Component\Validator\Constraints\ChoiceValidator::validate(mixed $value, Constraint $constraint): void
```

Enabling it took the site down hard enough that **`drush` itself could not run**, and the module had
to be removed from `core.extension` by a **direct database edit**.

**Third module in this campaign to fail this way**, after `views_better_rest` and
`same_page_preview` (wave 80). The pattern: **core's Symfony upgrade narrowed a base-class
signature, and contrib predating it fatals on class load rather than degrading.**

**Two things about the problem space, for whatever replaces it:**
1. **A device token is a credential and personal data** — it identifies a device and can be used to
   send to it. It deserves a credential store's protection and a **retention rule**, since tokens
   outlive the app installs that created them.
2. **Provider integration has moved.** Apple retired the **legacy binary APNs** interface for HTTP/2
   with token-based auth; Google retired the **legacy FCM APIs** in 2024. Check any module in this
   space against what the providers currently accept.
