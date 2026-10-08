# Manage custom sitemap links

Listing at `/admin/config/search/xmlsitemap/custom` (route `xmlsitemap_custom.list`).
Permission: `administer xmlsitemap` (from the parent module).

Routes / forms:
- `xmlsitemap_custom.add` — `/admin/config/search/xmlsitemap/custom/add` — add a link
  (location/path, priority, change frequency, language).
- `xmlsitemap_custom.edit` — `/…/custom/edit/{link}` — edit an existing custom link.
- `xmlsitemap_custom.delete` — `/…/custom/delete/{link}` — remove it.

Custom links are written into the shared xmlsitemap link table (type `custom`) and picked up
on the next generation/rebuild like any other link.
