oauth2_client_example_plugins is a demonstration submodule of OAuth2 Client that ships four ready-to-read `Oauth2Client` plugins showing each grant type and each optional plugin interface, wired against a mock OAuth2 server.

---

Enabling this submodule registers four `oauth2_client` plugins you can read as templates for writing your own. `authcode_example` (id `authcode_example`) is a plain `authorization_code` client using the `StateTokenStorage` trait (one shared token in Drupal State). `resource_owner_example` uses the `resource_owner` (password) grant, also with `StateTokenStorage`. `authcode_redirect_example` adds `Oauth2ClientPluginRedirectInterface` and the `TempStoreTokenStorage` trait (per-user token), overriding `getPostCaptureRedirect()` to send the user to the site front page after the code is captured. `authcode_access_example` adds `Oauth2ClientPluginAccessInterface`, restricting the `oauth2_client.code` capture route via `codeRouteAccess()` (requires the `access content` permission), again with `TempStoreTokenStorage`. The auth-code examples target the public mocklab.io mock server (`https://oauth.mocklab.io/...`); the resource-owner example points at `example.com`. The submodule ships no config, no schema, and no permissions of its own — it is purely illustrative plugin code, and you would normally copy a pattern into your own module rather than depend on it in production.

---

- Read a minimal `authorization_code` client plugin as a copy-paste starting point (`authcode_example`).
- See how to store a single shared access token in Drupal State (`StateTokenStorage`).
- See how to store a per-user token in the private tempstore (`TempStoreTokenStorage`).
- Learn the `resource_owner` (username/password) grant setup from `resource_owner_example`.
- Learn how to override where a user lands after code capture (`getPostCaptureRedirect()`).
- Learn how to gate the code-capture route with a custom access check (`codeRouteAccess()`).
- Test the OAuth2 Client authorization-code flow against the mocklab.io mock server.
- Inspect real `#[Oauth2Client(...)]` attribute usage with authorization/token URIs.
- Compare the four grant/interface combinations side by side in one module.
- Use the example plugin ids when creating `oauth2_client` config entities for a demo.
- Understand which optional interfaces a client plugin may implement.
- Bootstrap a local OAuth2 integration tutorial or workshop.
- Verify the module is installed correctly by confirming the example plugins are discoverable.
- Demonstrate the redirect-capture route (`/oauth2-client/{plugin}/code`) end to end.
- Provide fixtures for functional tests of OAuth2 Client behavior.
- Show how `success_message` is set on a client plugin (`authcode_example`).
- Serve as a reference for the difference between State vs TempStore token sharing.
- Prototype an authorization-code login button against a mock provider before wiring a real IdP.
- Illustrate that credentials are supplied by a config entity, not the plugin.
- Teach new developers the OAuth2 Client plugin structure without external accounts.
