<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Only one permission, machine name `administer url_embed` ("Administer the Url Embed
module"). It gates the single admin route `url_embed.admin`
(`/admin/config/media/url_embed`, the Facebook/Instagram App ID + Secret settings form). No
other route or action in the module is permission-gated directly — using the filters/embed
in content is controlled by normal text-format `use <format>` permissions, and the CKEditor 5
dialog route is gated by a separate access check (see
`agent/configure/text-format-and-toolbar.md`), not by this permission.
