# Configuration

Using Block Attributes is a two‑part job: first you define, site‑wide, **which**
attributes editors may set, then you fill in the **values** on each block.

## 1. Define the global attribute list

1. Log in as a user with the **Access administration pages** permission.
2. Go to **Structure → Block layout → Attributes**, or navigate directly to
   `/admin/structure/block/attributes`.

This form edits the whole attribute list as a single block of **YAML** in a
textarea. Each entry is keyed by the attribute's machine name — which is exactly
the HTML attribute that will be rendered (`class`, `id`, `data-track`, `role`,
and so on) — and can carry a few optional keys:

```yaml
attributes:
  class:
    label: 'CSS class'         # optional; shown as the field label on the block form
    description: 'Space-separated classes'   # optional; help text under the field
  data-track:
    label: 'Tracking id'
    options:                   # optional; presence turns the field into a dropdown
      promo: Promo
      hero: Hero
```

- **`label`** — the human‑friendly name shown for that attribute's field on the
  block form. If you omit it, the module falls back to a capitalised version of
  the machine name.
- **`description`** — optional help text displayed beneath the field, handy for
  telling editors what to enter.
- **`options`** — optional. If you provide a list of `value: Label` pairs, the
  per‑block input for this attribute becomes a **select dropdown** limited to
  those choices instead of a free text field. Leave it out and editors get a
  plain text field.

The module ships with just `class` defined. Add as many attributes as you like by
extending the YAML.

**One name is rejected:** to block a common cross‑site‑scripting vector, the form
refuses any attribute name that is a JavaScript event handler such as `onclick`
or `onmouseover`. Because attribute *values* render into your site's markup, treat
this settings page as a trusted, admin‑only area and only grant *Access
administration pages* and *Administer blocks* to roles you trust.

Click **Save configuration** when you are done.

## 2. Set values on a block

Once an attribute is defined it appears automatically on every block. To set a
value:

1. Go to **Structure → Block layout** and click **Configure** on the block you
   want (this needs the core **Administer blocks** permission).
2. Open the **Attributes** section on the block's configuration form. You'll see
   one input per defined attribute — a text field, or a dropdown for any
   attribute you gave `options`.
3. Enter your value and **Save block**.

Values are stored with that individual block, so each block can have its own
attributes. At render time the module merges them onto the block's wrapper
element. A space‑separated value is split into multiple values — so typing
`promo featured` into the `class` field adds both classes to the block.

## A note on rendering and safety

Attribute names and values are escaped by Drupal's standard attribute renderer
before they reach the page. Keep the two permissions above in trusted hands, since
anyone who can define an attribute and attach it to a block is writing markup that
every visitor receives.
