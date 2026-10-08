# Configuration

All of Domain Base Css's setup happens on one form, where you upload a stylesheet
for each domain. Before you start, make sure your domains already exist in the
Domain module — the form shows one upload field per configured domain.

## Open the settings form

1. Log in as a user with the **Administer domain css switcher setting** permission.
2. Go to **Configuration → Domain → Domain CSS Switcher**, or navigate directly to
   `/admin/config/domain/domain_css_switcher`.

## Upload a CSS file per domain

The form lists your domains, each with its own file upload field:

- **Per-domain CSS upload** — for each domain, choose the `.css` file you want that
  domain to load. Only `.css` files are accepted, and uploaded files are stored
  under `public://dbc/` so you can inspect them later. Leave a domain's field empty
  if that domain should not get an extra stylesheet.

To **change** a domain's styling, upload a new file to replace the old one. To
**remove** custom CSS from a domain, clear its upload field. Each uploaded
stylesheet is added to the page `<head>` on top of the active theme, so it augments
your theme rather than replacing it.

## Save

Click **Save configuration**. The chosen stylesheet is attached automatically on
every page of the matching domain from then on.

## Verify and troubleshoot

Visit a page on one of the configured domains and view the page source: you should
see a `<link rel="stylesheet">` tag pointing at your uploaded file. If a change
does not appear, **clear the render/page caches** (`drush cr`) and reload — cached
pages may still be serving the previous head markup.
