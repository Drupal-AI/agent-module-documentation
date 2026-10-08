# Configuration

Swiffy Slider has no global settings form. You configure it where you use it — on
a field's display or on a Views display — and in both cases the key step is
pasting a **configuration URL** you generate on the swiffyslider.com configuration
page.

## Get your configuration URL

Go to <https://swiffyslider.com/configuration/>, customise the slider options
(arrows, dots, autoplay, number of slides, and so on) with the live preview, then
copy the **"Perma link"** it produces. This single URL carries all your chosen
options. Nothing is fetched from swiffyslider.com when your site renders the
slider — the URL is only a convenient way to transport the settings, and they are
applied locally.

## Option A — field formatter

Best when you have a multi‑value image or media field.

1. Build a multi‑value media (or entity‑reference) field on a content type — for
   example on the **Article** content type — and create a piece of content with at
   least two images in that field.
2. Go to that content type's **Manage display**
   (**Structure → Content types → Article → Manage display**).
3. Find the media field and, under **Format**, select **Swiffy Slider**.
4. Click the gear/cog **settings** icon next to the field, paste your copied
   Perma link into the setting, and save.

The field's images now render as a Swiffy Slider carousel.

## Option B — Views display format

Best for a slider of nodes, such as a teaser carousel.

1. Prepare a suitable teaser display for your content (for example title, a body
   trimmed to around 200 characters, and a teaser image).
2. Add a display to a node‑based View (for example the front page view).
3. Choose an **Unformatted list** of teasers or fields, as you prefer.
4. Set the display **Format** to **Swiffy Slider**.
5. In the format settings, paste your copied Perma link into the **Configuration
   URL** field, and save.

## Why only a configuration URL?

Swiffy Slider has a great many options. Rather than replicate every one of them as
Drupal form fields (which would add a lot of complexity to the back‑end forms),
the module lets you configure everything visually on the swiffyslider.com page —
with a live preview — and then carry those settings in one URL. If you would
prefer all the settings exposed directly in the Drupal admin, the maintainers
suggest building a complementary module for that.

## Accessibility and known issues

- Keyboard scrolling and screen‑reader traversal work by default because the
  slider is a scrolling container, but still confirm the controls show **visible
  focus**, and add a **pause control** if the slider auto‑advances.
- **Known issue:** the loop behaviour (jumping from the last item back to the
  first) does not work when snap behaviour is active.
