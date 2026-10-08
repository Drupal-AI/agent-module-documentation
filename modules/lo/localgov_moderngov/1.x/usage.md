<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov ModernGov serves a single public "template page" at `/moderngov-template` that the external Modern.Gov (Civica) democratic-services platform fetches and uses to skin its own generated council site.

---

Modern.Gov is a committee/democratic-services system used by many UK councils; when given a template-page URL it periodically fetches that page and reuses its markup to generate the council's Modern.Gov site. This module provides that page: enabling it exposes `/moderngov-template`, rendered through a `page__moderngov_template` theme template that is your normal page shell with four **literal placeholder tokens** left in place of dynamic parts — `{pagetitle}`, `{breadcrumb}`, `{content}`, and `{sidenav}` — which Modern.Gov substitutes on its side. A response subscriber rewrites all root-relative asset and link URLs to **absolute** URLs (a Modern.Gov requirement) and serves reduced variants via query parameters: `?nocontent` (empty `<main>`), `?header` (just the header plus its scripts/styles), and `?footer` (just the footer plus trailing scripts). The data flow is **outbound only** — Modern.Gov pulls the page from you; the module makes no external API calls, stores no credentials, and fetches no council data. The shipped `page--moderngov-template.html.twig` is an **example** most sites should copy into their own theme and adapt so the tokens sit correctly in the real layout. There is no settings form: the path is fixed (add a URL alias to serve it elsewhere), BigPipe is turned off on the route, and access uses core's `access content` permission because the page is meant to be consumed anonymously. Note that relative URLs inside inline JavaScript are not converted to absolute.

---

- Enable the module to publish the Modern.Gov template page at `/moderngov-template`.
- Give a council's Modern.Gov instance the `/moderngov-template` URL to consume.
- Provide a Drupal-themed shell for a Modern.Gov-generated council site.
- Keep site branding/header/footer consistent between Drupal and Modern.Gov.
- Use `{pagetitle}` where Modern.Gov should inject the page title.
- Use `{breadcrumb}` where Modern.Gov should inject its breadcrumb.
- Use `{content}` where Modern.Gov should inject the main content.
- Use `{sidenav}` where Modern.Gov should inject the side navigation.
- Serve absolute asset/link URLs automatically, as Modern.Gov requires.
- Fetch the empty-content variant with `/moderngov-template?nocontent`.
- Fetch only the header markup with `/moderngov-template?header`.
- Fetch only the footer markup with `/moderngov-template?footer`.
- Copy `templates/page--moderngov-template.html.twig` into your theme and customize it.
- Reposition the four tokens to match your theme's real page layout.
- Add a URL alias to `/moderngov-template` if you need a different public path.
- Rely on the `page--moderngov-template` body class to style the template page.
- Serve the template page to anonymous users (core `access content`).
- Run it on a LocalGov Drupal council site integrating with Modern.Gov.
- Avoid inline-JS relative URLs, which are not rewritten to absolute.
- Test the generated page in Modern.Gov's reverse-CMS preview before go-live.
- Review the template after theme upgrades to keep token placement correct.
- Disable the module if the site no longer integrates with Modern.Gov.
