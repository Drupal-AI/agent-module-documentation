# Configuration

SwissPass has no site‑wide settings form. You configure it per form by adding the
**SwissPass Number** element to a Webform, where it behaves like any other Webform
element.

## Add the SwissPass Number element

1. Log in as a user who can administer Webforms (an administrator by default).
2. Go to **Structure → Webforms** and create or edit the form you want to collect a
   SwissPass number on.
3. Click **Add element**.
4. Select **SwissPass Number** from the element type list.
5. Configure the element as needed — give it a title, mark it required if
   appropriate, add help text, and set the usual Webform element options — then
   save.

Once added, the element automatically formats what the user types as
`XXX-XXX-XXX-X` and validates the format both in the browser (as they type) and on
the server (when the form is submitted), so only correctly formatted numbers get
through.

## Handling the collected data (PII)

A SwissPass number is a **personal identifier**. Treat it as personal data:

- Only collect it on forms where you genuinely need it.
- Store and transmit it securely.
- Handle it in line with your site's privacy policy and applicable data‑protection
  rules.

Remember this element only *collects and validates* the number — it does not
authenticate anyone or control access to anything.
