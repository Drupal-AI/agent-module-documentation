# Configuration

You configure Conditional Message by creating one or more **messages**, each with
its own text, appearance, and conditions.

## Open the message overview

1. Log in as a user with the **View conditional message overview** permission (add,
   edit, and delete are governed by their own permissions).
2. Go to **Content → Conditional message**, or navigate directly to
   `/admin/content/conditional-message`.

This listing shows all your messages. Click **Add** to create one, or edit an
existing message.

## Message content and appearance

- **Message** — the text of the banner. **HTML is allowed**, so you can include
  links or basic formatting.
- **Background colour** and **font colour** — set by colour name or hex value, so
  the banner blends with your site's design.
- **Position** — where the banner appears: **top** or **bottom** of the page.
- **Target selector** — optionally, a specific DOM element to use as the banner's
  container instead of the default position.

## Conditions — when the message appears

Enable and configure the conditions that decide who sees the message and where.
Available conditions include:

- **Display once per session** — show the message only once per browser session.
- **Until the user closes the message** — show a dismiss (close) button and
  remember the visitor's choice so it doesn't reappear.
- **Display to certain user roles** — limit the message to selected roles (this
  check is verified server-side).
- **Display on certain paths** — limit the message to specific URL paths.
- **Display on certain content types** — limit the message to pages of chosen
  content types.

You can combine conditions on a single message — for example role **and** path
**and** once-per-session together.

## Publish and translate

- Use the message's **published/unpublished** status to switch a message on or off
  without deleting it — handy for recurring notices.
- Messages are **translatable**: add a translation per language so visitors see the
  message in their language.

## Save

Save the message. Because conditions are checked in the browser (via a small AJAX
request), the banner works correctly even on heavily cached pages. Visit a page
that matches your conditions to confirm the banner appears as expected.

## A note on visibility of targeting rules

The endpoint that powers the role check returns each *published* message's
configured paths, roles, and content types to anyone who can view the page
(anonymous by default). This is display metadata that has to reach the browser
anyway, but don't rely on a message's targeting rules being secret.
