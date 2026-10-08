# Configuration

Hubspot Integration's admin screens live together under
**`/admin/config/hubspot_integration`** and are protected by the **Administer
hubspot integration** permission. There are three related forms: **Settings**,
**Mapping**, and **Sort**.

## 1. Settings — connect to HubSpot

Open the Settings form at **`/admin/config/hubspot_integration/admin`**. Here you
enter your **HubSpot API key and portal settings**, which the module uses to call
the HubSpot Contacts API and retrieve field information. This form also holds
operational settings such as the **maximum number of anonymous contacts** the
module will create (used to cap anonymous‑contact creation).

Because the API key authenticates to your CRM, protect it: keep it out of version
control, prefer storing it as a secret (an environment variable referenced
through a Key entity) rather than pasting it somewhere it will be exported, and
serve the site over HTTPS.

## 2. Mapping — HubSpot contact properties → Drupal taxonomy

On the Mapping form you connect **HubSpot contact properties to Drupal taxonomy
terms**. This mapping is what turns a visitor's HubSpot profile into a set of
taxonomy term IDs that represent them — the raw material for personalisation.
Choose which HubSpot properties matter to you and which vocabulary/terms they map
onto.

## 3. Sort — mapping order

The Sort form controls the **order** in which mappings are applied. Use it to
prioritise mappings when more than one could apply to a visitor.

## Putting the term IDs to work

Once mapping is configured, the module exposes the visitor's HubSpot‑derived term
IDs to Views through several plugins:

- a **contextual filter (argument)** to filter a View by the visitor's HubSpot
  term IDs,
- a **default argument** that supplies those term IDs automatically, and
- a **sort** to order results by the HubSpot terms.

You can also embed HubSpot forms and behaviour directly in content using the
HubSpot form field and its formatter/widget, place the HubSpot JavaScript form
block in a region, and set a persona cookie via the module's `/set-persona`
route to personalise sections built with Paragraphs.

## Privacy note

The module reads visitors' HubSpot tracking cookies and looks up their contact
profiles, and it can embed HubSpot forms that collect personal data. Disclose
this tracking and data exchange with HubSpot in your privacy policy, and gate any
tracking/embedding behind consent where the law requires it.

## Save

Save each form after editing. Changes to the API key, mapping, and sort take
effect for subsequent requests.
