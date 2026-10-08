# Configuration

Configuring the Interact client means connecting Drupal to your Adaptive Interact
account so the platform's client can load and run on your site.

## Get your Adaptive Interact connection details

From your Adaptive Interact account, obtain the connection details the client
needs — typically an account/site identifier and any API credentials.

## Store credentials as secrets

Any API credentials are secrets and must be environment-backed rather than
committed to version control or exported configuration. With DDEV you can set an
environment variable like this:

```bash
ddev dotenv set .ddev/.env --adaptive-interact-key=<your-key>
ddev restart
```

That exposes the value as `ADAPTIVE_INTERACT_KEY` inside the container (keep
`.ddev/.env` out of version control). Where supported, wire the value through a
**Key** entity (the `key` module) with its environment provider so nothing
sensitive lands in configuration; otherwise read it in `settings.php` with
`getenv()`.

## Connect the module

Enter (or reference) the connection details in the module's settings so it can
load the Adaptive Interact client and connect to your account. Once connected,
the platform's personalization and engagement features run on the site's front
end.

## Privacy checklist

- The client may send visitor and interaction data to Adaptive Interact. Make
  sure you have consent to do so and that your privacy notice discloses the data
  sharing.
- Because a third-party script is loaded, consider gating it behind your
  consent-management setup where cookie/tracking consent is required.
