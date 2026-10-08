# Configuration

Setting up Custom Error is two steps: write your error content on the module's
form, then tell Drupal core to use it.

## Step 1 — Write your error content

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Custom error**, or navigate directly to
   `/admin/config/system/customerror`.

The form has a section for each error code. For both **403** and **404** you set:

- **Title** — the page title (up to 70 characters). For example "Page not found"
  or "Access denied".
- **Body** — the page body. This is a textarea meant to hold **HTML**, so you can
  include links to your search page, FAQ, contact form, and so on.
- **Theme** — a theme override select. *Note:* in this release the per‑code theme
  override does not actually take effect — the error page always renders in the
  active theme — so do not rely on this field.

There is also a per‑code **Show login form** option (see below), and a global
**Redirect** field described further down.

Click **Save configuration** when done.

## Step 2 — Point Drupal core at the module (required)

The module only takes over your error pages once you tell core to use its paths.

1. Go to **Configuration → System → Basic site settings**
   (`/admin/config/system/site-information`), and find the **Error pages**
   section.
2. Set **Default 403 (access denied) page** to `/customerror/403`.
3. Set **Default 404 (not found) page** to `/customerror/404`.
4. Save.

From now on Drupal serves your custom pages — with the correct 403/404 HTTP
status — whenever a visitor hits an access‑denied or not‑found situation. You can
preview them any time by visiting `/customerror/403` and `/customerror/404`
directly.

## Show the login form on the 403 page

Each error code has a **Show login form** option. When it is enabled and an
**anonymous** visitor lands on that error page, the core user login form is
embedded on the page. After they log in, they are redirected back to the page
they were originally trying to reach. This is most useful on the **403** page: a
visitor denied access can sign in and continue without hunting for the login link.

## 404 redirects

The form has a single **Redirect** textarea for regex‑based 404 redirects. Enter
one rule per line, each as a **regular expression** followed by a space and a
**destination**:

```
^/old-news/.*  /news
^/promo-2019$  /promo
.*             <front>
```

When a request would 404, the module checks each line in order; the first regex
that matches the requested URL sends the visitor to that destination with a 302
redirect. The special keyword `<front>` resolves to your site's front page. This
lets you retire old URLs and consolidate several old paths onto new pages, all
from one field.

## Theming the error pages

The pages are rendered by the module's `customerror.html.twig` template, which
outputs the body and (when enabled) the login form. To style each code
differently, copy that template into your theme as
`customerror--404.html.twig` and `customerror--403.html.twig` — per‑code template
suggestions are provided. You can also localize the title and body through
configuration translation.

## Notes

- The settings are stored in the `customerror.settings` configuration object,
  which ships with a config schema.
- The **Show login form** flag is used by the code but is not declared in the
  config schema, so it may surface as a warning in configuration schema checks —
  this is a known quirk and does not stop it working.
