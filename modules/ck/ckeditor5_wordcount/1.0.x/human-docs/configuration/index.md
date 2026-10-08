# Configuration

The counter appears automatically once the module is enabled, so this form is
about setting **limits and warnings**. If you never open it, the count still
displays — you just won't have limits or colour warnings.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → CKEditor 5 Word Count Settings**,
   or navigate directly to `/admin/config/content/ckeditor5-wordcount`.

## The settings, field by field

- **Enable word limit** and **Maximum words** — turn on a word cap and set the
  maximum number of words (for example 500). When enabled, the live count shows
  as *current / limit*.
- **Enable character limit** and **Maximum characters** — turn on a character cap
  and set the maximum number of characters (for example 2000). Word and character
  limits are independent — you can use either, both, or neither.
- **Warning threshold (%)** — the percentage of a limit at which the editor
  switches to its yellow "approaching the limit" state. The default is **90%**.
  Below the threshold the editor looks normal; from the threshold up to the limit
  it turns yellow; over the limit it turns red.

The limits are **non-blocking** — an editor can save content that exceeds them —
so they act as clear guidance rather than a hard stop.

## Save

Click **Save configuration**. Changes take effect immediately, without a full
cache clear — reload a content edit form and the new limits and warning colours
apply right away.
