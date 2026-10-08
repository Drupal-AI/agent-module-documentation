<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliate webform (affiliate_webform) — agent index

Submodule of **affiliated**. Attributes Webform submissions to affiliates. Package **Affiliated**.
Core `^10 || ^11`. Depends on `affiliated:affiliated` and `webform:webform`. Version
**1.0.0-alpha3** (dir 1.0.x). No own permissions, config schema, services, routes or plugin types —
one insert hook plus a conversion-type form alter.

## What it provides

- `affiliate_webform_webform_submission_insert(WebformSubmission $submission)`
  (`hook_webform_submission_insert`): for each conversion type enabled for the submitted webform
  (`affiliate_webform_get_webform_enabled_commission_types()`), if
  `AffiliateManager::getStoredAccount()` returns a valid affiliate, creates an `affiliate_conversion`
  of that type (`affiliate` + stored `campaign`), `setParentEntity($submission)`, `save()`.
- `hook_form_affiliate_conversion_type_form_alter` + entity builder: adds an "Affiliate Webform"
  fieldset to the conversion type form storing third-party settings `enabled_webforms` (checkboxes of
  all webforms) and `commission_value` (per-submission amount).
- Install config `affiliated.affiliate_conversion_type.webform_submission` (the `webform_submission`
  conversion type; label pattern `[affiliate_conversion:parent]`).

Commission default, approval default and campaign-ownership validation come from the base
`affiliate_conversion` entity (see parent docs). See [api/webform.md](api/webform.md).
