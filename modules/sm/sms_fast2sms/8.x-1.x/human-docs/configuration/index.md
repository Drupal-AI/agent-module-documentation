# Configuration

Fast2sms has no settings page of its own — you configure it by adding a gateway
to the **SMS Framework**, which is where its fields appear.

## Create the gateway

1. Log in as a user who can administer SMS Framework.
2. Go to **Configuration → SMS & messaging → Gateways** (under Admin → Config →
   SMS/Telephony → Gateways).
3. Add a new gateway and choose the **Fast2sms** plugin.

## Fields

The Fast2sms gateway form has three fields, all coming from your Fast2SMS account:

- **API key** — your Fast2SMS API key. It is sent to Fast2SMS in the request's
  `authorization` header. (This value is stored in the gateway configuration, the
  standard SMS Framework behaviour.)
- **Route** — the Fast2SMS route to send on (as defined by your Fast2SMS account).
- **Sender id** — the sender id shown to recipients.

Save the gateway when you've entered these.

## Set it as the default gateway

To route all of the site's outbound SMS through Fast2SMS, set this gateway as the
SMS Framework **default**. You can instead route only specific phone numbers to it
if you prefer — that's handled by SMS Framework, not this module.

## How sending works

When a message is sent, the gateway POSTs a JSON body containing the recipient
numbers, the message, and the route to `https://www.fast2sms.com/dev/bulkV2` over
HTTPS, with your API key in the `authorization` header. The JSON response
(`return`, `request_id`, `status_code`, `message`) is mapped into an SMS Framework
delivery report, so you can see the outcome in the framework's reporting. The
endpoint is fixed and TLS verification is left at Guzzle's secure default.

## Test it

Send a test message to a single recipient (for example from SMS Framework's test
form) to confirm your API key and route are correct before relying on the gateway
in production.
