<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Push Notifications stores device tokens and sends push messages to iOS and Android devices from Drupal.

---

A site with a companion mobile app needs somewhere to keep the device tokens and something to send with, and doing it inside Drupal means the notification can be triggered by the same events that already exist there — content published, order shipped, comment replied to — rather than by a separate service that has to be told. Version **8.x-1.0-alpha2**, an **alpha**, on `^9 || ^10 || ^11`. **This release fatals on Drupal 11.4 and cannot be used.** `PushNotificationsTokenLanguageConstraintValidator::validate()` carries the pre-Symfony-6 signature — `validate($value, Constraint $constraint)` — against Symfony 7's `ChoiceValidator::validate(mixed $value, Constraint $constraint): void`, and PHP rejects the incompatible override on class load. Verified on a clean install, where enabling it took the site down hard enough that `drush` itself could not run and the module had to be removed from `core.extension` by a direct database edit. It is the third module in this campaign to fail this way, after `views_better_rest` and `same_page_preview`, and the pattern is the same: **core's Symfony upgrade narrowed a base-class signature, and contrib that predates it fatals rather than degrading**. Beyond that, two things are worth knowing about the problem space. **A device token is a credential and personal data** — it identifies a device and can be used to send to it, so the token store deserves the protection of a credential store and a retention rule, since tokens outlive the app installs that created them. And **push provider integration has moved**: Apple retired the legacy binary APNs interface in favour of HTTP/2 with token-based authentication, and Google retired the legacy FCM APIs in 2024, so any module in this space needs checking against what the providers currently accept.

---

- Send a push notification to app users.
- Notify a mobile app of new content.
- Store device tokens in Drupal.
- Send an alert to iOS devices.
- Notify Android users of an update.
- Trigger a push from a content event.
- Send a breaking news alert.
- Notify users of an order status change.
- Send a reminder to app users.
- Manage device token registration.
- Send targeted notifications by language.
- Notify subscribers from Drupal.
- Send a push on comment reply.
- Support a companion mobile app.
- Send an event reminder to devices.
- Notify users of a new episode.
- Manage push from an editorial workflow.
- Send a service alert to app users.
