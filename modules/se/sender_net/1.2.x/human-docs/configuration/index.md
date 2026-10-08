# Configuration

Sender.net Integration needs your Sender.net API credentials before it can do
anything. Configuration happens on one settings form, after which you choose a
subscriber group and place the signup block.

## Open the settings form

1. Log in as a user who can administer the module's configuration.
2. Go to **Configuration → System → sender.net**.

## Settings

- **API access token** — paste the token you generated in your Sender.net account.
  This authenticates every call the module makes to Sender.net. Store this token
  as a secret (an environment variable or a Key entity) rather than committing it,
  and make sure the connection uses HTTPS — the token and the subscriber data it
  carries should never travel or be stored in the clear.
- **Base URL** — set the API base URL from the Sender.net API documentation, so
  the module knows which endpoint to call.
- **Group selection** — once the token and base URL are valid, choose from the
  available Sender.net groups. New subscribers added through Drupal will be placed
  into the group(s) you select, which is how you organise and categorise them.

Click **Save configuration** to store the settings.

## Place the subscription block

The signup form is delivered as a block. Go to **Structure → Block Layout**, find
the **Sender.net Subscription Block**, and place it in the region where you want
visitors to be able to subscribe.

## A note on data and privacy

When a visitor subscribes, their email/contact details are sent to the Sender.net
service. That is an external transfer of personal data, so disclose it in your
privacy policy and handle consent as your jurisdiction requires.
