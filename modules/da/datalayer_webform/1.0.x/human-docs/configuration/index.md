# Configuration

There is no global settings page. You configure Datalayer Webform **per form**, on
its handler. Anyone who can administer webform handlers (a Webform administrator) can
set this up.

## Add the handler to a form

1. Edit the webform you want to instrument.
2. Go to **Settings → Emails / Handlers**.
3. Click **Add handler** and choose **Datalayer Webform**.
4. Fill in the **Datalayer event (YAML)** field (see below) and **Save**.

Because the handler has **unlimited cardinality**, you can add it more than once to
push several different events from the same form.

## Write the event YAML

The single setting is a YAML snippet describing the object pushed to `dataLayer` on
submit. For example:

```yaml
event: generate_lead
form_id: '[webform_submission:webform:id]'
value: '[webform_submission:values:amount]'
lead_email: '[webform_submission:values:email]'
```

**Webform tokens are supported.** When the form is submitted, the module decodes the
YAML and runs it through the token system against the current submission, so
`[webform_submission:values:email]` becomes the value the visitor entered, and
webform/site tokens (id, title, etc.) resolve too. Use the token browser link shown
on the handler form to find the exact token names.

At runtime the resolved object is handed to the page as
`drupalSettings.datalayer_webform.event`, and the module's small JavaScript behavior
calls `dataLayer.push(event)` once per submission form.

## Notes and caveats

- The global `dataLayer` array is provided by the **Datalayer** module — make sure it
  is enabled and configured (e.g. with your Google Tag Manager container) so your
  pushed events are actually picked up.
- The handler is **tested primarily with the modal confirmation** behavior. If your
  form uses a full‑page redirect confirmation instead, the event is pushed as the
  submission form renders — so verify in your browser's data‑layer/debug tools that
  the event fires the way you expect for your confirmation type.
- The event YAML is author‑controlled and only editable by users who can configure
  webform handlers. Its value is emitted as JSON‑encoded data before being pushed, so
  it is not injected raw into the page.
