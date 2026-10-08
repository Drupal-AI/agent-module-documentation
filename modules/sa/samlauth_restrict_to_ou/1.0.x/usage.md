<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SAML Authentication Restrict to OU refuses site access to SAML-authenticated users whose Organizational Unit attribute is not on an approved list.

---

Federated login answers *who you are* and says nothing about *whether you belong here*: a university or enterprise identity provider authenticates everyone in the directory, so a site meant for one faculty, department or business unit needs a second gate after authentication succeeds. This module is a small add-on to the **`samlauth`** module that adds that gate using the **Organizational Unit** attribute carried in SAML assertions (typically an Active-Directory Distinguished Name such as `CN=jdoe,OU=Staff,OU=Users,DC=corp`). Install it with `composer require drupal/samlauth_restrict_to_ou`, enable it (`drush en samlauth_restrict_to_ou`), then configure it at **`/admin/config/people/saml-restrict`** (Configuration → People, permission *Administer SAML Authentication Restrict to OU*): tick **Restrict Login to OUs** (the master switch — while off, all SAML users pass), set the **SAML Attribute Name** that carries the OU data (default `dn` for Active Directory), list the **Allowed OUs** one per line *without* an `ou=` prefix, optionally turn on **Strict Mode**, and optionally customise the **Access Denied Message**. Under the hood it hooks samlauth's `user_sync` event, which fires *after* the IdP response is validated but *before* the user is logged in or an account is created; it pulls every `OU=…` component out of the attribute and matches it against your list. Matching is **case-insensitive whole-value equality**, not substring — `Staff` admits `OU=Staff` but not `OU=Staff Contractors` — and in the default (non-strict) mode belonging to **any one** listed OU is enough, whereas Strict Mode requires the user to belong to **all** of them. A user who does not qualify is turned away before any account or session is created, and someone whose directory OU no longer matches is refused on their next login, so the check is an ongoing control rather than a one-time filter. The main operational caveat is that OU values are strings owned by another system: a directory reorganisation that renames them will stop the list matching (usually locking people out), so decide who watches for that, and remember that enabling the restriction with an **empty** OU list lets everyone in.

---

- Restrict a Drupal site to one faculty or school.
- Allow only one department to log in through SAML.
- Gate access by Active Directory Organizational Unit.
- Refuse authenticated users who belong to another business unit.
- Limit an intranet to a single division.
- Add an authorization layer on top of SSO/SAML sign-in.
- Prevent contractors in a separate OU from accessing a site.
- Restrict a research portal to one department.
- Enforce an access policy straight from the directory structure.
- Avoid building and maintaining manual account-approval workflows.
- Require membership of every listed OU (Strict Mode) for sensitive sites.
- Allow membership of any one of several OUs (default mode).
- Keep student accounts out of a staff-only tool.
- Reuse an existing AD/LDAP structure for site access decisions.
- Show a custom, high-visibility "access denied" message to rejected users.
- Toggle the whole restriction on or off without losing its configuration.
- Reduce account-provisioning and role-assignment overhead.
- Support a devolved university structure with per-site OU rules.
- Turn a broad enterprise IdP into per-site access control.
- Enforce a group-wide access standard across several sites.
