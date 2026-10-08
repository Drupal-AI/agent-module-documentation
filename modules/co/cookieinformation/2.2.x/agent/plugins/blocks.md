# Cookie Information blocks

Two block plugins, both extending `CookieInformationBlockBase`
(`src/CookieInformationBlockBase.php`). Place them at *Structure → Block layout* (category
"Cookieinformation").

| Block id | Class | Renders |
|---|---|---|
| `cookieinformation_cookie_policy_block` | `Plugin/Block/CookiePolicyBlock` | `<script id="CookiePolicy" src="https://policy.app.cookieinformation.com/cid.js" data-culture="<lang>">` — the platform's cookie-declaration table. |
| `cookieinformation_privacy_controls_block` | `Plugin/Block/PrivacyControlsBlock` | `<div id="cicc-template"></div>` — container the platform fills with re-consent / privacy controls. |

## Access

`CookieInformationBlockBase::blockAccess()` returns allowed only when `VisibilityService::checkAll()`
passes (same gate as the popup — see [../configure/settings.md](../configure/settings.md)). So the blocks
respect `enable_popup`, exclude-paths, exclude-admin, exclude-uid-1, and the
`disable cookie information consent` permission. `build()` returns nothing until overridden by the
subclass; the Cookie Policy block allows the `<script>` tag via `#allowed_tags`.

## Notes

- The `data-culture` on the policy block uses the same validated language id as the popup
  (`LanguageService::getId()`).
- Typical placement: the Cookie Policy block on a dedicated "Cookie policy" page; the Privacy Controls
  block in a footer so users can reopen their consent choices.
- These blocks only render the platform's UI; actual consent data and templates are managed on the
  Cookie Information platform, not in Drupal.
