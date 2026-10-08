Eloqua API Auth Fallback lets Eloqua API Redux re-authenticate to Eloqua non-interactively using an OAuth resource-owner password credentials grant, with a Drush command to generate or renew tokens on demand.

---

The parent module, Eloqua API Redux, authenticates with the interactive OAuth authorization-code flow: an administrator clicks through Eloqua's login screen and Drupal captures the returned tokens. That works for setup but breaks down for unattended sites — if the stored refresh token lapses (Eloqua refresh tokens expire after a year, or immediately once used), there is nobody at a browser to log back in and the integration silently stops working.

This submodule fills that gap. It stores the Eloqua site (company) name, username, and password, and implements the OAuth resource-owner password credentials grant so tokens can be minted from those credentials with no browser interaction. It plugs into the parent by decorating the `eloqua_api_redux.auth_fallback_default` service (via `decorates:` in its services file), so the parent client automatically calls into it when both the access and refresh tokens are gone. The same class is also registered as a Drush command, `eloqua_api_auth_fallback:generate-tokens` (alias `eloqua-gt`), so an administrator or a cron job can force a token refresh explicitly.

Configuration lives at a settings page nested under the parent's Eloqua API settings, gated by the parent's `administer eloqua api settings` permission. Use this submodule when you run Eloqua syncs from cron or a headless process and need the connection to stay alive without a human completing the browser login.

---

- Keep an Eloqua integration authenticated on an unattended/headless site.
- Re-authenticate automatically when both access and refresh tokens have expired.
- Use the OAuth resource-owner password credentials grant instead of the browser flow.
- Store the Eloqua site name, username, and password for non-interactive login.
- Generate or renew Eloqua tokens from a Drush command (`drush eloqua-gt`).
- Refresh tokens on a schedule from cron before a sync runs.
- Recover a stalled integration whose refresh token lapsed without visiting the settings page.
- Provision Eloqua tokens during an automated deployment.
- Back a Drupal-to-Eloqua contact or webform sync that runs without an operator.
- Configure fallback credentials from a settings page under the Eloqua API settings.
- Extend the parent client's auth-fallback service via service decoration.
- Restrict who can set the fallback credentials to Eloqua administrators.
