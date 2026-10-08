# Configuration

Webform MailChimp has no settings page of its own — you configure it by adding
the **MailChimp handler** to each webform that should feed Mailchimp. Make sure
the separate **Mailchimp** module already has your API key and audience (see
[Installation](../installation/index.md)) before you start.

## Add the MailChimp handler to a webform

1. Go to **Structure → Webforms** and edit the webform you want (for example a
   newsletter signup).
2. Open **Settings → Handlers**.
3. Click **Add handler**, choose **MailChimp**, and click **Add handler**.

## Handler settings

On the handler form you'll set:

- **List (audience)** — the Mailchimp audience to subscribe people to. The list of
  options comes from the Mailchimp module; if it's empty, your API key or audience
  isn't set up there yet.
- **Email** — which webform element supplies the subscriber's email address (for
  example your form's Email field).
- **Double opt‑in** — on by default. When on, Mailchimp sends a confirmation email
  and the person isn't subscribed until they confirm. Turn it off only if you
  understand the consent implications.
- **Merge fields (mergevars)** — map extra webform values to Mailchimp merge
  fields, so first name, last name, and similar data flow through. Mapping works by
  matching your webform element keys to Mailchimp's merge‑field "Field tags"
  (case‑insensitive); the field accepts a small YAML map such as
  `FNAME: '[webform_submission:values:first_name]'`.
- **Interest groups** — add the subscriber to specific Mailchimp interest groups,
  grouped by category. Handy for letting people pick topics on the form and
  segmenting them in Mailchimp.
- **Control field** — an optional webform element (typically a consent checkbox)
  that gates whether a submission subscribes at all. Only submissions where this
  field is set/true are sent to Mailchimp — a clean way to pair a "subscribe me"
  checkbox on a contact form with the subscription.

Save the handler.

## Subscribing to more than one audience

The MailChimp handler can be added multiple times to the same webform. Add a
second MailChimp handler with a different **List** to subscribe submitters to more
than one audience from a single form.

## Test it

Submit the webform with a test email address, then check the target audience in
Mailchimp. With double opt‑in on, look for the confirmation email; with it off,
the subscriber should appear directly. If nobody is subscribed, re‑check that the
Mailchimp module's API key and audience are configured and that the **Email**
element is mapped.

## Customising merge vars in code

Developers can adjust the merge fields just before they're sent to Mailchimp by
implementing `hook_webform_mailchimp_lists_mergevars_alter()` — see the
[`agent/hooks/mergevars.md`](../../agent/hooks/mergevars.md) reference. This is
the module's single code extension point.
