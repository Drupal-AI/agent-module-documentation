DocCheck Basic gates medical/pharmaceutical content behind the DocCheck login by logging returning visitors into one pre-configured Drupal account.

---

DocCheck Basic connects a Drupal site to the DocCheck login (basic license), the identity system many pharma and medical publishers use to restrict content to verified healthcare professionals. The module renders a DocCheck login button as a block and as a page (`/doccheck-login`), and exposes a callback route (`/_dc_callback`) that DocCheck redirects the browser back to after the user authenticates on DocCheck. On a valid return the module logs the visitor into a single, pre-selected Drupal user account (the "Login as User"), and access to protected content is then governed entirely by that account's Drupal role, permissions and block-visibility settings — the module itself defines no permissions and hides no content. Configure the OAuth2 client secret to enable server-side verification of the DocCheck authorization code (via the `doccheck/oauth2-doccheck` League provider against `https://auth.doccheck.com/`); a development mode offers a direct login link for pre-launch testing, and an IP-based auto-login provider lets the DocCheck search crawler index protected pages. Configuration lives in a single config object (`config.doccheck_basic`) under Administration > Configuration > People > DocCheck Basic.

---

- Gate a group of Drupal nodes so only DocCheck-authenticated healthcare professionals can view them.
- Add a DocCheck login button to any page by placing the "DocCheck Basic" block in a region.
- Provide a dedicated login landing page at `/doccheck-login` for use in menus, emails or DocCheck's website directory.
- Restrict pharmaceutical product information to verified physicians for regulatory compliance.
- Map every DocCheck visitor onto one shared Drupal account with a purpose-built, minimally-permissioned role.
- Choose a small, medium or large DocCheck login button to match the site theme.
- Localize the DocCheck button language automatically from the current Drupal interface language.
- Return the visitor to the exact protected page they requested after they log in (via the stored `dc_page` session value).
- Send page-based logins to a fixed landing node by setting the "Page login redirect" path.
- Verify the DocCheck authorization code server-side by supplying an OAuth2 Login-Client-Secret.
- Run a pre-launch site without a live DocCheck account using development mode's direct login link.
- Let the DocCheck search crawler auto-login from a whitelisted IP so protected content is indexed.
- Integrate DocCheck login into a multilingual medical portal.
- Combine with the r4032login module to redirect 403 (access denied) responses to the DocCheck login page.
- Combine with the userprotect module to lock the shared account's edit page as advised.
- Configure per-content-type or per-node view access for the shared DocCheck role using core node permissions.
- Show or hide menu items and blocks depending on whether the visitor has completed DocCheck login.
- Set the DocCheck Login-Client-ID from the admin form or via `drush config-set config.doccheck_basic dc_loginid <id>`.
- Toggle development mode off for production with `drush config-set config.doccheck_basic dc_devmode 0`.
- Stamp a DocCheck login wall onto an existing content section without writing custom code.
- Present healthcare-professional-only downloads (PDFs, media) behind the shared account's file access.
- Give sales-rep or event microsites a lightweight DocCheck gate distinct from full user registration.
