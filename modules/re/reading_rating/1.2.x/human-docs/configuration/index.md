# Configuration

Reading Rating is turned on **per field**, from the field's settings on the
entity's **Manage form display**. There is no central settings page — you decide,
field by field, where the readability score should appear.

## Who can configure it

Changing these settings requires the **Manage reading rating** permission. Grant
it at **People → Permissions** to the roles that should be allowed to enable and
adjust Reading Rating on fields.

## Enable Reading Rating on a field

1. Go to the **Manage form display** of the entity whose field you want to rate —
   for example **Structure → Content types → *(type)* → Manage form display**
   (the same *Manage form display* tab exists for block types, paragraph types,
   and so on).
2. Find the long-text field you want to rate and click the **gear icon** at the
   right of its row to open that field's form-display settings.
3. Expand the **Reading Rating** details section and tick the checkbox to
   **enable Reading Rating for this field**.
4. Optionally, enable **grade-level ratings** to show a grade level alongside (or
   instead of) the raw readability score.
5. Click **Update** on the field, then **Save** the form display.

## See it in action

Open the edit page for a piece of that content type. A **Reading Rating** section
now appears below the text field, and the score updates automatically in real time
as the editor types.

## Good practice

- Enable it on the fields that hold real prose (body, summaries, help text), not
  on structured or code-like fields where the formula is meaningless.
- Treat the score as guidance for the writer, not a pass/fail gate — the module is
  deliberately built to *show* the number rather than block submission on it.
- On multilingual content, remember the Flesch–Kincaid calculation assumes
  English; a score on non-English text is not meaningful, so enable it only where
  it makes sense.
