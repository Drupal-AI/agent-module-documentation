<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring SAML Rules

## Rule types
- **Authentication rules** (`saml_rules.authentication_rules`): when SAML
  attribute `saml_attribute` equals `saml_value`, either set the email
  (`action: email`) or add the listed `roles` to the user.
- **User-field rules** (`saml_rules.user_field_rules`): map a SAML value into a
  Drupal user field, optionally guarded by a condition
  (`condition_operand: equal|…`). Values support `[attribute]` placeholders
  expanded by `saml_rules_replace_tokens()`.

## Admin UI
All under `/admin/config/people/saml-rules` (perm `administer saml rules`):
matrix views for each rule type, add/edit/delete forms, and a settings form
(`require_auth`, `saml_account_management_url`).

## How rules run
`saml_rules_user_login($account)` (in `saml_rules.module`) fires on login. It
builds SP/IdP settings from `samlauth.authentication`, constructs
`new OneLogin\Saml2\Response($settings, $_POST['SAMLResponse'])`, reads
`getAttributes()`, then applies the authentication and user-field rules and calls
`$user->save()`.

