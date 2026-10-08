<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CAS Attributes turns the attributes your CAS server returns at login into Drupal tokens, user-field values and role assignments, with per-mapping comparison rules and optional login/registration denial.

---

The module extends `drupal/cas` with a single settings form at `/admin/config/people/cas/attributes` (route `cas_attributes.settings`) writing one config object, `cas_attributes.settings`. Everything happens in one event subscriber, `Drupal\cas_attributes\Subscriber\CasAttributesSubscriber`, which listens to CAS's `CasPreRegisterEvent`, `CasPreLoginEvent` and `CasPostLoginEvent`. **Field mappings** are a map of user field name → a string containing tokens (e.g. `mail: '[cas:attribute:email]'`); they are applied at registration and/or at every login depending on `field.sync_frequency` (0 = never, 1 = initial registration only, 2 = every login), and `field.overwrite` decides whether an existing value is replaced. **Role mappings** are a list of conditions — role id, attribute name, value to match, comparison `method` (`exact_single`, `exact_any`, `contains_any`, `regex_any`), an optional `negate` flag and `remove_without_match` — evaluated on every login/registration according to `role.sync_frequency`; `role.deny_login_no_match` and `role.deny_registration_no_match` refuse the login or the auto-registration when no role matched. Attribute names are compared case-insensitively (both sides are lower-cased). Separately, **sitewide token support** (`sitewide_token_support`) stores the attributes in the session at post-login so that `[cas:attribute:<name>]` resolves anywhere on the site — optionally restricted to a whitelist in `token_allowed_attributes` — and a helper page at `/admin/config/people/cas/attributes/available` lists the attributes and tokens for the currently logged-in CAS user. Note that field-mapping tokens work even when sitewide token support is off, because the subscriber passes the attributes directly into the token replacement.

---

- Populate a new CAS user's e-mail address from an LDAP-sourced `mail` attribute.
- Overwrite the username with a friendlier `displayName` attribute from CAS.
- Fill a custom "Department" text field on the user account from an `ou` attribute.
- Keep user profile fields in sync with the identity provider on every login.
- Populate profile fields only at first registration and let users edit them afterwards.
- Grant a "Staff" role when `eduPersonAffiliation` contains `staff`.
- Grant a "Student" role when `eduPersonPrimaryAffiliation` is exactly `student`.
- Grant an "Administrator" role when a `memberOf` multi-value attribute contains a specific AD group DN.
- Use a regular expression to match a group naming convention (e.g. `/^cn=app-admins,/i`).
- Revoke a role automatically when a person leaves the group (`remove_without_match`).
- Assign a role to everyone who *lacks* an attribute value, using the `negate` flag.
- Block CAS login entirely for users who match none of the role mappings.
- Block auto-registration of CAS users who are not in any mapped group.
- Pre-fill webform fields with `[cas:attribute:mail]` / `[cas:attribute:givenname]`.
- Show the logged-in user's CAS affiliation in a block or view via a token.
- Limit which attributes are exposed as tokens with an allow-list, for privacy.
- Debug an SSO integration by viewing `/admin/config/people/cas/attributes/available`.
- Pick a specific value from a multi-value attribute with array modifiers (`[cas:attribute:memberof:first]`).
- Count multi-value attributes with `[cas:attribute:memberof:count]`.
- Join a multi-value attribute into one string (the default when no modifier is given).
- Migrate role assignment logic out of custom `hook_cas_*` code and into configuration.
- Provision a "campus" or "tenant" role from an attribute so one site serves several groups.
- Combine with CAS's "Auto register users" so accounts are created fully populated.
- Deploy identical attribute→role rules across environments as exported configuration.
- Map an integer or list_string user field (only string/list_string/integer fields are offered).
- Keep Drupal roles authoritative from the IdP rather than managed by hand.
