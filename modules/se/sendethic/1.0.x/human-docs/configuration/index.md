# Configuration

SendEthic needs your SendEthic API credentials before it can send anything. You
set them once, then attach a handler to each webform you want connected.

## Set your credentials

You have two options:

- **Settings form** — enter your SendEthic API credentials directly on the
  module's configuration form. Only users with the **`administer sendethic
  configuration`** permission can reach it, so keep that permission with trusted
  roles.
- **Key module (recommended)** — instead of storing the credentials in plain
  configuration, hold them in a **Key** entity backed by an environment variable.
  This keeps the API key out of your exported config and out of version control.
  Point the module at the Key rather than pasting the raw value.

Whichever route you choose, treat the API key as a secret: it authenticates all of
your SendEthic traffic, so it should live in an environment variable / Key and
travel only over HTTPS.

## Add the webform handler

Once the credentials are in place, connect a form:

1. Go to **Structure → Webforms** and edit the webform you want to send to
   SendEthic.
2. Open the **Settings → Emails / Handlers** tab.
3. Click **Add handler** and choose the **SendEthic** handler.
4. Fill in the handler's options and save.

From then on, submissions to that webform are delivered to SendEthic through the
API using the credentials you configured.

## A note on data

Submission data sent to SendEthic leaves your site for an external service. Since
this is typically personal/contact data, disclose the transfer in your privacy
policy and handle consent as your jurisdiction requires.
