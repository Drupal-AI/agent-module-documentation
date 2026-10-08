Webform MyEmma adds a Webform handler that pushes new submissions (email address plus mapped fields) into a MyEmma (Emma) email-marketing group.

---

The module registers a single Webform handler plugin (`myemma`) that, on the `postSave` of a **new** webform submission, imports the submitter's email address and any mapped element values into one or more MyEmma groups through the `judicialcouncil/emma` PHP client (`JudicialCouncil\Emma\JccClient::import_single_member()`). Site-wide MyEmma credentials are managed on a settings page (`/admin/config/services/webform_myemma`, permission **administer webform myemma**): a required default account (Account ID, public key, private key) plus any number of additional named accounts stored in the `webform_myemma.settings` config object. Each handler instance selects one configured account, a target Group ID (numeric; comma-separated string or token for multiple groups), the webform email element, and a `webform_mapping` of webform elements to MyEmma "field shortcuts". Handler configuration values are token-replaced per submission before the API call. Requires Webform `^6.2 || ^6.3`, Drupal `^10.3 || ^11.0`, and Composer installation of the Emma library.

---

- Automatically add webform subscribers to a MyEmma mailing group when a form is submitted.
- Wire a newsletter signup webform to a specific MyEmma audience group by numeric Group ID.
- Push one submission to multiple MyEmma groups at once using a comma-separated Group ID string.
- Route submissions from different webforms to different MyEmma accounts (default or named additional accounts).
- Map webform elements (name, company, interests, etc.) to MyEmma member field shortcuts.
- Capture leads from a contact form into MyEmma for follow-up campaigns.
- Grow an email list from event-registration webforms.
- Segment subscribers with a distinct MyEmma group per campaign form.
- Maintain several MyEmma accounts (e.g. per brand or department) and pick one per handler instance.
- Centralize MyEmma credentials for all site forms on a single admin settings page.
- Use Webform tokens in the handler configuration to derive the Group ID or field values dynamically per submission.
- Add opt-in checkbox form submissions to a marketing group.
- Prefill mapped MyEmma attributes for later message personalization.
- Only import on the first save so re-saved/edited submissions do not create duplicate MyEmma imports.
- Restrict who can manage MyEmma credentials with the dedicated **administer webform myemma** permission.
- Log integration failures to the `webform_myemma` logger channel for debugging failed imports.
- Attach multiple MyEmma handlers to one webform (cardinality is unlimited) to feed several accounts or groups.
- Collect the email field from either an `email` or `webform_email_confirm` element as the subscriber address.
- Add a "subscribe to our list" option to any existing webform without custom code.
- Feed survey or data-collection webforms into MyEmma for audience building.
