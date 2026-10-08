# Configuration

All of this module's settings live on the block itself — there is no separate
site-wide settings page. You configure it when you place the block, and you can
reopen the same form any time to adjust it.

## Place the block

1. Log in as a user with permission to administer blocks.
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** in the region where you want the contact details to
   appear, find **Social Contact Block** in the list, and place it.
4. The block-configuration form opens. Its settings are saved with this block
   instance (using a typed config schema), so two placements of the block can hold
   completely different content.

The form is divided into a **contact** section and a **social / channels**
section.

## Contact section

- **Contact title** — an optional heading shown above the contact group.
- For each contact field — **Address**, **E-mail**, **Phone**, **Mobile**,
  **FAX**, and **Working hours** — you get:
  - an **Enabled** toggle, so you can leave out anything you don't need;
  - a custom **Label** (if you leave it blank, the field name is used);
  - the **value**, with the option of additional values for the multi-valued
    fields;
  - a **weight** for ordering the items within the section.

A few fields behave specially:

- **Address** accepts rich text.
- **E-mail** is validated and can hold several addresses; each becomes an
  automatic `mailto:` link.
- **Phone** and **Mobile** are validated (5–20 digits) and rendered as `tel:`
  links.
- **Working hours** lets you enter open/close times per day of the week.

## Social / channels section

- **Social title** — an optional heading shown above the social group.
- For each channel — Facebook, LinkedIn, X, YouTube, Pinterest, Instagram,
  WhatsApp, Telegram, Slack, Google Maps, Discord, GitHub, Dribbble — you get an
  enable toggle, a custom label, the URL or handle, and a weight.

Some conveniences worth knowing:

- URLs are normalised — if you forget the `https://`, it is added for you.
- A WhatsApp number is turned into a `https://wa.me/<digits>` link, and a Telegram
  username into a `https://t.me/<user>` link.
- **Google Maps** can either link out, or render an embedded map: paste an embed
  URL, or a full `<iframe>` tag and the module will extract the `src` from it.

## Choosing an icon per social link

Each social link can carry an icon. Pick one of three **icon types**:

- **CSS class** — for an icon font such as Font Awesome; type the icon's classes.
  The value is filtered for safety before output.
- **Custom SVG markup** — paste inline SVG; it is sanitised (run through an XSS
  filter with an allow-list of SVG tags) before it is rendered.
- **No icon** — a plain text link.

## Ordering and saving

Reorder any contact or social item using its **weight**. When you're happy, save
the block configuration. Social links open in a new tab and carry `rel` security
attributes automatically. To change anything later, return to **Block layout**,
find your placed block, and choose **Configure**.
