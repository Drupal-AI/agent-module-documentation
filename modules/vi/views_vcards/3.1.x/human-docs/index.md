# Views vCards — manual setup guide

**Views vCards** (`views_vcards`) lets you export the results of any View as
downloadable **vCard** (`.vcf`) files — the standard contact-card format that
Outlook, Apple Contacts, and phone address books all understand. Point it at a
View of your site's users (or a custom "person" / "contact" content type), map
your fields onto vCard properties, and visitors get a "save this contact" link or
a whole address book they can import in one click.

It adds three cooperating Views plugins — a **vCard display**, a **vCard style**,
and a **vCard row** — so exporting works just like building any other View. You
add a vCard display, give it a path, add the fields you want on the card, and then
map each vCard property (first/middle/last/full name, job title, up to three
emails, a photo, and full home and work address/phone/website blocks) to one of
those fields. When someone visits the path, they get a single `.vcf` file if the
View returns one person, or a ZIP of many `.vcf` files if it returns several
(streamed efficiently so even large staff directories don't blow up memory).

A handy **Attach to** option adds a downloadable vCard icon onto another display
of the same View — for example a user-list page — and the export automatically
respects whatever exposed filters the visitor has selected on that list. One
thing to keep firmly in mind: the export inherits the **View's own access
settings** and adds no access control of its own, so if your cards expose emails,
phone numbers, or addresses, set the display's access appropriately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   ZipStream library) and enable the module.

## How to use it

There is no settings form — everything is configured on a View:

1. Create or edit a View whose rows are the people to export (base table
   **Users**, or a custom contact entity).
2. Add a new display of type **vCard**. It's a path display, so set its **Path**
   (e.g. `staff/download`, or `user/%/vcard.vcf` using a contextual filter so
   each user gets a personal card URL).
3. Under **Fields**, add every field you want on the card — name, emails, a photo
   image field, address components, phone, website. Only fields you add here can
   be mapped.
4. In the vCard **row** settings (Show → vCards), map each vCard property to one
   of those fields. Properties are grouped into **name/email**, **home**, and
   **work** sets:
   - *name/email:* first, middle, last, full name, title, up to three emails, photo
   - *home:* address, city, state, zip, country, phone, cell phone, website
   - *work:* title, company, address, city, state, zip, country, phone, fax, website
5. Visit the path. One result streams a single `.vcf`; more than one streams a ZIP
   of individually named `.vcf` files.

### Attach a download link to a list

In the vCard display's **vCard settings → Attach to**, tick another display of the
same View (a page that accepts attachments). A vCard download icon is added to
that display, linking to your export and carrying through the list's exposed-filter
selections — so the downloaded cards match whatever the visitor is currently
viewing.

### Access and gotchas

- **Access:** the export uses the View display's own access plugin (Permission /
  Role / None). A "None" display is world-readable — restrict it if the cards
  contain personal data.
- **Turn Twig debugging OFF.** Debug markup corrupts the exported cards and breaks
  import into mail clients; the module warns about this on the status report.

## Where it lives in the admin menu

Views vCards has no admin page of its own. All configuration happens inside the
Views UI at **Structure → Views** on each individual View, as described above.
