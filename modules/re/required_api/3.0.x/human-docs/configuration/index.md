# Configuration

There are two things to configure: a **site-wide default strategy** on a small
settings page, and a **per-field strategy** on each field's settings form.

## The site default strategy

1. Go to **Configuration → User interface → Required**
   (`/admin/config/user-interface/required`). This needs the **Administer required
   settings** permission.
2. Choose the **default required strategy**. Every field that hasn't picked its own
   strategy uses this one. The install value is **Core** (`default`), which just
   respects the field's own required flag — so leaving it here keeps normal Drupal
   behaviour.
3. Save.

Set the default to a contributed strategy if you want it to apply everywhere
without touching each field.

## Choosing a strategy per field

Required API rewrites the **field settings** form (for example *Structure → Content
types → Article → Manage fields → (edit a field)*):

1. The core **Required field** checkbox is hidden.
2. If more than one strategy is installed, a **"Choose a required strategy"** radio
   list appears. Pick the strategy for this field.
3. If the chosen strategy has its own options, they appear just below and refresh
   as you switch strategies. Fill them in.
4. Save the field.

> If a field references a strategy whose providing module has since been removed,
> the form shows a **Broken/missing strategy** and asks you to choose another — and
> at runtime a broken strategy fails safe by treating the field as always required.

## How it behaves once set

- **The Required marker still shows.** Any field given a non-`default` strategy is
  forced to "required" when saved, so editors still see the usual required marker.
  The strategy then *relaxes* that at form-build time — deciding live whether the
  field is genuinely required for the entity being edited.
- **Spurious errors are cleaned up.** If a strategy makes a field optional for a
  given submission, Required API removes core's "field is required" error for it,
  so the form saves without a false complaint.
- **The Core strategy is transparent.** A field left on **Core** behaves exactly
  as it always did — its saved required setting is written straight back to the
  field.

## For developers

The strategies you choose from come from plugins. The module ships **Core**
(`default`) and the **Broken** fallback; contributed and custom modules add others
(such as "required for role X"). Writing your own strategy plugin is covered in the
sibling [`agent/`](../agent/start.md) docs.
