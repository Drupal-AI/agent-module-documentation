# Configuration

Setting up Design System is a two-step job: point it at your design system's URL,
then decide which roles are allowed to view it.

## 1. Set the target URL

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Design System**, or navigate directly
   to `/admin/config/user-interface/settings`.
3. Enter the **URL** of the page you want embedded — your Storybook, styleguide,
   kitchen-sink components page, or any other reference. This value becomes the
   `src` of the iframe shown at `/admin/design-system`, so use the full address of
   the page as you would open it in a browser.
4. **Save** the form. You can change the URL again at any time from the same page.

> **Tip:** Because the page is shown in an iframe, make sure the target allows
> being framed. A page that sends a restrictive `X-Frame-Options` or
> `frame-ancestors` header may refuse to display inside Drupal.

## 2. Grant the viewing permission

The embedded page at `/admin/design-system` is gated by the module's own
**`access design system`** permission (separate from the "Administer site
configuration" permission that controls the settings form).

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Access design system** and tick it for each role that should be able to
   open the design system — for example your themer or content-editor roles.
3. **Save permissions.**

Anyone with that permission will now see a **Design System** link in the admin
toolbar and can open the embedded page. Users without it cannot reach
`/admin/design-system`.
