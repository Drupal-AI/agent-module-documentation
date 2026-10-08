# Configuration

Unlike many modules, Easy LQP **needs** you to visit its settings form at least
once. Saving the form is what generates the responsive image styles the module
relies on — until you do, there is nothing for the formatter or Twig filter to
use.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Open the **Easy LQP settings form** from the admin configuration area. The
   generated styles it creates will appear afterwards under **Configuration →
   Media → Image styles**.

## The fields

The form describes the "ladder" of image sizes you want generated, and for which
aspect ratios:

- **Minimum width** — the smallest width (in pixels) to generate a style for.
  This is roughly the size of the low-quality placeholder end of the ladder.
- **Maximum width** — the largest width to generate. Set this to the widest your
  images are ever displayed at so the resizer always has a large enough style to
  load.
- **Preferred pixels between each image style (step)** — how far apart the
  generated widths are. A smaller step produces more, more finely-spaced styles
  (better fit, more styles to store); a larger step produces fewer styles.
- **Aspect ratios** — an optional list of ratios such as `4:3` and `16:9`. Easy
  LQP generates a full width-ladder for *each* ratio you list. For example, with
  4:3 and 16:9 you get `responsive_4_3_50w`, `responsive_16_9_50w`,
  `responsive_4_3_150w`, `responsive_16_9_150w`, and so on up to your maximum
  width.

## Save

Click **Save configuration**. Easy LQP immediately generates the image styles for
every width/ratio combination. You can verify them under **Configuration → Media
→ Image styles**.

> **Tip:** If you use cropping tools (such as Focal Point) at specific aspect
> ratios, apply the same crop to the generated Easy LQP styles so the low-quality
> placeholders keep the correct proportions.

## After saving — putting the styles to work

Generating the styles is only half the job; you then display your media through
them:

1. Create a **media view mode per aspect ratio** (for example a `16_9` view
   mode).
2. Either apply the **Easy LQP** field formatter to the image and choose the
   aspect ratio, or add a Twig template for the view mode (for example
   `media--image--16-9.html.twig`) that attaches the `easy_lqp/resizer` library
   and builds the `src` / `data-srcset` from the generated styles using the
   provided `image_url` Twig filter.
3. Render your media using the matching view mode wherever it appears. The
   resizer JavaScript measures the available width and loads the best-fit,
   optimised style over the blurred placeholder.
