# Configuration

Configuration has two parts: **selecting which tawk.to widget to embed**, and
**controlling where and how it appears**. All screens require the **"administer
tawk_to settings"** permission.

## Selecting a widget

1. Go to **Configuration → Web services → Tawk.to**
   (`/admin/config/services/tawk_to`) and open the **widget** page
   (`/admin/config/services/tawk_to/widget`).
2. This page embeds tawk.to's own widget picker in a frame. **Log in to your
   tawk.to account** inside that frame and choose the widget (property) you want to
   use on this site.
3. Selecting it saves the widget's identifiers back to Drupal automatically. A
   **remove** action clears the selection if you want to take the widget off the
   site.

Once a widget is selected, the module knows to render
`https://embed.tawk.to/<property>/<widget>` in the page footer — subject to the
visibility conditions below.

> On multilingual sites, the widget selection honours per-language configuration
> overrides, so you can store a different widget per language.

## Extra settings — visibility, delay, and visitor info

Open the **Extra Settings** form (under the tawk.to admin section). It has three
groups:

- **Visibility** — a set of conditions, presented like block visibility settings
  (vertical tabs), built from Drupal's core Condition plugins: request path
  (pages), user roles, content types, language, and more. **All configured
  conditions must pass** for the widget to show, so you can, for example, show
  chat only to authenticated users on the support section, or hide it on checkout
  and admin pages. If you configure no conditions, the widget shows everywhere a
  widget is selected.
- **User info settings** — optionally pass the current visitor's details into the
  chat:
  - **Send user name** + a **name** token (default `[current-user:name]`).
  - **Send user email** + an **email** token (default `[current-user:mail]`).

  These use Drupal's token system, so the value is resolved per visitor.
- **Script load delay** — a number of **milliseconds** to wait before injecting
  the tawk.to script. Raising it can improve perceived page-load performance by
  letting the rest of the page load first. Default is `0` (no delay).

Save the form to apply your choices.

## When the widget actually appears

The chat widget renders only when **both** of these are true:

1. A widget has been selected (both its property and widget identifiers are set).
2. The configured visibility conditions all pass for the current page and visitor.

The widget is rendered through a lazy placeholder, so per-user data (like the
visitor name/email) doesn't pollute the page cache.

## Notes

- The identifiers are validated with strict patterns when saved from the picker,
  so a malformed value can't be stored.
- Because settings live in the `tawk_to.settings` config object, they export with
  the rest of your configuration and can be overridden per environment from
  `settings.php` if needed.
