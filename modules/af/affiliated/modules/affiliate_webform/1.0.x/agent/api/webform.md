<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliate webform — behaviour

Enable with `drush en affiliate_webform` (pulls in `affiliated` + `webform`). The install ships the
`webform_submission` conversion type; enable it for specific webforms and set its value on the
affiliate conversion type form at `/admin/structure/affiliate/conversion/types`.

## Insert hook (`affiliate_webform.module`)

`hook_webform_submission_insert(WebformSubmission $submission)`:

1. `affiliate_webform_get_webform_enabled_commission_types($submission->bundle())` — loads every
   `affiliate_conversion_type` and returns those whose `affiliate_webform.enabled_webforms`
   third-party setting contains the submitted webform id.
2. For each such type, if `affiliate.manager->getStoredAccount()` resolves the visitor's affiliate
   cookie to a valid affiliate:
   - create an `affiliate_conversion` (`type`, `affiliate` = affiliate id, `campaign` =
     `getStoredCampaign()?->id()`);
   - `setParentEntity($submission)`; `save()`.

A submission on a webform mapped to several conversion types produces one conversion per type. No
affiliate cookie ⇒ no conversion.

## Conversion-type configuration

`hook_form_affiliate_conversion_type_form_alter` adds an "Affiliate Webform" fieldset:
- `enabled_webforms` — checkboxes of all webforms (empty ⇒ this type never fires on submissions);
- `commission_value` — the per-submission amount.
The entity builder `affiliate_webform_affiliate_conversion_type_form_builder` filters and stores both
as third-party settings on the `affiliate_conversion_type` config entity.

Note: the value entered here is `commission_value`; the base `AffiliateConversion::preSave()` fills
`amount` from the type's core `default_commission`. To have `commission_value` applied to the
conversion `amount`, pair this with a pre-create/presave subscriber (see the parent module's event
docs), or set the type's Default Commission field.

## Config

`config/install/affiliated.affiliate_conversion_type.webform_submission.yml` — id
`webform_submission`, `default_commission: null`, label pattern `[affiliate_conversion:parent]`.
