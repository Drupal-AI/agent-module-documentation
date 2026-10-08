# Configuration

Image Effect has no separate settings form — you configure it entirely through
Drupal's core **image styles** editor by adding its effect to a style and setting the
effect's parameters. Any image field displayed with that style then gets the effect
applied to its derivatives.

## Add the effect to an image style

1. Log in as a user with the **Administer image styles** permission.
2. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`).
3. Either click **Add image style** to create a new one, or **Edit** an existing
   style.
4. In the **Effect** dropdown (labelled *Select a new effect*), choose the **advance
   resize** effect provided by this module, then click **Add**.

## Set the effect's parameters

On the effect's configuration screen you set the target size:

- **Width** and **Height** — the exact dimensions you want the resulting image to
  fit. The effect resizes the image to fit these dimensions **without cropping,
  stretching, or distorting** the content, and pads any leftover space with a white or
  transparent background so the output matches the box exactly.

Enter your values and click **Add effect** (or **Update effect** when editing).

## Save the style

Back on the image-style edit page, click **Save**. The effect now runs whenever a
derivative for that style is generated.

## Use the style

Apply the style like any other: on an entity's **Manage display**, set an image
field's formatter to **Image** and choose your style, or reference the style from a
responsive image style. Existing derivatives are regenerated as needed; if you change
the effect later, you can flush the style's derivatives from the image-styles page to
force regeneration.

## Choosing the toolkit

The effect works with both GD and ImageMagick. Which one is used is decided by
Drupal's global image toolkit setting under **Configuration → Media → Image toolkit**
(`/admin/config/media/image-toolkit`) — there is nothing toolkit-specific to set on
the effect itself.
