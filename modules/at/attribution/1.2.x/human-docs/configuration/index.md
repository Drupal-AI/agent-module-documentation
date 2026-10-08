# Configuration

Setting up Attribution has three parts: curating the **license list**, adding an
**attribution field** to your content, and (optionally) placing the **site-wide
blocks**.

## Manage the license list

1. Log in as a user with the **administer attribution_license** permission.
2. Go to **Structure → Attribution licenses**
   (`/admin/structure/attribution-license`).

Here you see the installed licenses (stored as configuration entities, so they're
exportable and deployable). The collection page offers two ways to add more:

- **Add license** — imports one of the 400+ licenses from the bundled SPDX list.
  Pick the SPDX identifier (for example `CC-BY-SA-4.0`) and the module fills in the
  name and details. Use this for any standard, well-known license.
- **Add custom license** — creates a blank license entity you fill in yourself
  (id, name, link, OSI-certified and deprecated flags). Use this for a license not
  in the SPDX list, such as a bespoke organizational one.

Each license records its SPDX identifier, human-readable name, an OSI-certified
flag, a deprecated flag, and a link. Trim the list to the licenses your editors
should actually pick from.

## Add an attribution field

1. Go to **Structure → *(content type or media type)* → Manage fields → Add
   field** and choose **Attribution**.
2. On the field's **Manage form display**, choose a widget depending on how much
   editors should enter:
   - **License** — license only.
   - **Author & License** — author name/link plus license.
   - **Source & License** — source name/link plus license.
   - **Source, Author & License** *(default)* — the full set.
   The AI-provenance inputs (AI tool, prompt, prompt-editor) appear automatically
   when the editor sets the creation type to *AI-generated* or *AI-modified*.
   A per-field setting lets you **restrict which licenses** that field offers, so
   editors pick from a controlled subset.
3. On **Manage display**, choose a formatter:
   - **Default** — configurable; can show the field label as a collapsible
     `<details>` summary.
   - **Plain text** / **Plain text (one line)** — simple text output.
   - **HTML** — HTML output.
   - **Creative Commons**, **Creative Commons (icons)**, **Creative Commons
     (refined)** — preformatted CC output with license badges/glyphs.
   The formatters add license-aware CSS classes (OSI/deprecated state, per-license,
   per-creation-type) so you can style them, and can render CC and AI icons.

## Place the site-wide blocks

At **Structure → Block layout**, place either or both:

- **Attribution** block — a site-wide license notice, typically in the footer or a
  sidebar.
- **Copyright** block — a copyright line such as "© 2026 My Site. All rights
  reserved."

Both blocks take a configurable **disclaimer** that supports core **Token**
replacement — for example `[current-date:html_year]` for the current year and
`[site:name]` for the site name — plus `@name` / `@link` placeholders for the
chosen license, so the notice stays current automatically.
