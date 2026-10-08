# Configuration

Everything about the published statement is built on one form. Until you fill it
in, the footer link points at an empty page.

## Open the settings form

1. Log in as a user with the **Administer accessibility statement** permission.
2. Go to **Configuration → System → Accessibility Statement**, or navigate directly
   to `/admin/config/system/accessibility-statement`.

## Statement type

Pick the legal framework your statement falls under; the form then shows the
conditional fields for that type:

- **Public sector body** — EU Directive 2016/2102 (and, in Germany, BITV 2.0). This
  adds an **enforcement / arbitration body** section for the complaints procedure.
- **Product or service** — the European Accessibility Act 2019/882 (German BFSG).
  This adds a **market surveillance authority** section instead.

## Page path

Sets the URL of the public statement, defaulting to `/accessibility-statement`. You
can change it to any path — for example a localized `/barrierefreiheitserklaerung`.
The module rewrites the public route from this value, so if the new path does not
appear immediately, rebuild the cache (`drush cr`).

## Conformance status

Declare how accessible the site is: **fully**, **partially**, or **not** conformant,
measured against **EN 301 549** and either **WCAG 2.1 AA** or **WCAG 2.2 AA**.

## Non-accessible content

A repeatable set of rows where you list content that is not accessible, grouped by
category:

- **Non-compliance** — content that simply does not yet meet the standard.
- **Disproportionate burden** — content excluded because fixing it would be an
  unreasonable effort.
- **Out of scope** — content the legislation does not cover.

Use the **Add** and **Remove** buttons (they update the form via AJAX without a page
reload) to build the list.

## Contact section

The feedback contact people use to report problems: **name**, **email**, **phone**
and **postal address**. The phone number is rendered on the page as a sanitized
`tel:` link.

## Enforcement / market-surveillance body

Shown according to the statement type you chose above — the enforcement or
arbitration body for a public-sector statement, or the market-surveillance
authority for a product/service statement. Fill in the body's details so visitors
know where to escalate an unresolved complaint.

## Last review date and meta description

You can record a machine-readable last-review date (rendered as a `<time>` element)
and set an SEO meta description for the page.

## Save

Click **Save configuration**. The public page at your chosen path now renders the
statement. Because the output is semantic, config-only HTML, you can restyle it by
overriding the `accessibility-statement.html.twig` template in your theme, and you
can translate the content through Drupal's configuration translation.
