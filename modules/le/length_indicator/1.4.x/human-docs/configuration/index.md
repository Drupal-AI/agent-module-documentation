# Configuration

Length Indicator has no central settings page. You configure it per field, per form
mode, on the **Manage form display** page — the same place you choose each field's
edit widget.

## Turn the indicator on for a field

1. Log in as an administrator and go to the entity's **Manage form display** page —
   for example **Structure → Content types → Article → Manage form display**
   (`/admin/structure/types/manage/article/form-display`).
2. Find the field you want to guide. It must use a **supported widget**:
   **Textfield** (`string_textfield`) or **Text area (multiple rows)**
   (`string_textarea`). If the field uses any other widget, no length option
   appears.
3. Click the field's **gear/cog** icon to open its widget settings.
4. Tick the **Length indicator** checkbox. Three numeric options appear.
5. Set the three numbers (below), click **Update**, then **Save**.

Once saved, the field's summary line reads "Length indicator: On", and the colored
bar shows up under that field on the content edit form.

## The three length settings

The bar is divided into five colored segments — bad, ok, good, ok, bad — and these
three numbers define where the boundaries fall. All are measured in **characters**.

- **Optimum minimum** (`optimin`) — the start of the "good" (green) range. Content
  shorter than this reads as too short. Minimum allowed value is 1; the default is
  10. For an SEO page title you might set this to around 50.
- **Optimum maximum** (`optimax`) — the end of the "good" range. Content longer than
  this starts drifting out of the ideal zone. Minimum allowed value is 5; the
  default is 15. It **must be greater than** the optimum minimum. For an SEO title
  you might set this to around 60.
- **Tolerance** — how far the amber "ok" band extends past the good range on each
  side before turning red ("bad"). Minimum allowed value is 0; the default is 5. It
  **must be smaller than** the optimum minimum. A wider tolerance gives looser
  guidance; a narrow one makes the target stricter.

A typical SEO-title setup, then, is optimum minimum 50, optimum maximum 60,
tolerance 10 — green between 50 and 60 characters, amber a little either side, red
beyond.

## Validation rules

The form enforces two constraints; if you break them you'll see an error and can't
save until you fix it:

- **"Optimum maximum has to be greater than the optimum minimum"** — raise the
  optimum maximum (or lower the minimum).
- **"Tolerance has to be smaller than the optimum minimum"** — lower the tolerance.

## Where the settings are stored

The choices are saved as a third-party setting on the field within the form-display
configuration entity, so they export cleanly with your configuration:

```
core.entity_form_display.<entity>.<bundle>.<form_mode>
  content.<field>.third_party_settings.length_indicator:
    indicator: true
    indicator_opt:
      optimin: 50
      optimax: 60
      tolerance: 10
```

Because it lives in the form-display config, you can enable the indicator on one
form mode (say the default edit form) while leaving another form mode without it.
