# Configuration

Setup happens in two parts: fill in the **Review Settings** form, then place the
**Google reviews** block. Remember to clear the cache between changes.

## Get a Google Places API key and Place IDs

1. In the [Google Cloud console](https://console.cloud.google.com/), enable the
   **Places API** and create an **API key**. Restrict it (by API and by HTTP
   referrer where possible) — it is a Google-billed credential, so guard it against
   abuse.
2. Find the **Place ID** of each business location whose reviews you want to show.

## Store the key securely

The API key is a secret. Prefer keeping it in an environment variable over pasting
it somewhere that ends up in Git. With DDEV:

```bash
ddev dotenv set .ddev/.env --google-places-api-key=YOUR_KEY_HERE
ddev restart
```

The flag `--google-places-api-key` becomes the environment variable
`GOOGLE_PLACES_API_KEY` inside the container. Do not commit `.ddev/.env`. If you
run the [Key](https://www.drupal.org/project/key) module you can reference that
variable from a Key entity so the value stays out of exported config.

## Fill in the Review Settings form

Go to **Configuration → Web services → Review Settings** and complete the fields:

- **API key** — the Google API key giving access to the Places API.
- **Place IDs** — one or more Place IDs whose reviews should be displayed.
- **Minimum rating to display** — reviews rated below this value are hidden from
  the block, though they still count toward the global rating.
- **Link to leave a review** *(optional)* — a URL added at the bottom of the block
  pointing visitors to where they can leave their own review.
- **Text of the review page link** *(optional)* — the label for that link.

Additional block-level options let you set the **number of messages to display**,
the **maximum age** of reviews shown, a **title** above the block, and whether to
show the **global review**. Save the form.

## Place the block

1. Go to **Structure → Block Layout** (`/admin/structure/block`).
2. In the region where you want the reviews, click **Place block**.
3. Find **Google reviews content block** in the list and click **Place block**
   next to it.
4. Configure the block options and save.

Reviews are imported on cron and can be refreshed with the *fetch reviews* button.
Because they arrive as an **unpublished** review content type, you can moderate
which ones become visible.

## A note on data flow

Fetching reviews sends requests to Google's Places API over HTTPS (outbound
egress), billed against your Google quota.
