# Configuration

## Open the settings form

1. Log in as a user with the **Administer dubbot configuration** permission.
2. Go to **Configuration → Content authoring → DubBot → Settings**, or navigate
   directly to `/admin/config/content/dubbot/settings`.

The form writes the `dubbot.settings` configuration object.

## Settings, field by field

- **Embed key** — the key you generate in your DubBot account. This is what
  authorizes the module to fetch your site's reports. When you save the form, DubBot
  validates the key against its API and rejects an invalid one, so a successful save
  confirms the connection works.
- **DubBot API URL** — the base URL for the DubBot API, defaulting to
  `https://api.dubbot.com`. Leave it as‑is unless DubBot gives you a different
  endpoint.
- **DubBot Report position** — how a page's report opens. Choose between:
  - **Side tray** (off‑canvas, the default) — slides in from the side.
  - **Top panel** (off‑canvas top) — drops down from the top of the screen.
  - **Modal** — opens in a centered dialog.
- **Preview Selector** — a CSS selector (default `#page`) identifying the wrapper
  around the page preview. If DubBot's issue highlighting doesn't line up correctly
  on your theme, point this at a more appropriate wrapper (for example
  `.region-content`).

Click **Save configuration** to store and validate the settings.

## The Overview page

Once a valid key is saved, the **Overview** page at **Configuration → Content
authoring → DubBot** (`/admin/config/content/dubbot`) lists crawled pages with their
issue counts and links to each page's report. Reports open in whichever position
you chose above. Access requires the **Access dubbot report** permission.

## The DubBot Report block

To show the current page's report inline, place the **DubBot Report** block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in your chosen region and select **DubBot Report** (in the
   *DubBot* category).
3. Its one setting is **Link color** (a hex color, default `#1b9ae4`) — set it to
   match your theme.
4. Save the block.

The block only shows something useful when a report exists for the current page and
the viewing user has report access.

## Permissions

DubBot's access is fine‑grained. Grant these at **People → Permissions**:

| Permission | Controls |
|-----------|----------|
| **Administer dubbot configuration** | The settings form (entering the embed key). |
| **Access dubbot report** | The Overview page and individual report links. |
| **View dubbot accessibility tab** | The Accessibility pane of a report. |
| **View dubbot spellcheck tab** | The Spell Check pane. |
| **View dubbot seo tab** | The SEO pane. |
| **View dubbot links tab** | The Broken Links pane. |
| **View dubbot practices tab** | The Best Practices pane. |
| **View dubbot governance tab** | The Web Governance pane. |

**Important behavior:** the per‑tab permissions only start filtering once a role has
*at least one* of them. A role with **no** tab permissions sees **all** panes; grant
a single tab permission (say, accessibility) and that role then sees *only* that tab.
So an accessibility‑only reviewer would get *Access dubbot report* plus *View dubbot
accessibility tab*, while a full QA role gets *Access dubbot report* plus every tab
permission.
