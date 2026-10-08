# Configuration

There are two things to configure: **validation on each Telephone field** (opt‑in,
per field) and an optional **site‑wide default** that seeds custom `tel` form
elements.

## Enable validation on a Telephone field

1. Go to the field you want — for example **Structure → Content types → *Article* →
   Manage fields → *your Telephone field*** — and open its settings form.
2. Find the **Telephone validation** section and configure it:

| Control | What it does |
|---|---|
| **Enabled** | Turns validation on for this field. Unticking it removes the format/country settings and stops validation. |
| **Format** | **E164** (international, `+…`) or **National** (local, no `+`). See the notes below. |
| **Country** | Which countries are accepted. For **E164** this is an optional multi‑select allow‑list — leave it empty to accept any country. For **National** you must choose **exactly one** country, which supplies the assumed region. |

3. Save the field.

**How the two formats behave**

- **E164** — the validator reads the country from the leading `+` country code, so
  it works across countries automatically. Use the Country field only if you want
  to *restrict* input to an allow‑list of regions.
- **National** — the number has no `+` prefix, so the validator cannot guess the
  country. You must select one country to tell it which region's rules to apply.

When someone enters an invalid number, they see a violation message like
*"@number is not a valid phone number."*

## Site‑wide defaults

Go to **Configuration → Content authoring → Telephone Validation**
(`/admin/config/content/telephone_validation`). You need the **Administer site
configuration** permission. The form has two settings:

| Setting | Default | What it does |
|---|---|---|
| **Format** | E164 | The default validation format applied to core's `tel` render element. |
| **Valid countries** | *(empty = all)* | The default set of allowed countries for that element. |

These defaults are copied onto core's `tel` form element, so **custom forms** that
use a `tel` field automatically validate against them — no extra code needed — while
individual forms can still override the settings.

The defaults are stored as a config object, so they export and deploy with
`drush config:export`. You can also set them from the command line, for example to
switch the default format to National:

```bash
drush cset telephone_validation.settings format 2
```

(Format values are `0` for E164 and `2` for National, matching the underlying
library.)
