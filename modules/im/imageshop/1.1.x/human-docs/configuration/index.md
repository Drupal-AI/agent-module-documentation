# Configuration

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → Media → Imageshop**, or navigate directly to
   `/admin/config/media/imageshop`.

> **Known permission mismatch.** In this release the settings route asks for a
> permission (`administer imageshop`) that the module never defines — the only
> defined admin permission is `administer imageshop configuration`. Because the
> requested permission does not exist, Drupal grants it to nobody, so the page can
> be unreachable as shipped. This is a code-level issue to reconcile (align the
> route's permission with the defined one); it is not something you can fix purely
> from the UI.

## Settings, field by field

- **Token** *(required)* — your Imageshop **permanent token**.
- **Private key** — your Imageshop **private key**. Together with the token this
  authenticates the site to Imageshop; the module exchanges the pair for a
  short-lived temporary token (valid 24 hours) whenever it needs one, refreshing
  it on cron.
- **Hide media browser** — when ticked, hides Drupal's own media library for the
  media types you enable below, so editors use only the Imageshop browser for
  those types.
- **Enabled media types** — the media types that should swap Drupal's core upload
  for the Imageshop browser. Tick the ones your editors should pick from Imageshop.
- **Imageshop browser settings** (a fieldset controlling the iframe):
  - **Interface name** — the Imageshop interface presented in the browser.
  - **Language / culture** — the browser language, either Norwegian (`nb-NO`) or
    US English (`en-US`).
  - **Show size dialog** — whether the size dialog appears in the Imageshop
    browser.
  - **Show crop dialog** — whether the crop dialog appears.
  - **Free crop** — enable free-form cropping in the browser.
  - **Insert immediately** — insert the selected asset straight away rather than
    after an extra confirmation step.

Click **Save configuration** when done.

## Grant editors access

The image chooser at `/imageshop/iframe` is gated by the **access imageshop**
permission. Go to **People → Permissions** (`/admin/people/permissions`), grant
**access imageshop** to your editorial roles, and save. Without it, editors
cannot open the Imageshop browser.

## Protecting the credentials

The **token and private key** are saved in the `imageshop.settings` config
object. Treat these as live secrets:

- **Keep them out of version control.** Do not commit the exported
  `imageshop.settings` configuration with real values in it.
- **Store the values as environment variables** rather than typing them straight
  into a config file you might commit. With DDEV you can save a secret into the
  container's environment without committing it:

  ```bash
  ddev dotenv set .ddev/.env --imageshop-token=<value>
  ddev dotenv set .ddev/.env --imageshop-private-key=<value>
  ddev restart
  ```

  Keep `.ddev/.env` out of version control. You then enter the values on the
  settings form (or reference the environment variables from settings) so the
  real secrets never live in committed code.
- **Rotate credentials** by re-entering a fresh token and private key on this
  form if you suspect they have leaked.

## How the token stays fresh

You do not manage the temporary token yourself. The module caches it for 24 hours
and refreshes it on **cron**, so make sure cron runs regularly on your site. If
editors see a message that the settings seem unconfigured or faulty, re-check the
token and private key and confirm the server can reach Imageshop's web service.
