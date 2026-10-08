<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# login_path_helper — agent start

One block ("Login Path Helper") that renders a login link whose target embeds the **current page path**
as a `destination`, so users return to where they were after login/SSO. Config at
`/admin/config/login_path_helper` (perm `administer site configuration`): `login_path_helper_linkname`
(text) and `login_path_helper_urlprefix` (default `user/login?destination=`; SAML: `saml_login?destination=`).
Block cache max-age is 0. No dependencies, no own permissions.
