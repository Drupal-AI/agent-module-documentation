# Configuration

Frontpage Per Language has **no dedicated settings page**. Instead it extends
Drupal's core *Basic site settings* form, adding one front-page field per language.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Basic site settings**
   (`/admin/config/system/site-information`).

## Set a front page per language

When your site has more than one language, the **Front page** section of this form
shows a **Default front page for `<language>`** textfield for each *non-default*
language (each is prefixed with the base URL and the language's URL prefix so you
can see where it points). Your default language's front page continues to use
core's own "Default front page" field.

For each language, enter the path that should serve as its home page. A few rules to
keep in mind:

- The path **must start with a `/`** (for example `/de/home` or a view path).
- It **must be a valid, accessible path** on your site — the module validates this
  when you save, so a typo or an inaccessible path is rejected.
- The target can be a node, a view, or any routable page.

Click **Save configuration**. From then on, when a visitor reaches `/` while
browsing in that language, the module rewrites the request to the path you entered.
Front-page-only blocks and front-page caching continue to behave correctly, and the
front page emits `hreflang` alternate links for every language.

## Export your configuration

The values are stored in Drupal's `system.site` configuration (as
`page.front_<langid>` keys, with hyphens stripped from the language code — so
`pt-br` becomes `page.front_ptbr`). After making changes, **export your
configuration** (for example `drush config:export`) so the per-language front pages
are captured in your config and deployed with the rest of your site.
