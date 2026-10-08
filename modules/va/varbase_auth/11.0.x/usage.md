Varbase Social Single Sign-On (`varbase_auth`) is a thin Varbase feature that bundles the Social Auth provider ecosystem (Google, Facebook, LinkedIn and others) and themes a social-login block and per-provider buttons onto the login and register pages, so visitors can sign in with an identity they already have instead of creating yet another password.

---

Nearly all of the real work here belongs to other projects. `varbase_auth` requires and glues together `social_api`, `social_auth`, and the `social_auth_google` / `social_auth_facebook` / `social_auth_linkedin` provider modules; its own code is a small set of procedural hooks in `varbase_auth.module`. `hook_preprocess_page()` runs on the `user.login` and `user.register` routes and sets the template boolean `varbase.we_do_have_enabled_social_auth_modules` (via the `varbase_auth__add_template_variable()` helper in `includes/helpers.inc`) so a theme can show or hide the social buttons. `hook_preprocess_login_with()` maps each enabled Social Auth network to the matching provider logo shipped under `images/social_auth/…`, exposing them as `custom_networks`. `hook_theme()` registers the `login_with` and `block_social_auth_html` theme hooks (templates in `templates/`), and `hook_library_info_alter()` swaps Social Auth's `auth-icons` CSS for this module's `auth-icons` library when the active theme is `gin`. It defines no routes, no permissions, no config schema, no services, and no config_rewrite. Unlike the previous 10.1.x series, this 11.0.x release drops the OOP hook class, the install recipe, the optional pre-placed block config, and the `vardot/varbase-patches` requirement — so out of the box it no longer auto-enables a provider or auto-places a block; enabling providers and placing the block is left to the site (the Varbase distribution and its themes wire this up).

Because it holds no OAuth logic of its own, every meaningful configuration decision — client IDs and secrets, redirect URIs, and account linking — is made in Social Auth and its per-provider modules, not here. Three things are worth being deliberate about with any social login, and they live in Social Auth's configuration: account linking (whether a social identity whose email matches an existing local account may log into that account), provider outages becoming login outages for anyone without a local password, and each provider being a data-sharing relationship for the site's privacy notice. The core requirement is a single pinned Drupal minor (`~11.4.0`), so the module travels with the Varbase release cycle.

---

- Let visitors sign in with an existing Google, Facebook or LinkedIn account.
- Reduce friction on registration for a community or portal site.
- Theme a "Login with" social button group onto the login and register pages.
- Get Varbase's expected shape of the Social Auth integration in one install.
- Render each provider with the branded logo shipped under `images/social_auth/`.
- Add Google, Facebook or LinkedIn sign-in by enabling their provider modules.
- Reuse the Social API / Social Auth provider ecosystem instead of hand-wiring OAuth.
- Show or hide the social buttons on login/register via the template boolean it sets.
- Swap in this module's `auth-icons` CSS when the site runs the `gin` admin theme.
- Configure client IDs, secrets and redirect URIs in each Social Auth provider module.
- Decide how social identities link to local accounts (in Social Auth, not here).
- Review Social Auth's email-matching and verification before enabling on privileged sites.
- Keep a local password path available for staff accounts against provider outages.
- Document social data sharing in the site privacy notice and EU lawful-basis analysis.
- Install on a non-Varbase Minimal or Standard site that still wants social login.
- Migrate a community from local-only accounts toward social sign-on.
- Audit account-linking rules on an inherited site running this module.
- Place the social-login block yourself (no pre-placed block config ships in 11.0.x).
- Enable your chosen providers explicitly (11.0.x no longer auto-enables one on install).
- Align a social-login rollout with the Varbase distribution's release cadence.
- Add or remove offered providers by managing the Social Auth provider modules.
- Customize the login/register button markup by overriding the `login_with` template.
