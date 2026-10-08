<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Social Single Sign-On (`varbase_auth`) is a thin Varbase feature that bundles the Social Auth provider ecosystem (Google, Facebook, LinkedIn and others) and drops a social-login block onto the login and register pages, so visitors can sign in with an identity they already have instead of creating yet another password.

---

Nearly all of the real work here belongs to other projects. `varbase_auth` requires and glues together `social_api`, `social_auth`, and the `social_auth_google` / `social_auth_facebook` / `social_auth_linkedin` provider modules; its own code is a single Drupal 11 OOP hook class (`VarbaseAuthHooks`) whose one `preprocess_page` hook sets a boolean template variable (`varbase.we_do_have_enabled_social_auth_modules`) on the `user.login` and `user.register` routes so a theme can show or hide the social buttons. On install it runs a recipe that enables `social_auth_google`, and it ships an *optional* block (`social_auth_login`, labelled "Login with") that the Varbase theme `vartheme_bs4` places in the content region on `/user/login` and `/user/register`. It defines no routes, no permissions, no config schema, no services beyond registering that hook class, and performs no config_rewrite. Because it holds no OAuth logic of its own, every meaningful configuration decision — client IDs and secrets, redirect URIs, and account linking — is made in Social Auth and its per-provider modules, not here.

Three things are worth being deliberate about with any social login, and they live in Social Auth's configuration rather than in this module. **Account linking is the security-relevant part**: whether a social identity whose email matches an existing local account is allowed to log into that account decides whether control of a provider account can grant control of a local one — review Social Auth's email-matching and verification behaviour before enabling this where privileged local accounts exist. **Provider outages become login outages** for anyone who has no local password, so keep a local password path for staff. **Every provider is a data-sharing relationship** — identity, usually email and profile data — which belongs in the site's privacy notice and, on an EU site, its lawful-basis analysis. The core requirement is a single pinned Drupal minor (`~11.4.0`), so the module travels with the Varbase release cycle.

---

- Let visitors sign in with an existing Google, Facebook or LinkedIn account.
- Reduce friction on registration for a community or portal site.
- Add a "Login with" social block to the login and register pages.
- Get Varbase's expected shape of the Social Auth integration in one install.
- Enable Google sign-in out of the box (the install recipe does this).
- Add Facebook or LinkedIn sign-in by enabling their provider modules.
- Reuse the Social API / Social Auth provider ecosystem instead of hand-wiring OAuth.
- Show or hide social buttons on login/register via the template boolean it sets.
- Place the social-login block through the `vartheme_bs4` theme on a Varbase site.
- Configure client IDs, secrets and redirect URIs in each Social Auth provider module.
- Decide how social identities link to local accounts (in Social Auth, not here).
- Review Social Auth's email-matching and verification before enabling on privileged sites.
- Keep a local password path available for staff accounts against provider outages.
- Document social data sharing in the site privacy notice and EU lawful-basis analysis.
- Install on a non-Varbase Minimal or Standard site that still wants social login.
- Migrate a community from local-only accounts toward social sign-on.
- Audit account-linking rules on an inherited site running this module.
- Track which providers registered users actually authenticate with.
- Align a social-login rollout with the Varbase distribution's release cadence.
- Add or remove offered providers by managing the Social Auth provider modules.
