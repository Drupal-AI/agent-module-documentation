# Configuration

Getting Google Reviews running is a four‑step flow: enter your credentials and display
options, import the reviews, publish the ones you want, and place the block.

## 1. Open the settings form

1. Log in as a user with the **Google reviews module admin** permission.
2. Go to **Configuration → Web services → Review Settings** (`/admin/review-settings`).

Fill in the fields:

- **API key** *(required)* — your Google Places API key.
- **Place IDs** *(required)* — one or more Google Place IDs. To list several, separate them
  with a **comma and a space** (`, `) — for example `ChIJ...ABC, ChIJ...XYZ`. Each Place ID is
  a business location, so this is how you aggregate reviews from multiple locations.
- **Minimum rating** *(0–5)* — reviews below this rating are hidden from the slider. Note they
  still count toward the computed average.
- **Max displayed messages** — the maximum number of reviews the slider shows at once.
- **Max review time (years)** — reviews older than this many years are skipped.
- **Title above block** — an optional heading rendered above the reviews.
- **Display computed rating** — show the average rating calculated from the imported reviews.
- **Display global rating** — show Google's own reported overall rating and total review count.
- **Review page link** and **link text** — an optional "Leave us a review" call‑to‑action URL
  and its label, shown under the slider.

The form's save button is labelled **Fetch reviews**: when you save, it stores your settings
and immediately runs an import.

> **A note on the API key.** The key is stored in the `google_reviews.settings` config object.
> If you export configuration to code, consider overriding the key from an environment variable
> in `settings.php` rather than committing it — and in Google Cloud, restrict the key (by API
> and by referrer/site) so a leaked key can't be misused.

## 2. Import the reviews

Reviews are imported in three ways:

- **On save** — clicking **Fetch reviews** on the settings form runs an import right away.
- **On demand** — visiting `/reviews` (permission‑gated) triggers a fresh import.
- **On cron** — every cron run imports any new reviews automatically, so the block stays
  current without manual work.

Each import calls the Google Places API for every Place ID and creates a `review` node for any
review it hasn't imported before (it deduplicates by author and rating).

## 3. Publish the reviews you want to show

Imported reviews are created **unpublished** on purpose — this is your moderation gate. Go to
**Content** (`/admin/content`), filter to the *Review* content type, review the imported items,
and **publish** the ones you want visible. Only published reviews appear in the slider.

## 4. Place the reviews block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the slider, click **Place block** and choose **Google reviews
   content block** (category *Reviews*).
3. Save the block.

The block loads your published review nodes, drops any below the minimum rating or older than
the maximum age, computes the average, and renders them as a Swiper carousel with star icons.

## Permission

One permission governs the module:

- **Google reviews module admin** (`google_reviews admin`) — grants access to the settings form
  and the `/reviews` fetch route. It only configures the module and triggers imports, so grant
  it to trusted editors and administrators.

## Reusing the review data elsewhere

Because each review is a normal Drupal node with `field_review_name`, `field_review_rating`,
`field_review_message`, and related fields, you can build your own Views listings, testimonials
sections, or displays from the same data instead of (or alongside) the bundled slider.
