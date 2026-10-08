# Configuration

Commerce Product Tax has no settings page. You configure it by adding a **Tax
rate** field to a product variation type and choosing which tax type and zones it
uses.

## Prerequisite: a Local tax type

The field's rates come from a Commerce **Local tax type** — for example European
Union VAT, or a custom local tax type. If you don't have one yet, create it under
**Commerce → Configuration → Tax → Tax types**. Only local tax types appear in the
field's settings.

## Add the Tax rate field

1. Go to **Commerce → Configuration → Product variation types**, choose the type
   you want (for example the default variation type), and open its **Manage
   fields**.
2. Click **Add field** and choose **Tax rate**. Give it a label (such as "Tax
   rate") and save.
3. On the field settings screen, choose:
   - **Tax type** — the Local tax type whose rates this field offers (for example
     your EU VAT tax type).
   - **Allowed zones** — which of that tax type's zones an editor may pick a rate
     from. Select just the zones relevant to this variation type.
   Save.
4. On the type's **Manage form display**, the field uses the **Default** widget — a
   dropdown that groups options by zone and lists each rate (for example *Standard
   (20%)*), plus a **No tax** option.

## Setting the rate on a product

When you create or edit a product variation of that type, the Tax rate field shows
the dropdown of rates for the allowed zones. Pick the rate that applies to that
product, or choose **No tax** for an exempt/zero-rated item. Behind the scenes the
choice is stored as a compact `zone|rate` value on the variation, but as an editor
you just pick from the list.

## Showing the rate on the storefront

Two display formatters are available on the field's **Manage display**:

- **String** (the default) — renders the stored rate value.
- **Tax rate percentage** — renders the rate's percentage, handy for showing
  something like "20%" on the product page.

## What happens at checkout

When an order is calculated, the module's tax-rate resolver runs **before**
Commerce's default resolver. For each order item it looks at the purchased
variation's Tax rate field, and if the field belongs to the tax type currently
being resolved and matches the current zone, it applies the editor-chosen rate (or
"no tax"). If nothing matches, Commerce falls back to its normal automatic
resolution. In other words: a rate you pick on the variation wins, and anything you
leave unset behaves exactly as Commerce would on its own. The mechanism is
described in detail in the [agent resolver doc](../agent/api/resolver.md).
