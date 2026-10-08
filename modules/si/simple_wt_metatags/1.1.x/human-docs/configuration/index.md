# Configuration

Simple WT Metatags works by reading fields you already have on your content and
taxonomy, so the configuration is essentially a mapping exercise: you tell it which
field machine names hold the description and image, and set the fallbacks used when a
page has no such field.

## Open the settings form

1. Log in as a user with the module's configure permission.
2. Go to **Configuration → Search and metadata → Simple WT Metatags Settings**, or
   navigate directly to `/admin/config/search/simple-wt-metatags`.

This form lets you configure meta tags for your **Node** and **Taxonomy term**
pages, as well as for global (non-entity) pages.

## Map the description field

Enter the **machine name** of the **Text (plain, long)** field that should supply
both the HTML meta description and the Open Graph description (`og:description`) — for
example `field_summary`. The same value is used for both tags, and it is truncated to
200 characters using Drupal's word-safe truncation, so it ends cleanly with an
ellipsis rather than chopping a word in half. The field also supports Drupal tokens,
so you can map dynamic content into it.

The **Open Graph title** (`og:title`) is not a field you map — it is taken
automatically from the page title (the node title or taxonomy term name).

## Map the Open Graph image field

Enter the machine name of the **Media (image)** reference field that holds the
primary image — for example `field_featured_image`. From it the module outputs the
full Open Graph image set: `og:image`, `og:image:secure_url`, `og:image:width`,
`og:image:height` and `og:image:alt`. Remember the field must be limited to a single
value.

## Set the global fallbacks

For pages that lack a mapped field — or non-entity pages such as Views, the front
page and custom routes — define a site-wide **default meta description** and a
**default Open Graph image URL**. These are used whenever a specific node or term has
no data of its own, so your listing pages and homepage still emit sensible tags.

## Canonical URLs

You do not configure the canonical tag — the module injects a smart canonical URL on
all front-end routes automatically to prevent duplicate-content warnings, and it
includes a safety check that yields quietly if Drupal core has already placed one.

## Save

Save the form, then view a node's page source and confirm the meta description and
Open Graph tags reflect your mapped fields, falling back to your global defaults
where a field is empty.
