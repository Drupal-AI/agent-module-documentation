Domain SSO Admin Toolbar adds a "Domains" dropdown to the admin toolbar that lets a permitted, logged-in user jump to another configured domain and be signed in there automatically via the domain_sso handshake.

---

The module implements `hook_toolbar_alter()` (in `src/Hook/DomainSsoAdminToolbarHooks.php`, registered as a service in `domain_sso_admin_toolbar.services.yml` with a `#[LegacyHook]` shim in the `.module`) to inject a `domain_sso_switcher` toolbar item whose tray lists every enabled domain as a link, marking the active one "(current)"; the item only appears for users who are authenticated and hold both `access toolbar` and `use domain sso admin toolbar`, and only when more than one enabled domain exists. Each link points at route `domain_sso_admin_toolbar.switch` (`/admin/domain-sso-switch/{domain}`, guarded by the `use domain sso admin toolbar` permission), handled by `DomainSwitchController::switchDomain()`. The controller loads the target `domain` entity, confirms the caller is authenticated, and reconstructs the current internal path from the `referer` header by running it through the `path_processor_manager` inbound processors, then builds the destination URL from the target domain's configured path plus that path and any query string. If the target shares the current domain's hostname it redirects straight there (cookies are already shared); otherwise it redirects to the domain_sso issue endpoint (`domain_sso.handshake.issue`) with `domain` and `target` query args, delegating token minting, transport, and login to the domain_sso module (HMAC-SHA256 signed, 60-second, one-time-nonce token consumed by `domain_sso.handshake.consume`). It uses the `domain.negotiation_context` service to detect the active domain and ships one theme CSS library (`toolbar_domain_switcher`). Depends on `domain`, `domain_extras:domain_sso`, and `admin_toolbar`.

---

- Add a "Domains" switcher dropdown to the Drupal admin toolbar.
- Let editors hop between affiliate domains without hand-editing URLs.
- Automatically re-authenticate the user on the target domain via domain_sso.
- Preserve the current page path when switching domains where possible.
- Carry over the query string from the current page during a switch.
- Highlight the domain you are currently browsing with a "(current)" marker.
- List only enabled domains in the switcher tray.
- Hide the switcher when only a single domain is configured.
- Restrict switcher visibility to users with `access toolbar` and `use domain sso admin toolbar`.
- Grant the `use domain sso admin toolbar` permission to trusted editor roles.
- Skip the SSO handshake and redirect directly when two domains share a hostname.
- Route cross-hostname switches through the domain_sso signed-token handshake.
- Reuse existing domain_sso token expiry and one-time-nonce handling.
- Detect the active domain through the `domain.negotiation_context` service.
- Style the toolbar item with the bundled `toolbar_domain_switcher` CSS library.
- Reach the switch action directly at `/admin/domain-sso-switch/{domain}` when needed.
