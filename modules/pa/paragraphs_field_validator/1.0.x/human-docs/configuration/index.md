# Configuration

Paragraph Field Validator is configured on its own settings form, where you define
the conditional validation rules that get applied to your Paragraph fields. Nothing
is enforced until you add at least one rule here.

## Open the settings form

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → Content authoring → Paragraphs Field Validator**.

## How a rule works

Each rule expresses a single conditional check on the fields of one Paragraph
bundle: *"When the key field contains the expected text, the target field must match
this pattern."* You can add as many rules as you need, and restrict any rule to
specific nodes so it only fires where it matters.

## The fields on a rule

The exact labels may vary slightly by release, but each rule is built from the same
pieces:

- **Paragraph bundle** — the paragraph type the rule applies to. Only fields from
  this bundle are available for the key and target fields below.
- **Key field (the trigger)** — the field whose value decides whether the rule
  runs. For example a *type* field on the paragraph.
- **Expected value** — the text the key field must contain for the rule to apply.
  If the key field does not contain this value, the rule is skipped for that
  paragraph. For example, `email`.
- **Field to validate (the target)** — the field whose value must satisfy the
  pattern when the trigger condition is met. For example a *value* field.
- **Regex pattern** — the regular expression the target field's value must match.
  For example an email or phone‑number pattern.
- **Error example / message** — the example or message shown to the editor when the
  value does not match, so they know what a valid value looks like.
- **Case‑insensitive matching** — an option to match the pattern regardless of
  letter case.
- **Restrict to specific nodes** — optionally limit the rule so it only applies on
  the nodes you choose, rather than everywhere the paragraph bundle is used.

## Save

Save the form. From that point on, whenever an editor saves content whose paragraph
matches the trigger condition, the target field is checked against the pattern. If
it does not match, the save is blocked and your error example is shown so the editor
can correct the value.

## A worked example

To require a valid email whenever a paragraph's *type* is set to `email`:

1. Choose the paragraph **bundle** that has the *type* and *value* fields.
2. Set the **key field** to *type* and the **expected value** to `email`.
3. Set the **field to validate** to *value* and enter an email **regex pattern**.
4. Add an **error example** such as `name@example.com`, and enable
   **case‑insensitive** matching if you want to accept mixed‑case input.
5. Save. Now editors can only save that paragraph with a properly formatted email
   in the *value* field whenever *type* is `email`.
