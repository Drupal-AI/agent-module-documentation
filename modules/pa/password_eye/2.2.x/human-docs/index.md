# Password Eye — manual setup guide

**Password Eye** (`password_eye`) adds a small show/hide "eye" icon next to
password fields on the forms you choose, so users can reveal what they typed and
catch typos before submitting. Clicking the icon toggles the input between hidden
(dots) and plain text — the same affordance people are used to from modern login
screens.

It is a tiny JavaScript enhancement driven by a single setting: a list of form
IDs to enhance. Out of the box, once enabled, it targets the **user login form**
(`user_login_form`). From the settings form you can add more forms — the
registration form, a change-password form, a custom or checkout form — by listing
their form IDs, or remove the login form to switch the feature off there. The
module has no dependencies of its own and ships no submodules. It adds no
permission of its own; its settings page is restricted to the administrator role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which forms get the eye icon.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Password Eye Settings**
(`/admin/config/system/pssword_eye-settings`). Note that the path segment is
misspelled `pssword_eye-settings` in the module — that is the real URL, not a
typo in this guide.
