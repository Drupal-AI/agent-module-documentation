<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social API is the shared foundation of the Drupal Social Initiative: it defines a `Network` plugin type that wraps a third-party social-network SDK, plus base classes for OAuth2 flows, per-implementer settings, session data handling, user authentication and encrypted token storage.

---

Social API is a framework module — on its own it renders one admin landing page and nothing else. Its core is the `Network` plugin type: plugins live in `src/Plugin/Network/` of an implementer module, are annotated with `@Network` (`id`, `socialNetwork`, `type`, `className`, `handlers`) and are managed by the `plugin.network.manager` service (alter hook `social_api_network_info`, cache key `social_api_network_plugins`). `NetworkBase` handles instantiation: it injects the logger factory, site settings, entity type manager, config factory and the network manager, and its `init()` reads `handlers.settings.class` + `handlers.settings.config_id` from the plugin definition, loads that config and calls `<class>::factory($config)` to build a `SettingsInterface` object; a missing class or a class that does not implement `SettingsInterface` throws a `SocialApiException`. Subclasses implement `initSdk()`, and callers use `getSdk()`, which lazily instantiates and caches the SDK client. Around that sit `OAuth2Manager` (abstract; holds the provider client, access token, settings and current request, and declares `authenticate()`, `getAuthorizationUrl()`, `getState()`, `getUserInfo()`), `SocialApiDataHandler` (session read/write behind a per-implementer prefix), `UserAuthenticator` + `UserManagerInterface` (mapping a provider user id to a Drupal uid, nullifying session keys on failure), the `SocialApi` content-entity base class (encrypts the serialized access token with AES-256-CBC keyed on the site hash salt, storing `base64(encrypted::iv)`), `SocialApiImplementerInstaller::checkLibrary()` (a `hook_requirements()` helper that verifies a Composer package's presence and version range) and `SocialApiException`. Five permissions are declared (`administer social api configuration`, `… authentication`, `… autoposting`, `… blocks`, `… widgets`), and the route `social_api.admin_config` renders `/admin/config/social-api` as a menu block. `SocialApiController::integrations($type)` renders a Module/Social Network table for a given integration type (`social_auth`, `social_post`, `social_widgets`), but Social API declares no route for it — implementer modules such as Social Auth and Social Post do.

---

- Provide the plugin foundation for a "Log in with Google/GitHub/Facebook" module.
- Provide the foundation for an autoposting module that pushes new nodes to a social account.
- Wrap a third-party PHP SDK (league/oauth2-client provider, vendor SDK) as a discoverable Drupal plugin.
- Give several social integrations one consistent settings/`ImmutableConfig` wrapper API.
- Store OAuth access tokens encrypted at rest instead of as plain text in the database.
- Map a provider account id onto a Drupal user id through `UserManagerInterface`.
- Keep the OAuth `state` and redirect data in the session with a per-implementer prefix.
- Nullify half-finished OAuth session keys when authentication fails.
- Expose a "which social integrations are enabled" table to site admins.
- Gate social login administration behind `administer social api authentication`.
- Gate autoposting administration behind `administer social api autoposting`.
- Gate social widget administration behind `administer social api widgets`.
- Group all social-integration settings pages under one `/admin/config/social-api` landing page.
- Fail installation early when an implementer's Composer SDK is missing or out of range.
- Let one implementer reuse another's `Network` plugin definition through the alter hook.
- Add extra handlers (settings and beyond) to a Network plugin definition without subclassing the manager.
- Lazily instantiate an expensive SDK client only when a request actually needs it.
- Share a single OAuth2 abstraction across login, posting and widget modules.
- Test a Network plugin in isolation by asserting on `getDefinitions()` and `getSdk()`.
- Log SDK errors to a per-implementer logger channel.
- Build a "connected accounts" content entity on top of the `SocialApi` entity base class.
- Rotate the encryption of stored tokens by changing the site hash salt (invalidates old tokens).
- Detect at runtime which social networks a site has integrated, by plugin `type`.
- Give a custom internal identity provider the same Drupal integration shape as public networks.
- Keep social credentials out of exported configuration by reading them from a settings class.
