# Configuration

Getting a slideshow onto your Bootstrap site takes three steps: add slideshow
content, adjust the carousel's user‑interface settings, and place the block in a
region.

## Permissions

The settings form is gated by the **Administer responsive slideshow** permission.
Grant it to the appropriate roles at **People → Permissions** (an administrator
has it by default).

## 1. Add slideshow content

The module created a **Responsive Slideshow** content type on install. Add
content of that type (**Content → Add content → Responsive Slideshow**) with the
images you want in the rotation. Each item becomes a slide in the carousel.

## 2. Adjust the slideshow settings

Open the module's settings form (registered as `responsive_slideshow.settings`,
under **Configuration**, behind the *Administer responsive slideshow*
permission). This is where a privileged user configures the **user‑interface
settings of the carousel** — the Bootstrap classes and display behavior of the
slideshow. Set these to match how you want the carousel to appear and behave,
then save.

> **Accessibility tip:** If your site has a conformance obligation, prefer
> settings that **disable auto‑advance** (or provide an accessible pause control)
> and verify that the carousel is fully keyboard‑operable. Bootstrap's carousel
> does not guarantee these on its own.

## 3. Place the block

1. Go to **Structure → Block layout**.
2. Place the **Responsive Slideshow** block in the region where you want the
   slideshow to appear. By default it is configured to appear on the **front
   page**.
3. Use the block's **Visibility** settings to control exactly where it shows
   (pages, content types, roles, and so on), then save.

Your Bootstrap‑styled, responsive slideshow now appears in the chosen region.
