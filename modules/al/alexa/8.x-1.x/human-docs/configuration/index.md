# Configuration

Alexa needs one thing from you: your Amazon Alexa **Application ID**. The module
uses it to confirm that requests hitting the callback belong to your skill and
not someone else's.

## Open the settings form

1. Log in as a user with the **Administer Alexa configuration** permission.
2. Go to **Configuration → Web services → Alexa**, or navigate directly to
   `/admin/config/services/alexa`.

## Enter the Application ID

Paste the Application ID from your skill in the Amazon Alexa Developer Console
into the field on this form and save. From then on the callback controller checks
each incoming request against this value (in addition to validating the request
signature and Amazon's certificate).

## Point Amazon at the callback

In the Amazon Alexa Developer Console, set your skill's HTTPS endpoint to:

```
https://yoursite.example/alexa/callback
```

Amazon will POST skill requests there. The module validates the signature and
certificate chain, checks the Application ID, caches the downloaded Amazon
certificate for reuse, and then dispatches the `alexaevent.request` event for
handler code to respond to. Invalid requests are logged.

## A note on the dev-mode flag

The module supports a `dev_mode` state flag that skips request validation. This
is intended only for local development and testing — never enable it on a
production site, because it turns off the checks that keep the endpoint genuine.
