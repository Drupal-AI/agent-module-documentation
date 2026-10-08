# Configuration

Star Rating's settings form is where you connect the rating widget to a
[Webform](https://www.drupal.org/project/webform) so that votes are mirrored into
Webform submissions and the average/summary blocks have data to read.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Star Rating**, or navigate directly
   to `/admin/config/content/star-rating`.

The settings are stored in the `star_rating.settings` configuration.

## The fields

The form maps the widget's data onto a Webform and its elements. You choose the
Webform, then tell the module which of that Webform's elements should receive each
piece of a rating submission:

- **Webform** (`webform_id`) — the Webform that ratings are written into. Each
  time a visitor rates something, the module creates a submission in this form. It
  is also the source the average and distribution-summary blocks read from, so
  pick (or first create) a Webform with fields for a rating value, a comment, and
  the id of the rated entity.
- **Rating element** (`rating_element`) — the machine name of the Webform element
  that stores the 1–5 star value.
- **Comment element** (`comment_element`) — the machine name of the Webform
  element that stores the optional free-text comment left with a rating.
- **Entity id element** (`entity_id_element`) — the machine name of the Webform
  element that records which node/entity the rating belongs to, so ratings can be
  aggregated per piece of content.

## Save

Click **Save configuration**. From then on, each rating submitted through the
widget is written both to the module's own `star_rating` table and to the
configured Webform, and the average and summary blocks compute their figures from
those Webform submissions. When a node has no ratings yet, the summary displays a
"No reviews yet" message.

