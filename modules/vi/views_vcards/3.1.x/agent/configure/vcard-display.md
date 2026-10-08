<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a vCard export in Views

There is no module settings form. You configure everything on a View.

## Steps

1. Create/edit a View whose rows are the people to export (e.g. base table *Users*, or a custom
   contact entity).
2. Add a new display of type **vCard** (`views_vcard`). It is a path display — set its **Path**
   (e.g. `staff/download`, or `user/%/vcard.vcf` with one `%` per contextual filter).
3. Under **Fields**, add every field you want on the card (name, emails, photo image field, address
   components, phone, website, …). Only fields present here can be mapped.
4. In the vCard **row** settings (Show → vCard), map each vCard property to one of those fields.

## Row field-mapping keys (`views_vcard_fields`)

Set each to the machine name of a field added under *Fields*. Grouped as
`name_email`, `home`, `work` (schema `views.row.views_vcard_fields`):

- `name_email`: `first`, `middle`, `last`, `full`, `title`, `email`, `email2`, `email3`, `photo`
- `home`: `home_address`, `home_city`, `home_state`, `home_zip`, `home_country`, `home_phone`,
  `home_cellphone`, `home_website`
- `work`: `work_title`, `work_company`, `work_address`, `work_city`, `work_state`, `work_zip`,
  `work_country`, `work_phone`, `work_fax`, `work_website`

`photo` accepts an image field and may be rendered through an image style (row plugin uses
`image\Entity\ImageStyle`). All non-photo values are sanitised in
`views_vcards_preprocess_views_vcards_view_row_vcard()` with `Xss::filter` then
`strip_tags($v, '<a>')` before being written to the card.

## Output behaviour (display plugin)

- `ViewsVcardsDisplayPluginVcard::buildResponse()` executes the View: **exactly 1 row** →
  `text/vcard` single `.vcf` (filename = transliterated `full_name`); **>1 row** →
  `application/zip` streamed response, one `.vcf` per row, de-duplicated filenames
  (`Name_2.vcf`, …). ZIP is built with `ZipStream` (v2/v3 handled by PHP-version branch).
- No pager/AJAX (`usesPager`/`usesAJAX` = FALSE).

## Attach-to (add a download link to another display)

- In the vCard display's **vCard settings → Attach to**, tick another display of the same View
  (that display must accept attachments). The style plugin (`views_vcard_style::attachTo`) injects a
  themed `views_vcards_vcard_icon` (library `views_vcards/vcard_icon`) linking to the vCard path.
- The link forwards the attached display's **exposed-filter input** as query args, so the export
  matches whatever filters the user selected on the list.

## Theming

- Theme hooks: `views_vcards_view_row_vcard` (the card body; variables are the mapping keys above)
  and `views_vcards_vcard_icon` (`url`, `title`). Override the templates to change vCard field
  layout/`VCARD` version.

## Access control (important)

The vCard display uses the **View's own access plugin** (Permission / Role / None) — the module adds
no access check. If the View exposes user emails/phones/addresses, set the display access
appropriately; a "None" access display is world-readable, which is standard Views behaviour, not a
module safeguard.

## Requirements / gotchas

- Requires the `maennchen/zipstream-php` library (install-time `hook_requirements` errors if absent).
- **Turn Twig debug OFF** — runtime `hook_requirements` warns that debug markup corrupts exported
  cards and breaks import into mail clients.
