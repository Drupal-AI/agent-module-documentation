<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth is a base framework (built on Social API) for letting users register and log in to Drupal with external identity providers via OAuth2. It provides the shared login/registration flow, settings, a login block, and a "social auth profile" entity; each concrete provider (Google, Facebook, GitHub, etc.) ships as its own `social_auth_*` implementer module.

---

Social Auth does not integrate any single provider by itself — it is the common machinery that provider modules plug into. It defines the OAuth redirect/callback routes (`user/login/{network}` and `user/login/{network}/callback`), a `UserAuthenticator` service that maps a returning provider identity to a Drupal account (log in existing, associate to the current user, or create a new user honoring the module's `user_allowed`/`disable_admin_login`/`disabled_roles` policy), a `UserManager` that creates users and stores the provider↔user link, and a `SocialAuthDataHandler` for session storage during the handshake. Provider identities are stored as `social_auth` content entities ("Social Auth profiles"), listed per-user and site-wide. Site behavior is configured at `/admin/config/social-api/social-auth` (the Social API integrations page); per-provider client ID/secret/scopes/endpoints are entered on a settings form at `/admin/config/social-api/social-auth/{network}` (stored in each provider's own `<network>.settings` config). A `login_with` theme hook and the "Social Auth Login" block render the provider icons/links. It fires events at key points (user fields gathering, user created, user login, before redirect, failed auth) so other modules can react. Using it in practice requires (a) a provider implementer module and (b) an OAuth application registered with that external provider — the client ID/secret — which is an external dependency you cannot exercise without the provider.

---

- Provide "Sign in with …" social login as the base for Google/Facebook/GitHub/etc. modules.
- Let visitors register a new Drupal account from an external identity provider.
- Log in existing users who have linked a provider account.
- Associate an additional provider to an already-logged-in user (from their user edit form).
- Restrict social login to "login only" (no new registrations) via `user_allowed`.
- Allow both registration and login via `user_allowed: register`.
- Block social login for the admin (user 1) with `disable_admin_login` for security.
- Disable social login for specific roles via `disabled_roles`.
- Redirect users to a chosen path after login via `post_login`.
- Send newly created users to the Drupal user edit form (`redirect_user_form`) to complete their profile.
- Show provider login buttons anywhere via the "Social Auth Login" block.
- Render provider links in a template through the `login_with` theme hook.
- Manage each user's linked provider identities from `/user/{uid}/social-auth/profiles`.
- Administer all social auth profiles site-wide (list builder + delete).
- Automatically delete a user's social auth profiles when the Drupal user is deleted.
- React to a new social-auth user creation via the `USER_CREATED` event.
- React to social-auth logins via the `USER_LOGIN` event.
- Alter the user fields used when creating an account via the `USER_FIELDS` event.
- Add query/state before redirecting to the provider via the `BEFORE_REDIRECT` event.
- Handle provider-side authentication failures via the `FAILED_AUTH` event.
- Store per-provider client ID, secret, scopes, and data-collection endpoints on the network settings form.
- Build a brand-new provider integration by extending Social Auth's Network plugin base and OAuth2 manager.
- Download and store a provider avatar as the user's picture during account creation.
- Centralize social login policy across many providers in one `social_auth.settings` config.
- Give site admins a single Social API integrations screen listing all installed auth providers.
