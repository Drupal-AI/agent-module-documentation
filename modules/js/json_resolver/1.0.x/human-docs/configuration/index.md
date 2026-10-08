# Configuration

Configuration has two parts: the **token map** (how placeholders map to your data)
and the **templates** (the JSON shapes you want to produce).

## Open the settings form

1. Log in as a user with the **Administer JSON Resolver** permission.
2. Go to **Configuration → System → JSON Resolver Settings**, or navigate directly
   to `/admin/config/system/json-resolver`.

## Token map configuration

The token map is a JSON object that connects the tokens used in your templates to
the actual field names in your submission data. Keys are the token names (used in
templates as `{{tokenName}}`), and values are the paths to that data in the
submission array. Dot notation reaches into nested data.

Example:

```json
{
    "amount": "donation_amount",
    "email": "donor_email",
    "firstName": "donor.first_name",
    "card": "payment.credit_card.number"
}
```

Here `{{amount}}` will be filled from the submission's `donation_amount` field,
and `{{card}}` from the nested `payment.credit_card.number` value.

## Template management

In the **Templates** section you can add, edit, and delete JSON payload templates.

**To add a template:**

1. Enter a unique **machine name** (lowercase letters and underscores only).
2. Provide the **JSON template** with token placeholders, for example:

   ```json
   {
       "transaction": {
           "amount": "{{amount}}",
           "currency": "{{currency}}"
       },
       "donor": {
           "email": "{{email}}",
           "name": "{{firstName}} {{lastName}}"
       }
   }
   ```

3. Click **Add template**.

**To edit a template:** modify the JSON in the **Existing templates** section and
click **Save configuration**.

**To delete a template:** click the **Delete** button next to it and confirm.

## Using a template from code

Once a template and token map are in place, a developer resolves the template by
injecting the `json_resolver.resolver` service and calling
`resolve('YOUR_TEMPLATE_MACHINE_NAME', $submission_data)`. The returned structure
is your template with each `{{token}}` replaced by the matching value from the
submission data.

## Save

Click **Save configuration** to store the token map and any template edits.
