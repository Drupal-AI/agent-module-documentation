# Configuration

Representative Image is configured **per content type** (or other bundle) by
adding a **Representative Image** field and telling it which existing image field
supplies the picture, plus what to do when there isn't one. Once configured, the
choice is available as a token you can use anywhere tokens are accepted.

## Add the Representative Image field

1. Go to **Structure → Content types → *(your type)* → Manage fields**.
2. Click **Add field** and choose the **Representative Image** field type.
3. Give it a label (for example, "Representative image") and save.

Repeat this for each content type that needs one — the beauty of the module is
that the *source* field can differ per type. For articles the representative image
might come from an `image` field; for another content type it might come from a
`logo` or media field.

## Configure the field settings

On the field's settings form, you tell it how to resolve the representative image:

- **Which image/media field to use** — select the existing image field (or Media
  reference field) on this content type whose value should be treated as the
  representative image. This is the per-type decision that makes the token
  meaningful.
- **What to do when there is no image** — define the fallback behaviour for
  entities that have no image in the chosen field. This is where you can specify a
  **default image** so consumers always receive something (useful for a
  guaranteed `og:image`, for instance).

Save the field settings. Image fields are supported directly, and Media
references are supported too (Media 2.x and newer).

## Control how it displays (optional)

On **Manage display** for the content type you can control how the Representative
Image field renders in each view mode, just like any other field — or leave it
hidden and use only its token.

## Use the token

The point of the module is the token. Once the field is configured, a token
resolving to the representative image (a full URL to the image) is available
wherever Drupal accepts tokens, for example:

- In a **Metatag** Open Graph pattern, to set `og:image` consistently per content
  type for social sharing.
- In a **Views** rewrite, to show a consistent listing thumbnail.
- In a **mail template** or digest, to include a representative image.
- In an **RSS feed** or anywhere else that consumes tokens.

Because the decision is made once per content type — with a fallback — every one
of these consumers gets the same answer, instead of each guessing at your field
structure and disagreeing.

> **Accessibility reminder:** setting a representative image does not give it alt
> text. Pair this with an alt-text solution so the image is accessible wherever it
> appears.
