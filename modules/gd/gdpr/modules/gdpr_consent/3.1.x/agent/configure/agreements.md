<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent agreements and the consent field

## The `gdpr_consent_agreement` entity

A revisionable, translatable content entity (`ContentEntityType id = gdpr_consent_agreement`,
base table `gdpr_consent_agreement`, admin permission `manage gdpr agreements`), managed at
`/admin/config/gdpr/agreements`:

- `collection` `/admin/config/gdpr/agreements`
- `add-form` `/admin/config/gdpr/agreements/add`
- `edit-form` / `delete-form` / `version-history` (revisions) under
  `/admin/config/gdpr/agreements/{gdpr_consent_agreement}/...`

Required base fields: `title` (label), `mode` (list_string, allowed values from
`ConsentAgreement::getModes()` → `implicit` | `explicit`), `description`. It also carries long
description / agreement text fields and standard revision metadata.

Create one programmatically:
```php
$storage = \Drupal::entityTypeManager()->getStorage('gdpr_consent_agreement');
$agreement = $storage->create([
  'title' => 'Marketing emails',
  'mode' => 'explicit',
  'description' => 'I agree to receive marketing emails.',
]);
$agreement->save();
// find them:
$storage->loadByProperties(['title' => 'Marketing emails']);
```

## The consent field (`gdpr_user_consent`)

- Field type `gdpr_user_consent` (`Plugin\Field\FieldType\UserConsentItem`).
- Widget `gdpr_consent_widget` (`ConsentWidget`) — renders the agreement + an accept control on
  an entity form.
- Formatter `gdpr_consent_formatter` (`ConsentFormatter`).

Attach it to an entity/bundle (e.g. user, or a webform) so a form collects consent to a chosen
agreement. When a field of type `gdpr_user_consent` is added, a validation check requires the
target entity/bundle to have a registered **consent user resolver** (see
[../plugins/consent-resolver.md](../plugins/consent-resolver.md)); otherwise the field add form
errors.

## Acceptance logging & user views

- Accepted consents are recorded as `message` entities via the `consent_agreement_accepted`
  message template (shipped in `config/install`), and listed by the `gdpr_log_messages` view.
- Block `GdprMyAgreementsBlock` and page `/user/{user}/gdpr/agreements`
  (route `gdpr_consent.agreements`) show a user's consents.

## Permissions

`manage gdpr agreements` (admin the agreements), `grant gdpr any consent` (consent on behalf of
any user), `grant gdpr own consent` (consent for yourself).
