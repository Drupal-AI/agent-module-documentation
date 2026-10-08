# Configuration

LEADsms needs one essential piece of configuration to work: the **CONNECTsms
activation key** that links your Drupal site to your CONNECTsms account. Until
that is set, the widget cannot relay messages.

## Open the settings form

1. Log in as a user with permission to administer the module.
2. Go to **`/admin/config/leadsms_text/settings`**.

## Enter your CONNECTsms activation key

The form's central field is your **CONNECTsms activation key** — the credential
issued by CONNECTsms for your subscription. Paste it in and save. Once it is
present, the module can authenticate to CONNECTsms and the widget goes live on
your site, collecting each visitor's message content and phone number and sending
them to your account.

## Treat the activation key as a secret

The activation key is what authorises requests against your CONNECTsms account,
so handle it like any other API credential rather than committing it to
configuration in the clear:

- On this project, store the value in an environment variable using DDEV's
  dotenv command — for example
  `ddev dotenv set .ddev/.env --connectsms-key=<value>` — and then
  `ddev restart` so the container picks it up. Never commit `.ddev/.env`.
- Where the module supports it, reference the value through a **Key** entity
  backed by the environment provider rather than pasting the raw key into a
  configuration field that gets exported. This keeps the secret out of your
  exported config and version control.

## What leaves your site (egress)

Be aware that this module sends data outward: when a visitor uses the widget,
their **message content and phone number** are transmitted to the **CONNECTsms
platform**. That is the intended behaviour — it is how the SMS conversation
happens — but it means visitor‑supplied contact data is shared with a third‑party
service. Make sure your site's privacy notice reflects that CONNECTsms receives
this information, and confirm the connection to CONNECTsms is made over HTTPS.

## Save

Click **Save configuration**. Then test the widget end to end: submit a message
from a front‑end page and confirm it arrives in your CONNECTsms account.
