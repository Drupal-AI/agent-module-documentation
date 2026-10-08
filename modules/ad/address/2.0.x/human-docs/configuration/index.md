# Configuration

There is no single "Address settings" screen to fill in. You configure Address in two
places: **on each Address field** you add through the Field UI (this is where nearly
all the useful options live), and — only if you need to — on the global **Address
formats** listing that manages per‑country layouts.

## Add an Address field

1. Log in as a user who can administer fields (an administrator by default).
2. Go to **Structure → (your content type) → Manage fields** and click **Add field**.
   (This works on any fieldable entity — content types, users, taxonomy terms, Commerce
   profiles, and so on.)
3. Choose one of the field types this module provides:
   - **Address** — the full compound postal address (all the properties below). This is
     the one you want in almost every case.
   - **Country** (`address_country`) — stores just a country code, when all you need is a
     country selector.
   - **Zone** (`address_zone`) — defines a geographic zone made of territory rules, used
     for things like shipping/tax regions.
4. Give the field a label, save, and continue to its settings.

An Address field stores a full set of properties — `country_code`,
`administrative_area` (state/province/county), `locality` (city), `dependent_locality`,
`postal_code`, `sorting_code`, `address_line1`/`line2`/`line3`, `organization`,
`given_name`, `additional_name`, `family_name`, and `langcode`. Which of these actually
appear, and what they're called, is decided per country by the address dataset.

## Field settings

On the field's settings tab you can shape how the address behaves:

- **Available countries** — restrict the country dropdown to a subset (for example, EU
  countries only). Leave it empty to allow every country.
- **Field overrides** — for each address property you can override the country's default
  and set it to **Hidden**, **Optional**, or **Required**. Use this to, say, always
  require an organization name, or hide the name fields on a venue address.
- **Default language / language override** — pin the address to a specific language so
  its format and labels don't shift when the site's UI language changes.

## Form widget settings (Manage form display)

On the bundle's **Manage form display** tab you can adjust how the field is presented on
the edit form:

- The default **Address** widget lets you choose a **wrapper type** — render the address
  fields inside a **details** element (collapsible) or a plain **fieldset**.
- The **Zone** widget (for `address_zone` fields) offers a **show label field** toggle.

As the editor picks a country, the widget dynamically re‑renders to show that country's
correct fields, labels, and order — no configuration needed on your part.

## Display / formatter settings (Manage display)

On **Manage display** you choose how a saved address is rendered:

- **Default** (`address_default`) — HTML formatted according to the country's own
  conventions.
- **Plain** (`address_plain`) — a plain, template‑overridable rendering, handy for print
  or postal labels.
- For the country and zone field types, matching **Country** and **Zone** formatters are
  available.

## Address formats (the global page — usually leave it alone)

The module's **Configure** link points to **Configuration → Regional and language →
Address formats** (`/admin/config/regional/address-formats`, route
`entity.address_format.collection`). This lists the address *format* for each country —
the field layout, required properties, and subdivision rules that drive everything
above. Drupal ships correct formats for every country in the dataset, so most sites never
need to open this page. It exists for the rare case where you want to review or override a
country's layout. Everyday configuration happens on the field, as described above.

## Save

Save the field settings (and the form‑display / display settings) as you go. Then edit a
piece of content, pick a country, and confirm the address fields, labels, and validation
behave the way that country expects.
