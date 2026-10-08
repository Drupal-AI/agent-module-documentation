# Configuration

Manage redirect rules at **Configuration → People → User Default Page**
(`/admin/config/people/user_default_page`). You need core's **Administer site
configuration** permission. Click to add a rule, or edit an existing one. You can
create as many rules as you need — one per audience.

## A redirect rule, field by field

- **Label** — a name to identify the rule in the list.
- **Roles** — the roles this rule targets. A rule matches a user if any of the
  user's roles is selected here.
- **Users** — a comma-separated list of user IDs the rule targets. A user-ID match
  takes priority over a role match.
- **Login redirect** — the internal path to send matching users to after they log
  in, entered as an internal URL such as `/node/5` or `/my-dashboard`.
- **Login redirect message** — an optional status message shown on the landing
  page after a login redirect.
- **Logout redirect** — the internal path to send matching users to after they log
  out.
- **Logout redirect message** — an optional message shown after a logout redirect.
- **Weight** — a tie-breaker used when several role rules match the same user; the
  highest-weight matching rule wins.

Enter redirect destinations as internal paths (leading slash, e.g. `/node/5`).
Leave a login or logout redirect blank on a rule if you only want to handle one of
the two.

## How a rule is chosen

When a user logs in:

1. The one-time-login / password-reset route is left untouched (no redirect), so
   password resets are never hijacked.
2. Among the rules, a match on the user's **ID** wins outright. Otherwise the
   highest-**weight** rule whose **roles** intersect the user's roles is used.
3. If a login message is set, it is shown, then the user is redirected.

When a user logs out, the same style of matching applies, and the module
deliberately skips autologout's own logout routes so the two modules do not fight.

## Path handling and safety

The chosen path is normalised (a scheme/host is prepended unless it already starts
with `http` or `node`), optionally rewritten for the **Rename Admin Paths** module
if that is enabled, and then **validated** before the redirect is issued. If the
configured path is no longer valid and the **Redirect** module is enabled, the
module looks for a matching redirect entry; otherwise it logs a warning and shows a
message. Because the destination always comes from this admin configuration and is
validated, there is no open-redirect exposure from request input.

## Common setups

- Send every authenticated user to a dashboard node after login (one rule targeting
  the authenticated role).
- Send editors to the content admin listing while regular users go to the front
  page (two role-targeted rules).
- Give one specific person their own landing page after login (a rule with their
  user ID).
- Show a "You have been logged out" page with a goodbye message after logout.

## Extending the ignore list

Developers can add extra routes that should never trigger a login redirect via the
`hook_user_default_page_login_ignore_whitelist_alter()` alter hook — see the
[`agent/`](../../agent/configure/config-entity.md) docs.
