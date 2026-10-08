# Configuration

Setting up Revive Adserver has two parts: first you tell Drupal how to reach your
Revive instance (and optionally sync its zones), then you place ads on your site
using a block or a field.

## 1. Connect to your Revive instance

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Revive Adserver**
   (`/admin/structure/services/revive-adserver`).
3. Enter the details of your Revive Adserver instance — its server URL and, if you
   want Drupal to pull the zone list over the API, the API credentials it needs to
   authenticate.
4. Save the form.

### Optional: sync the ad zones

On the settings form you can trigger a **zone sync** over the Revive API. This
fetches the ad zones defined in Revive so that, when you place a block or
configure a field, you can pick a zone from a list instead of typing a numeric
zone ID by hand. Re-run the sync whenever you add or rename zones in Revive.

> **Keep API credentials out of code and out of Git.** The credentials Drupal uses
> to talk to the Revive API are secrets. Store the value in an environment variable
> rather than committing it. With DDEV, save it with the built-in dotenv helper —
> `ddev dotenv set .ddev/.env --revive-api-key=<value>` (keep `.ddev/.env` out of
> version control) and `ddev restart` — then, where the module accepts a
> [Key](https://www.drupal.org/project/key) entity, reference the value through a
> Key using the environment provider rather than pasting the secret into the form.
> Also make sure your environment is allowed to make **outbound (egress)** requests
> to the Revive host, or the zone sync will fail.

## 2. Place ads on your site

You have two ways to render a Revive zone, and you can mix them freely.

### As a block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the ad and choose the Revive
   Adserver block.
3. In the block's configuration, pick the **zone** to render and the **delivery
   method** — asynchronous JavaScript, iFrame, or JavaScript.
4. Save.

### As a field

1. On the content type (or other fieldable entity) where you want ads, go to
   **Manage fields** and add a Revive Adserver field.
2. Under **Manage display**, choose the **delivery method** for how that field
   renders its ad.
3. If you want content editors to choose the delivery method themselves on each
   entity, enable that option in the field's configuration — and, in **Manage
   fields**, you can limit which delivery methods are offered to them.

## Delivery methods at a glance

- **Asynchronous JavaScript** — loads the ad without blocking page rendering;
  usually the best default for performance.
- **iFrame** — renders the ad inside an isolated frame.
- **JavaScript** — the classic synchronous invocation.

## A note on consent

Whichever method you choose, the ad tag is loaded from your Revive instance and
may set cookies or track visitors. Where consent is legally required, gate the ad
scripts behind your cookie/consent solution so they only load once the visitor has
agreed.
