# Configure — settings form & config object

Settings form `ReviewSettingsForm` (`getFormId()` = `review_form`, extends
`ConfigFormBase`) at route **`google_reviews.review_settings`** → `/admin/review-settings`
(menu link "Review Settings" under Configuration ▸ Web services). Requires permission
`google_reviews admin`. All values are written to the single config object
**`google_reviews.settings`**.

The submit button is labelled **"Fetch reviews"**: its `#submit` runs `submitForm`
(save) then `fetchReviews`, which redirects to `google_reviews.add_reviews` (`/reviews`)
and imports reviews immediately. So saving the form both stores settings and pulls
reviews from Google.

## Fields

| Form field | Config key (under `google_reviews.settings`) | Widget | Required | Meaning |
|---|---|---|---|---|
| `api_key` | `google_reviews.api_key` | textfield | yes | Google API key with Places API access. |
| `place_id` | `google_reviews.place_id` | textfield | yes | One or more Google Place IDs. Multiple = separate with **`, `** (comma + space). |
| `minimum_rating` | `google_reviews.minimum_rating` | select `0`–`5` | yes | Reviews below this rating are hidden from the slider (still counted in the computed average). |
| `max_messages_displayed` | `google_reviews.max_messages_displayed` | number | no | Cap on how many review slides the block shows. Empty = all. |
| `max_time_displayed` | `google_reviews.max_time_displayed` | number (years) | no | Reviews older than N years are dropped from the block. Empty = no age limit. |
| `review_title` | `google_reviews.review_title` | textfield | no | Title shown above the block. |
| `display_rating` | `google_reviews.display_rating` | checkbox | no | Show the average rating computed from the retrieved reviews. |
| `display_global_rating` | `google_reviews.display_global_rating` | checkbox | no | Show Google's overall rating and total-ratings count (fetched, see below). |
| `review_page_link` | `google_reviews.review_page_link` | textfield (url) | no | Link to a "leave a review" page shown at the bottom of the block. |
| `review_page_message` | `google_reviews.review_page_message` | textfield | no | Text for that link. |

**Validation** (`validateForm`): `api_key` and `place_id` must be non-null;
`minimum_rating` must be numeric and 0–5.

## Keys written by the fetch (not on the form)

`ReviewService::importReview()` stores these into the same config object each time it
fetches a place:

| Config key | Source | Used by |
|---|---|---|
| `google_reviews.rating` | Google `result.rating` | block, when `display_global_rating` is on |
| `google_reviews.user_ratings_total` | Google `result.user_ratings_total` | block, when `display_global_rating` is on |

## Set config via PHP / Drush

The keys contain a literal `.`, so they nest under a top-level `google_reviews:` map in
the stored YAML.

```php
\Drupal::configFactory()->getEditable('google_reviews.settings')
  ->set('google_reviews.api_key', 'AIza...')
  ->set('google_reviews.place_id', 'ChIJxxxx, ChIJyyyy')
  ->set('google_reviews.minimum_rating', 3)
  ->set('google_reviews.max_messages_displayed', 6)
  ->set('google_reviews.display_rating', TRUE)
  ->save();
// Then trigger an import:
\Drupal::service('google_reviews.reviews_service')->getReviews();
```

```bash
drush config:set google_reviews.settings google_reviews.api_key 'AIza...' -y
drush config:set google_reviews.settings google_reviews.place_id 'ChIJxxxx, ChIJyyyy' -y
```

## Notes

- The module ships **no `config/schema/`** — `google_reviews.settings` is schema-less,
  so typed-config tooling (config inspector, translation) has no metadata for these keys.
- `config/optional/` ships the `review` node type and its fields plus a default
  entity form display; these install only when their dependencies (`node`, `menu_ui`,
  field modules) are present.
