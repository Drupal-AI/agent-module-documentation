# Configuration

The whole module is one small settings form. You must at least enter a Partner ID before any
tracking happens.

## Open the settings form

1. Log in as a user with the **Administer LinkedIn Insights** permission.
2. Go to **Configuration → System → LinkedIn Insights**, or navigate directly to
   `/admin/config/system/linkedin-insights`.

## The settings

- **Partner ID** (`partner_id`) — your LinkedIn Partner ID, from LinkedIn Campaign Manager.
  This field is **required** (up to 50 characters). Nothing loads on the front end until it is
  filled in, and clearing it later turns tracking off. The value is emitted safely — as an
  escaped attribute and via `drupalSettings` — not injected raw into the page.

- **Roles** (`user_role_roles`) — checkboxes of your site's user roles. The tag loads **only**
  for visitors who hold one of the ticked roles. The install default is **Anonymous** only,
  which tracks not-logged-in visitors while leaving editors and admins untracked. Tick or
  untick roles to match your consent/analytics policy.

- **Image only** (`image_only`, default **off**) — when ticked, the module skips the LinkedIn
  JavaScript library entirely and emits **only** the 1×1 tracking image pixel. Use this for
  stricter, script-light setups. When it is off, the JS library loads (for the selected roles)
  and the image pixel is additionally rendered inside a `<noscript>` fallback for visitors
  without JavaScript.

## Save

Click **Save configuration**. On the next page load, matching visitors will have the LinkedIn
Insight Tag active. You can verify with LinkedIn's Insight Tag helper or your browser's network
tab (look for requests to `snap.licdn.com` and `dc.ads.linkedin.com`).

## How the tag is emitted (for reference)

- When **image only** is off and the current user's roles match your selection, the module
  attaches the LinkedIn `insight.min.js` library from `snap.licdn.com` and passes your Partner
  ID to it via `drupalSettings`.
- When a Partner ID is set, the module also renders a hidden 1×1 `<img>` pointing at
  `https://dc.ads.linkedin.com/collect/?pid=<partner_id>&fmt=gif`, wrapped in `<noscript>`
  unless "image only" is on. The image URL is validated before it is output.
