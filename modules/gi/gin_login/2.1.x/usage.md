Gin Login restyles Drupal's user login, registration, password-reset and logout pages to match the Gin administration theme, giving the front door of the admin experience a modern, branded look with a custom logo and full-screen wallpaper.

---

Out of the box the Drupal `/user/login`, `/user/register` and `/user/password` pages use the site's front-end theme and look nothing like the polished Gin admin backend. Gin Login provides a dedicated theme negotiator that switches those user-authentication routes to Gin, plus a set of Twig templates and CSS that lay the form over a centered card with a large brand wallpaper beside it. It attaches Gin's own libraries and settings (accent color, focus color, dark mode, high-contrast mode) so the login screen honors whatever accent theming the site has configured for Gin. A small configuration form at Admin → Configuration → System → Gin Login lets you choose whether to use the default Drupal logo or upload/point to a custom one, and whether to show a random built-in wallpaper or supply your own brand image. The module rewrites the user forms via `hook_form_alter` to add "Create new account" and "Forgot your password?" action links and to relabel buttons. Because it only affects the anonymous user pages it has no bearing on the rest of the site's theme. Developers can extend which routes are treated as "login" pages through `hook_gin_login_route_definitions_alter`. It requires the Gin theme to be installed to render its full styling. Configuration is stored in the exportable `gin_login.settings` config object.

---

- Give the admin login page a modern look that matches the Gin backend.
- Show a full-screen branded wallpaper next to the login form.
- Upload a custom logo for the login and registration screens.
- Point the logo at an existing file path in the public files directory.
- Use one of the module's bundled random wallpapers with zero setup.
- Replace the default wallpaper with a company brand image.
- Honor the site's Gin accent color on the login screen.
- Respect Gin dark mode on the authentication pages.
- Respect Gin high-contrast mode for accessible login styling.
- Add a "Create new account" button to the login form.
- Add a "Forgot your password?" link to the login form.
- Add a "Log in" link back from the register and password pages.
- Show the maintenance-mode message on the login form when the site is offline.
- Restyle the password-reset (`user_pass`) form to match Gin.
- Restyle the account registration form to match Gin.
- Restyle the logout-confirmation page to match Gin.
- Brand a client's Drupal editorial login without a custom theme.
- Keep login branding in code as exportable configuration.
- Provide a consistent first impression for content editors signing in.
- Extend the set of routes treated as login pages via an alter hook.
- Swap the login theme automatically only for anonymous user routes.
- Deploy the login logo/wallpaper settings between environments as config.
- Give a decoupled or headless admin a polished sign-in surface.
- Match the login accent color to a brand palette configured in Gin.
- Provide a cleaner alternative to the stock Bartik/Olivero login form.
