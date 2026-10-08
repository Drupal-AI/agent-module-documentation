# Configuration

Front Page is configured on a single screen where you set a front page for each
role, choose how that page is produced, and decide the order roles are evaluated in.

## Open the settings

1. Log in as a user with the **Administer front page** permission.
2. Go to **Configuration → System → Front page**
   (`/admin/config/system/front-page`).

You'll see a row for each user role.

## Choose a method per role

For each role, pick how its front page should be produced:

- **Redirect** — send users in this role to a **local or remote URL**. Enter the
  destination; the user is redirected there when they hit the front page. (The target
  is fixed here by you, not taken from the request, so it isn't an open‑redirect
  risk — but still point it only where you intend.)
- **Themed** — enter **static text** that is placed into the content area of a normal,
  fully themed Drupal page. Good when you want a simple custom home page that still
  wears your theme.
- **Full** — enter **static content** that is output exactly as you type it, *without*
  passing through Drupal's theming system. Use this when you need complete control
  over the markup of the page.

Leave a role's page unspecified (see **Skip**, below) if you don't want to override it.

## Order the roles

Because a user can have more than one role, the order matters: Front Page evaluates
roles from top to bottom and uses the first matching role's front page. Use the
**drag‑and‑drop** handles to arrange roles so the one you want to take precedence sits
higher in the list. For example, put a specific "Member" role above the generic
"Authenticated user" role if members should get their own home page.

## Skip a role

Each role can be set to **skip**, meaning it does not define a front page of its own.
When a role is skipped, the user falls through to the next applicable role in the
order — and if nothing else matches, to Drupal's **core front page** setting. This
lets you configure only the roles you care about and let everyone else use the
default.

## Save

Save the form. The role‑based front pages take effect immediately — log in as users
with different roles (or use an incognito window for anonymous) to confirm each lands
where you intended.
