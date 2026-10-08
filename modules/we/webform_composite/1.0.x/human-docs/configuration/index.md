# Configuration

You manage reusable composites from a single admin list. Everything here requires
the core **Administer webform** permission.

## Open the Composites list

Go to **Structure → Webforms → Configuration → Composites**, or navigate directly
to `/admin/structure/webform/config/composite`. The list shows each composite's
**Label**, **Machine name**, and **Description**, with edit, source, and delete
operations.

## Create a composite

1. Click **Add composite**.
2. Fill in:
   - **Label** (required) — a human‑readable name, e.g. *Customer contact*.
   - **Machine name** — a stable identifier used in configuration and export.
   - **Description** — an administrative description (rich text).
   - **Elements** — this is the important part: a visual builder (Webform's
     composite element builder) where you add and arrange the sub‑fields that make
     up the composite, such as first name, last name, email, and phone. You can
     include select/options sub‑fields; the form requires options on any sub‑field
     that needs them and rejects duplicate sub‑element keys.
3. Save. The composite is now available as a placeable element.

## Edit the raw YAML (Source form)

Each composite also has a **Source** operation that opens the element definition as
raw YAML in a CodeMirror editor. This is handy for bulk or precise edits. Note that
the Source form saves the YAML as‑is without validation, so the visual builder is
the safer choice for everyday changes.

Two behaviours worth knowing: saving a composite immediately clears Webform's
element definition cache, so the new or updated element shows up right away; and
any `#states` data on sub‑elements is stripped when the definition is read back,
because it causes unexpected behavior inside a composite.

## Place a composite on a form

There is no separate step to "register" the element. Once saved, the composite
appears in the Webform element browser under the composite elements category. Edit
any webform, add an element, and pick your composite. Enable **multiple values** on
it to collect a repeating list of entries (for example several emergency contacts).

## Theming

Each composite gets a template suggestion `webform_composite__{machine_name}`, so
you can theme a specific composite on its own. Sub‑elements can be laid out in
flexbox columns via the `#flexbox` property.

## Export and deployment

Because composites are configuration entities, they export with your site's
configuration and can be deployed across environments like any other config — no
code required.
