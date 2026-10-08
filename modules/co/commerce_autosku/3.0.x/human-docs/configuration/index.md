# Configuration

Commerce AutoSKU has no site-wide settings page. Instead, you configure SKU
generation **separately for each product variation type**, on an "Automatic SKU"
form. Nothing changes until you switch a variation type into one of the
automatic modes.

## Open the Automatic SKU form

1. Log in as a user with the **Administer … SKU** permission for the relevant
   entity type (for example, *Administer commerce_product_variation_type SKU*).
   This permission is marked as security-sensitive, so grant it only to trusted
   roles.
2. Go to **Commerce → Configuration → Product variation types**
   (`/admin/commerce/config/product-variation-types`).
3. Edit the variation type you want to automate, then open its **Automatic SKU**
   tab (a local task on the edit screen).

## The fields

- **Mode** — choose how automation behaves for this variation type:
  - **Disabled** — no automatic SKU; editors enter it themselves.
  - **Enabled** — always generate the SKU, and **hide the SKU field** from the
    add/edit form entirely. (Internally the field is seeded with a `%AutoSku%`
    placeholder that triggers regeneration.)
  - **Optional** — keep the SKU field visible, but generate a value only when
    the editor leaves it empty.
- **Generator plugin** — which SKU generator to use. The shipped choice is
  **Token**, which builds the SKU from a token pattern. (Changing this refreshes
  the form to show the selected generator's own settings.)
- **Generator configuration** — the settings for the chosen generator. For the
  Token generator this is a **pattern** textarea, for example:

  ```
  [commerce_product_variation:product_id]-[commerce_product_variation:variation_id]
  ```

  A **Browse available tokens** link sits beneath the field (offering user,
  site, and product-variation tokens). The pattern must contain at least one
  real token, or the form reports an error on save.

Save the form to store the settings on the variation type. From then on, SKUs
are generated whenever a variation of that type is created or updated.

## What happens when a variation is saved

1. The generator resolves the pattern for the variation.
2. If the result is empty, the module falls back to a SKU built from the bundle
   label (plus the entity ID once the variation has been saved).
3. The candidate SKU is cleaned (HTML and control characters stripped) and made
   unique: if a variation with that SKU already exists, `_0`, `_1`, … is
   appended until it is unique. The final value is truncated to 255 characters.

Because the SKU is computed on save, re-saving existing (or imported) variations
regenerates their SKUs — handy for standardising a legacy catalog.

## Extending with a custom generator

Developers can add their own SKU generator (sequential, hashed, prefixed, etc.)
by writing a `commerce_autosku_generator` plugin — see the agent docs at
[`agent/plugins/generator.md`](../agent/plugins/generator.md). Once the plugin is
in place and caches are cleared, it appears in the **Generator plugin** list on
this form.
