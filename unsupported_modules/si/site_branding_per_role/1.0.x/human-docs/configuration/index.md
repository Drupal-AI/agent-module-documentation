# Configuration

Everything about Site Branding Per Role is configured on the block itself — there is no
separate settings page and no extra permission beyond the standard **Administer blocks**
needed to place blocks.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want your branding (usually the header), click **Place
   block** and choose **Site branding per role block**.

The block's configuration form opens automatically when you place it (and you can
return to it any time via the block's *Configure* link).

## Choose which elements to show

Three checkboxes control the branding elements, each shown only when ticked:

- **Site logo** — display the logo (its link target is the per-role part, below).
- **Site name** — display the site name (from your Basic site settings).
- **Site slogan** — display the slogan (from your Basic site settings).

Their descriptions link through to the Appearance/Theme and Site Information settings
when your user can reach those pages.

## Set a link per role

Under an **All roles** fieldset the form lists **every role on your site** with a
**required** text field for each. Enter the path you want the logo to point to for
users in that role. For example, send `administrator` to an admin dashboard and
`anonymous` to the front page.

Each URL is validated when you save. A value must either be `<front>` (the site front
page) or start with `#`, `?`, or `/`, and it must be a valid path — otherwise the form
shows an error for that role and will not save until it is corrected. External
(`http://…`) URLs are not accepted here; these are internal-path links.

## How the right link is chosen at view time

When a visitor loads the page, the block picks the logo link for their role using this
order of precedence:

1. **administrator** — if the viewer has the administrator role, its link is used.
2. **anonymous** — otherwise, if the viewer is anonymous, its link is used.
3. **an authenticated user with another role** — the first non-`authenticated` role's
   link is used.
4. **a plain authenticated user** — the `authenticated` link is used.
5. **fallback** — if none of the above resolves, the logo links to the front page
   (`/`).

## Save

Click **Save block**. The branding block renders with your chosen elements and
role-aware logo link. Because the block inherits the `system.site` cache tags, editing
your site name or slogan later automatically refreshes what the block shows.
