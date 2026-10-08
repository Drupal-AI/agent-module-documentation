<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Noscript Tag shows a configurable message to visitors who have JavaScript disabled, via a standard `<noscript>` block.

---

The module adds an admin settings form at `/admin/config/development/noscript-tag-setting` (`NoscriptTagSettingsForm`, gated by the `administer noscript tag` permission) where you set the noscript message and related options, stored in `noscript_tag.settings`. The configured markup is rendered inside a `<noscript>` element on the page so it only appears when JavaScript is unavailable. A second permission, `view noscript tag`, governs who the tag is shown to.

It is a simple presentational aid: use it to warn JS-dependent sites' visitors, provide a fallback instruction, or meet an accessibility/communication requirement. There is no dynamic data handling beyond the admin-entered message, which is stored as configuration.

---
- Warn visitors that the site needs JavaScript enabled.
- Provide fallback instructions for no-JS browsers.
- Show a branded notice inside a `<noscript>` tag.
- Meet accessibility or compliance messaging requirements.
- Configure the noscript message from the admin UI.
- Control who sees the tag with a dedicated permission.
- Communicate degraded functionality without JavaScript.
- Point no-JS users to a supported browser or setting.
- Keep the noscript message in exportable configuration.
- Add a consistent no-JS notice sitewide.
- Avoid hardcoding a `<noscript>` block in templates.
- Update the message without touching theme code.
- Reassure users on JS-heavy interactive pages.
- Provide contact or help info to no-JS visitors.
- Localise the noscript message through configuration.
- Restrict administration of the tag to trusted roles.
