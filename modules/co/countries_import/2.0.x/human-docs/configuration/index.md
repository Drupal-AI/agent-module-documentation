# Configuration

Configuring Countries is really about telling the import *where* to put the data
and *which fields* hold each value, then running it. Everything happens behind the
**Administer site configuration** permission.

## Before you start

Create (or choose) a taxonomy vocabulary to receive the terms — for example a
"Countries" vocabulary — and add fields to it for:

- **ISO‑2** (alpha‑2 code, e.g. `RO`) — a text field.
- **ISO‑3** (alpha‑3 code, e.g. `ROU`) — a text field.
- **Flag** — an image field (SVG is handled via the SVG Image module).

You can alternatively store the data in a **content type** rather than a
vocabulary; the mapping approach is the same.

## Import countries

1. Go to **Configuration → Content authoring → Countries import**
   (`/admin/config/content/countries-import`).
2. Choose where to store the information — **Taxonomy** or **Content type** — and
   select the target vocabulary (or type).
3. Map each piece of data onto a field:
   - ISO‑2 → your alpha‑2 text field,
   - ISO‑3 → your alpha‑3 text field,
   - flag → your image field.
4. Choose the **flag format**: SVG, PNG 32×16, or PNG 128×64.
5. Optionally enable translation of the **name** and **official name** (uses
   Content Translation).
6. Optionally choose to import **only countries** (leaving regions for later).
7. Save / submit to run the import. The module creates or updates one term (or
   node) per country, sets the mapped ISO and flag fields, and writes the flag
   image files to your site.

## Import geographic regions

1. Switch to the **Geographic Regions** tab
   (`/admin/config/content/countries-import/geographic-regions`).
2. Configure the region mapping in the same way, and run the region import.
3. New in 2.0.x, you can also import the **assignment of countries to regions**, so
   your countries are grouped under their M49 geographic regions.

## Good to know

- The import is **reference‑data seeding** and can be re‑run to refresh the data if
  the underlying catalogue changes.
- There is **no Drush command** — the import runs from the settings form.
- Because the terms are ordinary taxonomy terms, you can translate them afterward
  with Drupal's standard translation workflow, and reference them from address,
  shipping, or entity‑reference fields.
